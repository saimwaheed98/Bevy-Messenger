import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:bevy_messenger/pages/chatpage/data/model/message_model.dart';
import 'package:bevy_messenger/pages/chatpage/domain/usecases/send_group_message_usecase.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_user_data_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '../../../../../bloc/cubits/auth_cubit.dart';
import '../../../../../bloc/cubits/send_notification_cubit.dart';
import '../../../../../core/di/service_locator_imports.dart';
part '../state/send_group_message_state.dart';

class SendGroupMessageCubit extends Cubit<SendGroupMessageState> {
  final SendMessageGroupUseCase _sendMessageGroupUseCase;
  SendGroupMessageCubit(this._sendMessageGroupUseCase)
      : super(SendGroupMessageInitial());

  // send the message in the group
  Future<void> sendGroupMessage(
      String message, String secMessage, MessageType messageType) async {
    final GetUserDataCubit getUserDataCubit = Di().sl<GetUserDataCubit>();
    final AuthCubit authCubit = Di().sl<AuthCubit>();
    final SendNotificationCubit sendNotificationCubit =
        Di().sl<SendNotificationCubit>();
    emit(SendingGroupMessage());
    var time = DateTime.now().millisecondsSinceEpoch.toString();
    var uuid = const Uuid().v4();
    // sendFileMessageCubit.sendingMessageId = uuid;
    MessageModel messageModel = MessageModel(
      chatId: getUserDataCubit.groupData.id,
      message: message,
      messageId: uuid,
      read: "",
      sent: time,
      receiverUsername: getUserDataCubit.userData.name,
      senderUsername: authCubit.userData.name,
      secMessage: secMessage,
      type: messageType.name,
      userOnlineState: getUserDataCubit.userOnlineState,
      senderId: authCubit.userData.id,
      receiverId: getUserDataCubit.groupData.id,
      reciverImage: getUserDataCubit.groupData.imageUrl,
      senderImage: authCubit.userData.imageUrl,
    );
    await _sendMessageGroupUseCase
        .sendMessageGroup(getUserDataCubit.groupData, messageModel)
        .then((value) async {
      if (value.contains("success")) {
        List<String> members = getUserDataCubit.groupData.members.where((element) => element != authCubit.userData.id).toList();
        await sendNotificationCubit.sendNotification(
            body: message,
            title: authCubit.userData.name,
            data: {
              "screen": "group_chat",
              "room_id": getUserDataCubit.groupData.id,
            },
            userIds: members,
            userId: "");
        await AuthDataSource.sendGroupNotification(
            getUserDataCubit.groupData.members,
            message,
            getUserDataCubit.groupData.id);
        emit(GroupMessageSent());
      } else {
        emit(GroupMessageNotSent());
      }
    });
  }
}
