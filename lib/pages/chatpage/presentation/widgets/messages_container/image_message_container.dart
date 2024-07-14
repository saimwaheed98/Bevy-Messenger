import 'dart:developer';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:bevy_messenger/utils/enums.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/service_locator_imports.dart';
import '../../../../../routes/routes_imports.gr.dart';
import '../../../../../utils/images_path.dart';
import '../../../data/model/message_model.dart';
import '../../bloc/cubit/get_user_data_cubit.dart';
import '../../bloc/cubit/send_file_message_cubit.dart';

class ImageMessageContainer extends StatelessWidget {
  final MessageModel message;
  final Color color;
  final String? read;

  const ImageMessageContainer({
    super.key,
    required this.message,
    required this.color,
    this.read,
  });

  @override
  Widget build(BuildContext context) {
    bool isSending = _fileMessageCubit.sendingMessageId == message.messageId &&
        _fileMessageCubit.isSending;
    log("isSending: $isSending ,sending message Id ${_fileMessageCubit.sendingMessageId} ,messageId ${message.messageId}");
    return BlocBuilder(
      bloc: _fileMessageCubit,
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
              splashColor: AppColors.transparent,
              onTap: () {
                AutoRouter.of(context).push(InternetDataPreviewPageRoute(
                    url: message.message, type: MessageType.image));
              },
              child: Container(
                padding: const EdgeInsets.only(
                    top: 5, left: 5, right: 5, bottom: 10),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                          maxHeight: 270, maxWidth: 200, minWidth: 200),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: isSending
                            ? Image.file(
                                File(message.message),
                                fit: BoxFit.cover,
                              )
                            : CachedNetworkImage(
                                imageUrl: message.message,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                repeat: ImageRepeat.noRepeat,
                                placeholder: (context, url) => Center(
                                  child: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: Image.asset(AppImages.appIcon)),
                                ),
                              ),
                      ),
                    ),
                    if (message.secMessage.isNotEmpty)
                      const SizedBox(
                        height: 10,
                      ),
                    if (message.secMessage.isNotEmpty)
                      AppTextStyle(
                          text: message.secMessage,
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
                isSending == false && message.senderId == _authCubit.userData.id) ...[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (message.read.isNotEmpty)
                    const Icon(
                      Icons.done_all,
                      color: AppColors.redColor,
                      size: 18,
                    ),
                  if (message.userOnlineState == true && message.read.isEmpty )
                    const Icon(
                      Icons.done,
                      color: AppColors.redColor,
                      size: 18,
                    ),
                ],
              ),
              if (message.userOnlineState == false && message.read.isEmpty)
                const Icon(
                  Icons.done,
                  color: AppColors.white,
                  size: 18,
                ),
            ],
          ],
        );
      },
    );
  }
}

final GetUserDataCubit _getUserDataCubit = Di().sl<GetUserDataCubit>();
final SendFileMessageCubit _fileMessageCubit = Di().sl<SendFileMessageCubit>();
final AuthCubit _authCubit = Di().sl<AuthCubit>();