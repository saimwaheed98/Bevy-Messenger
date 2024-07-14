import 'package:bevy_messenger/pages/chatroom/presentation/page/chat_room_page.dart';
import 'package:bevy_messenger/pages/userProfile/presentation/page/user_profile_page.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../addusers/presentation/page/add_users_page.dart';
import '../../../../privatechats/presentation/page/private_chat_page.dart';

part '../state/bottom_bar_state.dart';

class BottomBarCubit extends Cubit<BottomBarState> {
  BottomBarCubit() : super(BottomBarInitial());

  List<Widget> screens = [
    const AddUserPage(
      isAdding: false,
      isAddingInfo: false,
    ),
    const UserProfilePage(
      isGroup: false,
    ),
    const ChatRoomPage(),
    // const GroupList(title: "Communities", premium: false),
    const PrivateChatPage(),
  ];
  int currentIndex = 0;

  changeIndex(int index) {
    emit(BottomBarChanging());
    currentIndex = index;
    emit(BottomBarChanged());
  }
}
