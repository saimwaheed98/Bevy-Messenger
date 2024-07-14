import 'package:bevy_messenger/pages/privatechats/presentation/bloc/cubit/get_private_chat_cubit.dart';
import 'package:bevy_messenger/utils/screen_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator_imports.dart';
import 'recent_chat_container.dart';

class RecentChatList extends StatelessWidget {
  RecentChatList({super.key});

  final GetPrivateChatCubit _getPrivateChatCubit =
      Di().sl<GetPrivateChatCubit>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getHeight(context) * 0.1,
      child: BlocBuilder(
        bloc: _getPrivateChatCubit,
        builder: (context, state) {
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _getPrivateChatCubit.chatUsers.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var user = _getPrivateChatCubit.chatUsers[index];
                return RecentChatContainer(
                  userModel: user,
                );
              });
        },
      ),
    );
  }
}
