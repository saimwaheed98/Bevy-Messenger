import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
// import 'package:bevy_messenger/pages/privatechats/presentation/bloc/cubit/get_private_chat_cubit.dart';
// import 'package:bevy_messenger/pages/privatechats/presentation/widgets/all_conversation_list.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/colors.dart';
import '../../../chatroom/presentation/bloc/cubit/get_groups_cubit.dart';
import '../../../chatroom/presentation/widgets/groups_list.dart';
import '../widgets/block_user_container.dart';

@RoutePage()
class PrivateChatPage extends StatelessWidget {
  const PrivateChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textSecColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const AppTextStyle(
                  text: 'Your Bevy',
                  fontSize: 23,
                  fontWeight: FontWeight.w700),
              const SizedBox(
                height: 21,
              ),
              // const AppTextStyle(
              //     text: 'Recent Chats',
              //     fontSize: 14,
              //     color: AppColors.textColor,
              //     fontWeight: FontWeight.w700),
              // const SizedBox(
              //   height: 15,
              // ),
              // RecentChatList(),
              BlocBuilder(
                bloc: _authCubit,
                builder: (context, state) {
                  return _authCubit.userData.blockedUsers.isNotEmpty ? const BlockUserContainer() : const SizedBox();
                },
              ),
              BlocBuilder(
                bloc: _getGroupsCubit,
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: AppTextStyle(
                        text:
                            'All Conversations ( ${_getGroupsCubit.freeGroups.length} )',
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  );
                },
              ),
              // AllConverationList(),
              const GroupsList(
                premium: false,
              ),
              const SizedBox(
                height: 90,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final AuthCubit _authCubit = Di().sl<AuthCubit>();
// final GetPrivateChatCubit _getPrivateChatCubit = Di().sl<GetPrivateChatCubit>();
final GetGroupsCubit _getGroupsCubit = Di().sl<GetGroupsCubit>();
