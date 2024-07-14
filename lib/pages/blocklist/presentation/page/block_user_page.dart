
import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/pages/blocklist/presentation/widgets/block_users_list.dart';
import 'package:bevy_messenger/pages/privatechats/presentation/bloc/cubit/get_private_chat_cubit.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/colors.dart';

@RoutePage()
class BlockUserPage extends StatelessWidget {
  const BlockUserPage({super.key});

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AppTextStyle(
                      text: 'Blocked users',
                      fontSize: 23,
                      fontWeight: FontWeight.w700),
                      IconButton(onPressed: (){
                        AutoRouter.of(context).pop();
                      }, icon: const Icon(Icons.arrow_back,color: AppColors.textColor,))
                ],
              ),
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
                bloc: _getPrivateChatCubit,
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: AppTextStyle(
                        text:
                            'Blocked Conversations ( ${_getPrivateChatCubit.blockedUsersList.length} )',
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  );
                },
              ),
              BlockUsersList()
            ],
          ),
        ),
      ),
    );
  }
}

final AuthCubit _authCubit = Di().sl<AuthCubit>();
final GetPrivateChatCubit _getPrivateChatCubit = Di().sl<GetPrivateChatCubit>();




