import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_messages_cubit.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_user_data_cubit.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/widgets/message_list.dart';
import 'package:bevy_messenger/pages/chatroom/presentation/bloc/cubit/update_user_group_online_cubit.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:bevy_messenger/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/chat_app_bar.dart';
import '../widgets/user_input_field.dart';

@RoutePage()
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    _authCubit.updateOnlineStatus(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_getUserDataCubit.chatStatus == ChatStatus.group && _getUserDataCubit.groupData.id.isNotEmpty) {
      _updateUserGroupOnlineCubit.updateGroupUserOnlineBySystem(
        _getUserDataCubit.groupData.id,
      );
      _updateUserGroupOnlineCubit.updateGroupUserOnline(
        _getUserDataCubit.groupData.id,
      );
      log("build method");
    }
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (_getUserDataCubit.chatStatus == ChatStatus.group && _getUserDataCubit.groupData.id.isNotEmpty) {
          _updateUserGroupOnlineCubit.removeOnlineStatus(
            _getUserDataCubit.groupData.id,
          );
        }
        _authCubit.updateOnlineStatus(false);
        log("pop scope");
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        onScaleStart: (details) {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: AppColors.textSecColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(child: ChatAppBar()),
              BlocBuilder(
                bloc: _getMessagesCubit,
                builder: (context,state) {
                  return const MessageList();
                }
              ),
              const SizedBox(
                height: 15,
              ),
              const UserInputField()
            ],
          ),
        ),
      ),
    );
  }
}

final GetMessagesCubit _getMessagesCubit = Di().sl<GetMessagesCubit>();
final GetUserDataCubit _getUserDataCubit = Di().sl<GetUserDataCubit>();
final UpdateUserGroupOnlineCubit _updateUserGroupOnlineCubit =
    Di().sl<UpdateUserGroupOnlineCubit>();
final AuthCubit _authCubit = Di().sl<AuthCubit>();
