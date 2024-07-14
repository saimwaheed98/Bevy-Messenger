import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:bevy_messenger/helper/time_formater.dart';
import 'package:bevy_messenger/pages/chatpage/data/model/message_model.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_messages_cubit.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_user_data_cubit.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/widgets/messages_container/image_message_container.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/widgets/messages_container/video_message_container.dart';
import 'package:bevy_messenger/pages/signup/data/models/usermodel/user_model.dart';
import 'package:bevy_messenger/routes/routes_imports.gr.dart';
import 'package:bevy_messenger/utils/enums.dart';
import 'package:bevy_messenger/utils/screen_sizes.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/app_text_style.dart';
import '../../../../../utils/colors.dart';
import '../../../../userProfile/presentation/bloc/cubit/other_user_data_cubit.dart';
import 'docs_message_container.dart';
import 'voice_message_container.dart';

class OtherMessageContainer extends StatelessWidget {
  final MessageModel? chatModel;
  const OtherMessageContainer({super.key, this.chatModel});

  @override
  Widget build(BuildContext context) {
    if (_getUserDataCubit.chatStatus == ChatStatus.user &&
        (chatModel?.chatId.isNotEmpty ?? false)) {
      if (chatModel?.read.isEmpty ?? false) {
        _getMessagesCubit.updateMessageReadStatus(
            chatModel?.chatId ?? "", chatModel?.messageId ?? "");
      }
    }

    if (_getUserDataCubit.chatStatus == ChatStatus.group &&
        _getUserDataCubit.groupData.id.isNotEmpty) {
      AuthDataSource.removeUserFromGroupUnreadMessage(
          _getUserDataCubit.groupData.id);
      if (_getUserDataCubit.groupData.unreadMessageUsers.isEmpty) {
        if (chatModel?.read.isEmpty ?? false) {
          _getMessagesCubit.updateMessageReadStatus(
              _getUserDataCubit.groupData.id, chatModel?.messageId ?? "");
        }
      }
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: AppTextStyle(
                text: MyDateUtil.getMessageTime(
                    context: context, time: chatModel?.sent ?? ""),
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 8,
          ),
          if (chatModel?.type == MessageType.text.name)
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 290),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.containerBg,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 220),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: AppTextStyle(
                                text: chatModel?.message ?? "",
                                fontSize: 13,
                                textAlign: TextAlign.end,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                        if (_getUserDataCubit.chatStatus == ChatStatus.group)
                          positionedWidget(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          if (chatModel?.type == MessageType.image.name)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  ImageMessageContainer(
                      message: chatModel ?? const MessageModel(),
                      color: AppColors.textSecColor),
                  if (_getUserDataCubit.chatStatus == ChatStatus.group)
                    positionedWidget(context),
                ],
              ),
            ),
          if (chatModel?.type == MessageType.video.name)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    width: getWidth(context) * 0.8,
                  ),
                  VideoMessageContainer(
                    color: AppColors.containerBg,
                    message: chatModel ?? const MessageModel(),
                  ),
                  if (_getUserDataCubit.chatStatus == ChatStatus.group)
                    positionedWidget(context),
                ],
              ),
            ),
          if (chatModel?.type == MessageType.audio.name)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  VoiceMessageContainer(
                    backgroundColor: AppColors.containerBg,
                    activeSliderColor: AppColors.textColor,
                    circlesColor: AppColors.primaryColor,
                    message: chatModel ?? const MessageModel(),
                  ),
                  if (_getUserDataCubit.chatStatus == ChatStatus.group)
                    positionedWidget(context),
                ],
              ),
            ),
          if (chatModel?.type == MessageType.file.name)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  DocsMessageContainer(
                    message: chatModel ?? const MessageModel(),
                    backgroundColor: AppColors.containerBg,
                  ),
                  if (_getUserDataCubit.chatStatus == ChatStatus.group)
                    positionedWidget(context),
                ],
              ),
            )
        ],
      ),
    );
  }

  Widget positionedWidget(BuildContext context) {
    return Positioned(
      top: 0,
      bottom: 0,
      left: -12,
      child: InkWell(
        onTap: () async {
          await AuthDataSource.firestore
              .collection("users")
              .doc(chatModel?.senderId)
              .get()
              .then((value) {
            UserModel userData = UserModel.fromJson(value.data() ?? {});
            _otherUserDataCubit.getUserData(userData);
            if (userData.toString().isNotEmpty) {
              AutoRouter.of(context).push(UserProfilePageRoute(isGroup: true));
            }
          });
        },
        child: chatModel?.senderImage.isNotEmpty ?? false ? CircleAvatar(
          backgroundColor: AppColors.containerBg,
          radius: 13,
         backgroundImage: NetworkImage(chatModel?.senderImage ?? "") ,
        ): CircleAvatar(
          backgroundColor: AppColors.containerBg,
          radius: 13,
          child: AppTextStyle(
              text: (chatModel!.senderUsername.isNotEmpty)
                  ? chatModel!.senderUsername[0].toUpperCase() +
                      chatModel!.senderUsername[1].toUpperCase()
                  : "MS",
              fontSize: 8,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

final OtherUserDataCubit _otherUserDataCubit = Di().sl<OtherUserDataCubit>();
final GetMessagesCubit _getMessagesCubit = Di().sl<GetMessagesCubit>();
final GetUserDataCubit _getUserDataCubit = Di().sl<GetUserDataCubit>();
