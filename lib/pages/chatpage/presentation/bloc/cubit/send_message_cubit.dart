import 'dart:developer';

import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:bevy_messenger/helper/conversation_id_getter.dart';
import 'package:bevy_messenger/pages/chatpage/data/model/message_model.dart';
import 'package:bevy_messenger/pages/chatpage/domain/usecases/send_message_usecase.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_user_data_cubit.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/send_group_message_cubit.dart';
import 'package:bevy_messenger/utils/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '../../../../../bloc/cubits/send_notification_cubit.dart';
import 'send_file_message_cubit.dart';
part '../state/send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  final SendMessageUseCase _sendMessageUseCase;
  SendMessageCubit(this._sendMessageUseCase) : super(SendMessageInitial());

  Future<void> sendMessage(
      String message, String secMessage, MessageType type) async {
    var uid = const Uuid().v4();
    final AuthCubit authCubit = Di().sl<AuthCubit>();
    var time = DateTime.now().millisecondsSinceEpoch.toString();
    final GetUserDataCubit getUserDataCubit = Di().sl<GetUserDataCubit>();
        final SendNotificationCubit sendNotificationCubit =
        Di().sl<SendNotificationCubit>();
    final SendGroupMessageCubit sendGroupMessageCubit =
        Di().sl<SendGroupMessageCubit>();
    final SendFileMessageCubit sendFileMessageCubit =
        Di().sl<SendFileMessageCubit>();
    sendFileMessageCubit.isSending = true;
    sendFileMessageCubit.sendingFailed = false;
    emit(SendMessageLoading());
    if (getUserDataCubit.chatStatus == ChatStatus.group) {
      try {
        sendGroupMessageCubit.sendGroupMessage(message, secMessage, type);
        sendFileMessageCubit.isSending = false;
      } catch (e) {
        sendFileMessageCubit.isSending = false;
        sendFileMessageCubit.sendingFailed = true;
        log("error sending message $e");
      }
      return;
    } else {
      try {
        MessageModel chatData = MessageModel(
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
        await _sendMessageUseCase.sendMessage(chatData);
        sendFileMessageCubit.isSending = false;
        await sendNotificationCubit.sendNotification(title: message, body: authCubit.userData.name, userId: getUserDataCubit.userData.id);
        // await AuthDataSource.sendPushNotification(
        //   getUserDataCubit.userData.pushToken,
        //   message,
        //   authCubit.userData.id,
        // );
      } catch (e) {
        log("Error sending messsage $e");
        sendFileMessageCubit.isSending = false;
        sendFileMessageCubit.sendingFailed = true;
      }
    }
    log("Message Sent");
    log("user token ${getUserDataCubit.userData.id}");
    emit(SendMessageSuccess());
  }

  Future<void> sendFirstMessage(String message, MessageType type) async {
    var uid = const Uuid().v4();
    final AuthCubit authCubit = Di().sl<AuthCubit>();
    var time = DateTime.now().millisecondsSinceEpoch.toString();
    final GetUserDataCubit getUserDataCubit = Di().sl<GetUserDataCubit>();
    final SendNotificationCubit sendNotificationCubit =
        Di().sl<SendNotificationCubit>();
    emit(SendMessageLoading());
    MessageModel chatData = MessageModel(
      chatId: conversationId(getUserDataCubit.userData.id),
      message: message,
      messageId: uid,
      read: "",
      sent: time,
      secMessage: "",
      userOnlineState: getUserDataCubit.userOnlineState,
      receiverUsername: getUserDataCubit.userData.name,
      senderUsername: authCubit.userData.name,
      type: type.name,
      senderId: authCubit.userData.id,
      receiverId: getUserDataCubit.userData.id,
      reciverImage: getUserDataCubit.userData.imageUrl,
      senderImage: authCubit.userData.imageUrl,
    );
    await _sendMessageUseCase.sendFirstMessage(chatData);
    await sendNotificationCubit.sendNotification(title: message, body: authCubit.userData.name, userId: getUserDataCubit.userData.id);
    // await AuthDataSource.sendPushNotification(
    //   getUserDataCubit.userData.pushToken,
    //   message,
    //   authCubit.userData.id,
    // );
    log(message);
    emit(SendMessageSuccess());
  }
}
