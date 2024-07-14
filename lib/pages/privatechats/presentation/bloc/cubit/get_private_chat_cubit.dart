import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../signup/data/models/usermodel/user_model.dart';
import '../../../domain/usercases/get_private_chat_usecase.dart';

part '../state/get_private_chat_state.dart';

class GetPrivateChatCubit extends Cubit<GetPrivateChatState> {
  final GetPrivateChatUseCase getPrivateChatUseCase;
  GetPrivateChatCubit(this.getPrivateChatUseCase)
      : super(GetPrivateChatInitial());

  List<UserModel> chatUsers = [];
  List<UserModel> recentChats = [];
  List<UserModel> blockedUsersList = [];

    // get recent chats by filtering the data
  getBlockedChats(List<UserModel> chatUsers) {
    emit(GetPrivateChatLoading());
    blockedUsersList = chatUsers;
    emit(GetPrivateChatLoaded());
  }

  // stream for getting chats
  Stream<QuerySnapshot<Map<String, dynamic>>> getPrivateChats(
      List<String> ids) {
    emit(GetPrivateChatLoading());
    return getPrivateChatUseCase.getPrivateChatRooms(ids);
  }

  // get recent chats by filtering the data
  getChats(List<UserModel> chatUsers) {
    emit(GetPrivateChatLoading());
    // chatUsers.sort((a, b) => a.hashCode.compareTo(b.hashCode));
    this.chatUsers = chatUsers;
    emit(GetPrivateChatLoaded());
  }

  // remove the user from the list 
  removeUser(UserModel user) {
    emit(GetPrivateChatLoading());
    blockedUsersList.remove(user);
    emit(GetPrivateChatLoaded());
  }
}
