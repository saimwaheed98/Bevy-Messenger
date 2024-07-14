import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:bevy_messenger/helper/cached_image_helper.dart';
import 'package:bevy_messenger/helper/conversation_id_getter.dart';
import 'package:bevy_messenger/pages/chatpage/data/model/message_model.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_user_data_cubit.dart';
import 'package:bevy_messenger/pages/signup/data/models/usermodel/user_model.dart';
import 'package:bevy_messenger/pages/userProfile/presentation/bloc/cubit/other_user_data_cubit.dart';
import 'package:bevy_messenger/routes/routes_imports.gr.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../helper/time_formater.dart';
import '../../../bottombar/presentation/bloc/cubit/bottom_bar_cubit.dart';

class UserChatContainer extends StatelessWidget {
  final UserModel userModel;
  const UserChatContainer({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () {
          _getUserData.getUserData(userModel);
          AutoRouter.of(context).push(const ChatPageRoute());
        },
        child: SizedBox(
          child: StreamBuilder(
              stream: AuthDataSource.firestore
                  .collection('chats')
                  .doc(conversationId(userModel.id))
                  .collection("messages")
                  .snapshots(),
              builder: (context, snapshot) {
                var data = snapshot.data?.docs;
                var list =
                    data?.map((e) => MessageModel.fromJson(e.data())).toList();
                // get unread messages counts
                int unreadMessages = list
                        ?.where((element) =>
                            element.read.isEmpty &&
                            element.receiverId != userModel.id)
                        .length ??
                    0;
                debugPrint('unreadMessages: $unreadMessages');
                // get last message time
                String? lastMessageTime;
                if (list != null && list.isNotEmpty) {
                  lastMessageTime = list.last.sent;
                }
                String? lastMessageReadTime;
                if (list != null && list.isNotEmpty) {
                  lastMessageReadTime = list.last.read;
                }
                return Row(
                  children: [
                    Stack(
                      children: [
                        if (userModel.imageUrl.isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              _otherUserDataCubit.getUserData(userModel);
                              AutoRouter.of(context).push(UserProfilePageRoute(
                                isGroup: false
                              ));
                            },
                            child: CachedImageHelper(
                              imageUrl: userModel.imageUrl,
                              height: 64,
                              width: 64,
                            ),
                          ),
                        if (userModel.imageUrl.isEmpty)
                          Container(
                            height: 64,
                            width: 64,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.containerBg,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColors.white, width: 1.2),
                            ),
                            child: Text(
                                userModel.name[0].toUpperCase() +
                                    userModel.name[1].toUpperCase(),
                                style: const TextStyle(
                                    color: AppColors.textColor,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700)),
                          ),
                        if (userModel.isOnline)
                          Container(
                            margin: const EdgeInsets.only(left: 50, top: 50),
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColors.white, width: 1.2)),
                          )
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextStyle(
                              text: userModel.name,
                              fontSize: 16,
                              maxLines: 1,
                              fontWeight: FontWeight.w700),
                          const SizedBox(
                            height: 6,
                          ),
                          AppTextStyle(
                              text: MyDateUtil.getLastActiveTime(
                                  context: context,
                                  lastActive: userModel.lastActive),
                              fontSize: 10,
                              maxLines: 1,
                              color: AppColors.textColor,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w400),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AppTextStyle(
                            text: getLastMessageTime(
                                lastMessageTime, lastMessageReadTime, context),
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                        const SizedBox(
                          height: 8,
                        ),
                        if (unreadMessages != 0)
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: CircleAvatar(
                              radius: 7,
                              backgroundColor: AppColors.redColor,
                            ),
                          ),
                        // if (lastMessageSenderId != userModel.id &&
                        //     unreadMessages == 0 &&
                        //     lastMessage != null)
                        //   const Icon(
                        //     Icons.done_all_outlined,
                        //     color: AppColors.textColor,
                        //     size: 20,
                        //   ),
                        // // if (lastMessageSenderId != userModel.id &&
                        // //     unreadMessages == 0 &&
                        // //     lastMessage != null)
                        // if (otherUnreadMessage == 0 && lastMessage != null)
                        //   const Icon(
                        //     Icons.done_all_outlined,
                        //     color: AppColors.redColor,
                        //     size: 20,
                        //   ),
                      ],
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }

  String getLastMessageTime(
      String? lastSentMessage, String? lastReadMessage, BuildContext context) {
    if (lastReadMessage?.isNotEmpty ?? false) {
      return MyDateUtil.getMessageTime(
          context: context, time: lastReadMessage!);
    } else if (lastSentMessage?.isNotEmpty ?? false) {
      return MyDateUtil.getMessageTime(
          context: context, time: lastSentMessage!);
    } else {
      return "";
    }
  }
}

final BottomBarCubit _bottomBarCubit = Di().sl<BottomBarCubit>();
final GetUserDataCubit _getUserData = Di().sl<GetUserDataCubit>();
final OtherUserDataCubit _otherUserDataCubit = Di().sl<OtherUserDataCubit>();
