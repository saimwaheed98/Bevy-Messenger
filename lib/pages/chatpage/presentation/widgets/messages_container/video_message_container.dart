import 'dart:io';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_user_data_cubit.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:bevy_messenger/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bevy_messenger/pages/chatpage/data/model/message_model.dart';
import 'package:bevy_messenger/routes/routes_imports.gr.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:flutter/material.dart';

import '../../bloc/cubit/send_file_message_cubit.dart';

class VideoMessageContainer extends StatefulWidget {
  final MessageModel message;
  final Color color;
  final String? read;

  const VideoMessageContainer(
      {super.key, required this.color, this.read, required this.message});

  @override
  State<VideoMessageContainer> createState() => _InternetVideoPlayerState();
}

class _InternetVideoPlayerState extends State<VideoMessageContainer> {
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  @override
  void initState() {
    super.initState();
    bool isSending =
        _fileMessageCubit.sendingMessageId == widget.message.messageId &&
            _fileMessageCubit.isSending;
    if (isSending) {
      videoPlayerController =
          VideoPlayerController.file(File(widget.message.message))
            ..initialize().then((value) => setState(() {}));
      _customVideoPlayerController = CustomVideoPlayerController(
        context: context,
        videoPlayerController: videoPlayerController,
      );
    } else {
      videoPlayerController =
          VideoPlayerController.network(widget.message.message)
            ..initialize().then((value) => setState(() {}));
      _customVideoPlayerController = CustomVideoPlayerController(
        context: context,
        videoPlayerController: videoPlayerController,
      );
    }
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isSending =
        _fileMessageCubit.sendingMessageId == widget.message.messageId &&
            _fileMessageCubit.isSending;
    return BlocBuilder(
      bloc: _fileMessageCubit,
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  AutoRouter.of(context).push(InternetDataPreviewPageRoute(
                      url: widget.message.message,
                      type: MessageType.video));
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 10, left: 5, right: 5, bottom: 10),
                  decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                            maxHeight: 340, maxWidth: 270, minWidth: 270),
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CustomVideoPlayer(
                                customVideoPlayerController:
                                    _customVideoPlayerController),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppTextStyle(
                          text: widget.message.secMessage,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)
                    ],
                  ),
                ),
              ),
              if(isSending && state is SendFileMessageFailure)
                CircleAvatar(
                  backgroundColor: AppColors.textColor.withOpacity(0.7),
                  radius: 10,
                  child: const AppTextStyle(text: "!", fontSize: 15, fontWeight: FontWeight.w500,color: AppColors.redColor,) ,
                ),
              if (isSending && !_fileMessageCubit.sendingFailed)
                const Icon(CupertinoIcons.clock,
                    color: AppColors.redColor, size: 18),
              if (_getUserDataCubit.chatStatus == ChatStatus.user &&
                  isSending == false) ...[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.message.read.isNotEmpty)
                      const Icon(
                        Icons.done_all,
                        color: AppColors.redColor,
                        size: 18,
                      ),
                    if (widget.message.userOnlineState == true &&
                        widget.message.read.isEmpty)
                      const Icon(
                        Icons.done,
                        color: AppColors.redColor,
                        size: 18,
                      ),
                  ],
                ),
                if (widget.message.userOnlineState == false &&
                    widget.message.read.isEmpty)
                  const Icon(
                    Icons.done,
                    color: AppColors.white,
                    size: 18,
                  ),
              ],
              // if (_getUserDataCubit.chatStatus == ChatStatus.user && ( widget.read?.isNotEmpty ?? false ))
              //   const Icon(
              //     Icons.done_all,
              //     color: AppColors.redColor,
              //     size: 18,
              //   ),
              // if (_getUserDataCubit.chatStatus == ChatStatus.user && (widget.read?.isEmpty ?? false))
              //   Icon(
              //     Icons.done,
              //     color: AppColors.white.withOpacity(0.7),
              //     size: 18,
              //   ),
            ],
          ),
        );
      },
    );
  }
}

final SendFileMessageCubit _fileMessageCubit = Di().sl<SendFileMessageCubit>();
final GetUserDataCubit _getUserDataCubit = Di().sl<GetUserDataCubit>();
