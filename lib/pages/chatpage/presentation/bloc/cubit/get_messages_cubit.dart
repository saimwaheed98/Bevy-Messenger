import 'dart:developer';
import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:bevy_messenger/pages/chatpage/data/model/message_model.dart';
import 'package:bevy_messenger/pages/chatpage/domain/usecases/get_messages_usecase.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_user_data_cubit.dart';
import 'package:bevy_messenger/utils/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../../../bloc/cubits/auth_cubit.dart';
import '../../../../../core/di/service_locator_imports.dart';
import '../../../../../helper/conversation_id_getter.dart';
import 'send_file_message_cubit.dart';
part '../state/get_messages_state.dart';

class GetMessagesCubit extends Cubit<GetMessagesState> {
  final GetMessagesUseCase _getMessagesUseCase;
  GetMessagesCubit(this._getMessagesUseCase) : super(GetMessagesInitial());

  final ScrollController scrollController = ScrollController();

  List<MessageModel> messages = [];

  // stream for getting messages
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages() {
    final GetUserDataCubit getUserData = Di().sl<GetUserDataCubit>();
    return _getMessagesUseCase.getMessages(getUserData.userData.id);
  }

  getData(List<MessageModel> messages) {
    emit(GettingMessages());
    this.messages = messages;
    getMedia();
    getDocs();
    log("message $messages");
    emit(MessagesGetted(messages));
  }


  // convert the data of messages in dialog
  int messageValue = 0;

  changeValue(int value){
    emit(GettingMessages());
    messageValue = value;
    emit(MessagesGetted(messages));
  }


  // get the media from the messages
  List<MessageModel> mediaMessages = [];

  getMedia() {
    emit(GettingMessages());
    var list = messages
        .where((element) =>
            element.type == MessageType.image.name ||
            element.type == MessageType.video.name)
        .toList();
    mediaMessages = list;
    emit(MessagesGetted(messages));
  }

  // get the docs from the messages
  List<MessageModel> docsMessages = [];

  getDocs() {
    emit(GettingMessages());
    var list = messages
        .where((element) =>
    element.type == MessageType.file.name)
        .toList();
    docsMessages = list;
    emit(MessagesGetted(messages));
  }


   getMessage() {
    final GetUserDataCubit getUserData = Di().sl<GetUserDataCubit>();
    emit(GettingMessages());
    _getMessagesUseCase
        .getMessages(getUserData.chatStatus == ChatStatus.user
            ? getUserData.userData.id
            : getUserData.groupData.id)
        .listen((event) {
      getData(event.docs.map((e) => MessageModel.fromJson(e.data())).toList());
      // messages =
      //     event.docs.map((e) => MessageModel.fromJson(e.data())).toList();
      emit(MessagesGetted(
          event.docs.map((e) => MessageModel.fromJson(e.data())).toList()));
    });
  }

  // update the message read status
  updateMessageReadStatus(String chatId, String messageId) async {
    var time = DateTime.now().millisecondsSinceEpoch.toString();
    await AuthDataSource.firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(messageId)
        .update({'read': time,"userOnlineState" : true});
  }

  // update the message read status
  updateUserOnlineStatusForMessage(String chatId, String messageId) async {
    await AuthDataSource.firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(messageId)
        .update({"userOnlineState" : true});
  }


  // add the message in the messages list locally
  Future<void> sendFirstMessage(String message, MessageType type) async {
    final SendFileMessageCubit sendFileMessageCubit = Di().sl<SendFileMessageCubit>();
    var uid = const Uuid().v4();
    final AuthCubit authCubit = Di().sl<AuthCubit>();
    var time = DateTime.now().millisecondsSinceEpoch.toString();
    final GetUserDataCubit getUserDataCubit = Di().sl<GetUserDataCubit>();
    emit(GettingMessages());
    sendFileMessageCubit.sendingMessageId = uid;
    MessageModel chatData = MessageModel(
      chatId: conversationId(getUserDataCubit.userData.id),
      message: message,
      messageId: uid,
      read: "",
      sent: time,
      secMessage: "",
      userOnlineState: getUserDataCubit.userData.userInternetState,
      receiverUsername: getUserDataCubit.userData.name,
      senderUsername: authCubit.userData.name,
      type: type.name,
      senderId: authCubit.userData.id,
      receiverId: getUserDataCubit.userData.id,
      reciverImage: getUserDataCubit.userData.imageUrl ,
      senderImage: authCubit.userData.imageUrl,
    );
    messages.add(chatData);
    emit(MessagesGetted(messages));
  }
}
