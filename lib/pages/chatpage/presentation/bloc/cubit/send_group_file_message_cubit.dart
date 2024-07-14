import 'dart:developer';
import 'dart:io';
import 'package:bevy_messenger/pages/chatpage/domain/usecases/send_group_file_message_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import '../../../../../bloc/cubits/auth_cubit.dart';
import '../../../../../core/di/service_locator_imports.dart';
import '../../../data/model/message_model.dart';
import 'get_user_data_cubit.dart';
part '../state/send_group_file_message_state.dart';

class SendGroupFileMessageCubit extends Cubit<SendGroupFileMessageState> {
  final SendGroupFileMessageUseCase _sendFileMessageUseCase;
  SendGroupFileMessageCubit(this._sendFileMessageUseCase)
      : super(SendGroupFileMessageInitial());

  bool isSending = false;

  // send the file message
  Future<void> sendFileMessage(
      File file, String message, String secMessage, MessageType type) async {
        // final SendFileMessageCubit sendFileMessageCubit = Di().sl<SendFileMessageCubit>();
    var uid = const Uuid().v4();
    // sendFileMessageCubit.sendingMessageId = uid;
    final AuthCubit authCubit = Di().sl<AuthCubit>();
    var time = DateTime.now().millisecondsSinceEpoch.toString();
    final GetUserDataCubit getUserDataCubit = Di().sl<GetUserDataCubit>();
    emit(SendGroupFileMessageLoading());
    isSending = true;
    //  get the data of the message
    MessageModel messageData = MessageModel(
      chatId: getUserDataCubit.groupData.id,
      message: message,
      messageId: uid,
      read: "",
      sent: time,
      receiverUsername: getUserDataCubit.userData.name,
      senderUsername: authCubit.userData.name,
      secMessage: secMessage,
      type: type.name,
      userOnlineState: getUserDataCubit.userOnlineState,
      senderId: authCubit.userData.id,
      receiverId: getUserDataCubit.userData.id,
      reciverImage: getUserDataCubit.userData.imageUrl,
      senderImage: authCubit.userData.imageUrl,
    );
    await _sendFileMessageUseCase.sendGroupFileMessage(file, messageData);
    isSending = false;
    log(message);
    emit(SendGroupFileMessageSuccess());
  }
}
