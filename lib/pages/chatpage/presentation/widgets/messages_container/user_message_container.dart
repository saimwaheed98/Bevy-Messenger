import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/helper/time_formater.dart';
import 'package:bevy_messenger/pages/chatpage/data/model/message_model.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_user_data_cubit.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/widgets/messages_container/docs_message_container.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/widgets/messages_container/image_message_container.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/widgets/messages_container/video_message_container.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/widgets/messages_container/voice_message_container.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:bevy_messenger/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/cubit/get_messages_cubit.dart';
import '../../bloc/cubit/send_file_message_cubit.dart';

class UserMessageContainer extends StatelessWidget {
  final MessageModel? chatModel;
  const UserMessageContainer({
    super.key,
    this.chatModel,
  });

  @override
  Widget build(BuildContext context) {
    if (_getUserDataCubit.chatStatus == ChatStatus.user &&
        (chatModel?.chatId.isNotEmpty ?? false)) {
      if (chatModel?.userOnlineState == false &&
          _getUserDataCubit.userOnlineState == true) {
        _getMessagesCubit.updateUserOnlineStatusForMessage(
            chatModel?.chatId ?? "", chatModel?.messageId ?? "");
      }
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppTextStyle(
              text: MyDateUtil.getMessageTime(
                  context: context, time: chatModel?.sent ?? ""),
              fontSize: 12,
              fontWeight: FontWeight.w400),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: _getUserDataCubit.groupData.category ==
                        GroupCategory.room.name &&
                    _getUserDataCubit.chatStatus == ChatStatus.group
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            children: [
              if (chatModel?.type == MessageType.text.name)
                BlocBuilder(
                  bloc: _fileMessageCubit,
                  builder: (context, state) {
                    bool isSending = _fileMessageCubit.sendingMessageId ==
                            chatModel?.messageId &&
                        _fileMessageCubit.isSending;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          constraints: const BoxConstraints(maxWidth: 280),
                          decoration: BoxDecoration(
                            color: AppColors.secRedColor.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 280),
                                  child: AppTextStyle(
                                    text: chatModel?.message ?? "",
                                    fontSize: 13,
                                    textAlign: TextAlign.end,
                                    fontWeight: FontWeight.w300,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSending && state is SendFileMessageFailure)
                          CircleAvatar(
                            backgroundColor:
                                AppColors.textColor.withOpacity(0.7),
                            radius: 10,
                            child: const AppTextStyle(
                              text: "!",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppColors.redColor,
                            ),
                          ),
                        if (isSending && !_fileMessageCubit.sendingFailed)
                          const Icon(
                              Icons.done,
                              color: AppColors.white,
                              size: 18,
                            ),
                        if (_getUserDataCubit.chatStatus == ChatStatus.user &&
                            isSending == false) ...[
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (chatModel?.read.isNotEmpty ?? false)
                                const Icon(
                                  Icons.done_all,
                                  color: AppColors.redColor,
                                  size: 18,
                                ),
                              if (chatModel?.userOnlineState == true &&
                                  chatModel!.read.isEmpty)
                                const Icon(
                                  Icons.done,
                                  color: AppColors.redColor,
                                  size: 18,
                                ),
                            ],
                          ),
                          if (chatModel!.userOnlineState == false &&
                              chatModel!.read.isEmpty)
                            const Icon(
                              Icons.done,
                              color: AppColors.white,
                              size: 18,
                            ),
                        ],
                      ],
                    );
                  },
                ),
              if (chatModel?.type == MessageType.image.name)
                ImageMessageContainer(
                  color: AppColors.redColor,
                  message: chatModel ?? const MessageModel(),
                  read: chatModel?.read ?? "",
                  key: key,
                ),
              if (chatModel?.type == MessageType.video.name)
                VideoMessageContainer(
                  message: chatModel ?? const MessageModel(),
                  color: AppColors.redColor,
                  read: chatModel?.read ?? "",
                ),
              if (chatModel?.type == MessageType.audio.name)
                VoiceMessageContainer(
                  backgroundColor: AppColors.redColor,
                  activeSliderColor: AppColors.textSecColor,
                  circlesColor: AppColors.primaryColor,
                  read: chatModel?.read ?? "",
                  message: chatModel ?? const MessageModel(),
                ),
              if (chatModel?.type == MessageType.file.name)
                DocsMessageContainer(
                  message: chatModel ?? const MessageModel(),
                  read: chatModel?.read ?? "",
                  backgroundColor: AppColors.redColor,
                )
            ],
          ),
        ],
      ),
    );
  }
}

final GetMessagesCubit _getMessagesCubit = Di().sl<GetMessagesCubit>();
final SendFileMessageCubit _fileMessageCubit = Di().sl<SendFileMessageCubit>();
final GetUserDataCubit _getUserDataCubit = Di().sl<GetUserDataCubit>();
