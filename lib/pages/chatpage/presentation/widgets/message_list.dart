import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_messages_cubit.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/widgets/messages_container/other_message_container.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/widgets/messages_container/user_message_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator_imports.dart';
import '../../../../utils/colors.dart';

class MessageList extends StatefulWidget {
  const MessageList({super.key});

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  final GetMessagesCubit _getMessagesCubit = Di().sl<GetMessagesCubit>();
  final AuthCubit _authCubit = Di().sl<AuthCubit>();

  @override
  void initState() {
    super.initState();
    _getMessagesCubit.getMessage();
    // _getMessagesCubit.stream.listen((state) {
    //   if (state is GettingMessages) {
    //     SchedulerBinding.instance.scheduleFrameCallback((_) => _adjustScroll());
    //   }
    // });
  }

  // void _adjustScroll() {
  //   if (_getMessagesCubit.scrollController.hasClients) {
  //     _getMessagesCubit.scrollController.jumpTo(_getMessagesCubit.scrollController.position.minScrollExtent);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;
    
    return BlocBuilder<GetMessagesCubit, GetMessagesState>(
      bloc: _getMessagesCubit,
      builder: (context, state) {
        if (state is GettingMessages) {
          return const Expanded(
              child: Center(
                  child: CircularProgressIndicator(
            color: AppColors.primaryColor,
            backgroundColor: AppColors.containerBg,
          )));
        } else if (state is MessagesGetted) {
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: viewInsets.bottom),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                decoration: const BoxDecoration(color: AppColors.textSecColor),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    bool shouldScroll = _getMessagesCubit.messages.length > 2;
                    if (!shouldScroll) {
                      _getMessagesCubit.messages.sort(
                        (a, b) => a.sent.compareTo(b.sent),
                      );
                    } else {
                      _getMessagesCubit.messages.sort(
                        (a, b) => b.sent.compareTo(a.sent),
                      );
                    }
                    return ListView.builder(
                      controller: _getMessagesCubit.scrollController,
                      reverse: shouldScroll,
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      itemCount: _getMessagesCubit.messages.length,
                      itemBuilder: (context, index) {
                        var message = _getMessagesCubit.messages[index];
                        debugPrint(
                            'message value and the id is : ${message.messageId}');
                        return Column(
                          children: [
                            message.senderId == _authCubit.userData.id
                                ? UserMessageContainer(
                                    chatModel: message,
                                    key: ValueKey(message.messageId),
                                  )
                                : OtherMessageContainer(
                                    chatModel: message,
                                  ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          );
        } else {
          return const Center(child: Text('Failed to load messages'));
        }
      },
    );
  }
}
