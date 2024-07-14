import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/pages/chatpage/data/model/message_model.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_user_data_cubit.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/send_file_message_cubit.dart';
import 'package:bevy_messenger/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_message_package/voice_message_package.dart';

import '../../../../../utils/app_text_style.dart';
import '../../../../../utils/colors.dart';

class VoiceMessageContainer extends StatelessWidget {
  final MessageModel message;
  final Color backgroundColor;
  final Color activeSliderColor;
  final Color circlesColor;
  final String? read;

  const VoiceMessageContainer({super.key,
    required this.backgroundColor,
    required this.activeSliderColor,
    required this.circlesColor, this.read, required this.message});

  @override
  Widget build(BuildContext context) {
    bool isSending = _fileMessageCubit.sendingMessageId == message.messageId &&
        _fileMessageCubit.isSending;
    return BlocBuilder(
      bloc: _fileMessageCubit,
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            VoiceMessageView(
                activeSliderColor: activeSliderColor,
                circlesColor: circlesColor,
                cornerRadius: 30,
                backgroundColor: backgroundColor,
                controller: VoiceController(
                  audioSrc: message.message,
                  maxDuration: const Duration(seconds: 60),
                  isFile: false,
                  onComplete: () {
                    debugPrint('onComplete');
                  },
                  onPause: () {
                    debugPrint('onPause');
                  },
                  onPlaying: () {
                    debugPrint('onPlaying');
                  },
                )),
            if(isSending && state is SendFileMessageFailure)
              CircleAvatar(
                backgroundColor: AppColors.textColor.withOpacity(0.7),
                radius: 10,
                child: const AppTextStyle(text: "!",
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.redColor,),
              ),
            if (isSending && !_fileMessageCubit.sendingFailed)
              const Icon(CupertinoIcons.clock,
                  color: AppColors.redColor, size: 18),
            if (_getUserDataCubit.chatStatus == ChatStatus.user &&
                isSending == false) ...[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if ( message.read.isNotEmpty)
                    const Icon(
                      Icons.done_all,
                      color: AppColors.redColor,
                      size: 18,
                    ),
                  if (message.userOnlineState == true &&
                      message.read.isEmpty)
                    const Icon(
                      Icons.done,
                      color: AppColors.redColor,
                      size: 18,
                    ),
                ],
              ),
              if (message.userOnlineState == false &&
                  message.read.isEmpty)
                const Icon(
                  Icons.done,
                  color: AppColors.white,
                  size: 18,
                ),
            ],
            // if (_getUserDataCubit.chatStatus == ChatStatus.user && (read?.isNotEmpty ?? false))
            //   const Icon(
            //     Icons.done_all,
            //     color: AppColors.redColor,
            //     size: 18,
            //   ),
            // if (_getUserDataCubit.chatStatus == ChatStatus.user && (read?.isEmpty ?? false))
            //   Icon(
            //     Icons.done,
            //     color: AppColors.white.withOpacity(0.7),
            //     size: 18,
            //   ),
          ],
        );
      },
    );
  }
}

final SendFileMessageCubit _fileMessageCubit = Di().sl<SendFileMessageCubit>();
final GetUserDataCubit _getUserDataCubit = Di().sl<GetUserDataCubit>();