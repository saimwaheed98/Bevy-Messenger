import 'dart:developer';
import 'dart:io';

import 'package:bevy_messenger/pages/chatpage/data/model/message_model.dart';
import 'package:bevy_messenger/pages/chatpage/domain/usecases/send_file_message_usecase.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/send_group_file_message_cubit.dart';
import 'package:bevy_messenger/utils/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '../../../../../bloc/cubits/auth_cubit.dart';
import '../../../../../bloc/cubits/send_notification_cubit.dart';
import '../../../../../core/di/service_locator_imports.dart';
import '../../../../../helper/conversation_id_getter.dart';
import 'get_user_data_cubit.dart';

part '../state/send_file_message_state.dart';

class SendFileMessageCubit extends Cubit<SendFileMessageState> {
  final SendFileMessageUseCase _fileMessageUseCase;
  SendFileMessageCubit(this._fileMessageUseCase)
      : super(SendFileMessageInitial());

  bool isSending = false;
  String sendingMessageId = "";
  bool sendingFailed = false;

  // send the file message
  Future<void> sendFileMessage(
      File file, String message, String secMessage, MessageType type) async {
    // get the value of message
    var uid = const Uuid().v4();
    var time = DateTime.now().millisecondsSinceEpoch.toString();
    // cubits
    final AuthCubit authCubit = Di().sl<AuthCubit>();
    final GetUserDataCubit getUserDataCubit = Di().sl<GetUserDataCubit>();
    final SendGroupFileMessageCubit sendGroupFileMessageCubit =
        Di().sl<SendGroupFileMessageCubit>();
    final SendNotificationCubit sendNotificationCubit =
        Di().sl<SendNotificationCubit>();
    emit(SendFileMessageLoading());
    try {
      sendingFailed = false;
      isSending = true;
      log("Sendnig ${getUserDataCubit.userData.id}");
      if (getUserDataCubit.chatStatus == ChatStatus.group) {
        await sendGroupFileMessageCubit.sendFileMessage(
            file, message, secMessage, type);
        log("Sendnig message in group");
        isSending = false;
        emit(SendFileMessageSuccess());
        return;
      } else {
        //  get the data of the message
        MessageModel messageData = MessageModel(
          chatId: conversationId(getUserDataCubit.userData.id),
          message: message,
          messageId: uid,
          read: "",
          sent: time,
          secMessage: secMessage,
          receiverUsername: getUserDataCubit.userData.name,
          senderUsername: authCubit.userData.name,
          type: type.name,
          userOnlineState: getUserDataCubit.userOnlineState,
          senderId: authCubit.userData.id,
          receiverId: getUserDataCubit.userData.id,
          reciverImage: getUserDataCubit.userData.imageUrl,
          senderImage: authCubit.userData.imageUrl,
        );
        await _fileMessageUseCase.sendFileMessage(file, messageData);
        await sendNotificationCubit.sendNotification(
            body: "Sented a file",
            title: authCubit.userData.name,
            userId: getUserDataCubit.userData.id);
        isSending = false;
        log("Sendnig message in users");
        emit(SendFileMessageSuccess());
      }
    } catch (e) {
      isSending = false;
      sendingFailed = true;
      log("Error in sending file message $e");
      emit(SendFileMessageFailure());
    }
  }
}
