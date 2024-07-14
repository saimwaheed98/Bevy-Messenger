import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/helper/cached_image_helper.dart';
import 'package:bevy_messenger/helper/time_formater.dart';
import 'package:bevy_messenger/helper/toast_messages.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_user_data_cubit.dart';
import 'package:bevy_messenger/pages/creategroup/data/models/chat_group_model.dart';
import 'package:bevy_messenger/pages/grouplist/presentation/widgets/pay_premium_dialouge.dart';
import 'package:bevy_messenger/pages/grouplist/presentation/widgets/show_no_subscription_dialouge.dart';
import 'package:bevy_messenger/routes/routes_imports.gr.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:bevy_messenger/utils/enums.dart';
import 'package:flutter/material.dart';

class GroupChatContainer extends StatelessWidget {
  final GroupModel groupData;
  const GroupChatContainer({super.key, required this.groupData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        splashFactory: InkRipple.splashFactory,
        highlightColor: AppColors.containerBg.withOpacity(0.5),
        splashColor: AppColors.containerBg.withOpacity(0.5),
        onTap: () async {
          final isAdmin = _authCubit.userData.email == 'admin@ourbevy.com';
          final isPremium = groupData.premium;
          final userBlocked =
              groupData.blockedUsers.contains(_authCubit.userData.id);
          final userSubscribed =
              _authCubit.userSubscriptions.any((sub) => sub.subscriptionStatus);
          final checkGroupIdSubscription = _authCubit.userSubscriptions
              .where((element) => element.subscribedGroupId == groupData.id)
              .toList();
          final checkSubscriptionExp = checkGroupIdSubscription.any((element) =>
              DateTime.parse(element.endingData).isAfter(DateTime.now()));
          if (isAdmin) {
            _getUserData.setChatStatus(ChatStatus.group);
            _getUserData.getGroupData(groupData);
            AutoRouter.of(context).push(const ChatPageRoute());
          } else {
            if (!isAdmin &&
                isPremium &&
                !groupData.members.contains(_authCubit.userData.id)) {
              if (userBlocked) {
                WarningHelper.showWarningToast(
                    "You are blocked for this chat room and cannot enter it",
                    context);
              } else if (!userSubscribed) {
                showDialog(
                  context: context,
                  builder: (context) => const NoSubscription(),
                );
              } else {
                final subscriptionId = _authCubit.userSubscriptions
                    .firstWhere((sub) => sub.subscriptionStatus)
                    .subscriptionId;
                showDialog(
                  context: context,
                  builder: (context) => PremiumGroupDialouge(
                    groupData: groupData,
                    subscriptionId: subscriptionId,
                  ),
                );
              }
            } else {
              _getUserData.setChatStatus(ChatStatus.group);
              _getUserData.getGroupData(groupData);
              if (userBlocked) {
                WarningHelper.showWarningToast(
                    "You are blocked for this chat room and cannot enter it",
                    context);
              } else {
                if (checkSubscriptionExp == false && groupData.premium) {
                  showDialog(
                    context: context,
                    builder: (context) => const NoSubscription(
                      isSubscribing: true,
                      title:
                          "Oops! Your journey for this room has been ended.Your subscription of one month with this has completed if you want to enter please pay subscription fee",
                    ),
                  );
                } else {
                  AutoRouter.of(context).push(const ChatPageRoute());
                }
              }
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: SizedBox(
            child: Row(
              children: [
                Stack(
                  children: [
                    if (groupData.imageUrl.isNotEmpty)
                      CachedImageHelper(
                        imageUrl: groupData.imageUrl,
                        height: 64,
                        width: 64,
                      ),
                    if (groupData.imageUrl.isEmpty)
                      Container(
                        height: 64,
                        width: 64,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColors.containerBg,
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: AppColors.white, width: 1.2)),
                        child: AppTextStyle(
                            text: groupData.name[0].toUpperCase() +
                                groupData.name[1].toUpperCase(),
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    if (groupData.onlineUsers.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(left: 50, top: 50),
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: AppColors.white, width: 1.2)),
                      )
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 150,
                      child: AppTextStyle(
                          text: groupData.name,
                          fontSize: 16,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    SizedBox(
                      width: 171,
                      child: Row(
                        children: [
                          Expanded(
                            // width: 90,
                            child: AppTextStyle(
                                text: groupData.lastMessage.isNotEmpty
                                    ? groupData.lastMessage
                                    : groupData.description,
                                fontSize: 14,
                                maxLines: 1,
                                color: AppColors.textColor,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          AppTextStyle(
                              text: "| ${groupData.members.length} Members",
                              fontSize: 14,
                              maxLines: 1,
                              color: AppColors.textColor,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w400),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                if (groupData.unreadMessageUsers
                    .contains(_authCubit.userData.id)) ...[
                  if (groupData.lastMessageUserImage.isEmpty)
                    CircleAvatar(
                      radius: 8,
                      backgroundImage:
                          NetworkImage(_authCubit.userData.imageUrl),
                      backgroundColor: AppColors.redColor,
                    ),
                  if (groupData.lastMessageUserImage.isNotEmpty &&
                      groupData.lastMessageUserImage.contains("http"))
                    CircleAvatar(
                      radius: 8,
                      backgroundImage:
                          NetworkImage(groupData.lastMessageUserImage),
                      backgroundColor: AppColors.redColor,
                    ),
                  if (groupData.lastMessageUserImage.isNotEmpty &&
                      !groupData.lastMessageUserImage.contains("http"))
                    CircleAvatar(
                      radius: 8,
                      backgroundColor: AppColors.redColor,
                      child: AppTextStyle(
                          text: groupData.lastMessageUserImage[0]
                                  .toUpperCase() +
                              groupData.lastMessageUserImage[1].toUpperCase(),
                          fontSize: 5,
                          fontWeight: FontWeight.w500),
                    ),
                ],
                const SizedBox(
                  width: 5,
                ),
                Column(
                  children: [
                    AppTextStyle(
                        text: MyDateUtil.getLastMessageTime(
                            context: context,
                            time: groupData.lastMessageTime.isEmpty
                                ? groupData.createdAt
                                : groupData.lastMessageTime),
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                    const SizedBox(
                      height: 5,
                    ),
                    if (groupData.premium)
                      const AppTextStyle(
                          text: "\$", fontSize: 20, fontWeight: FontWeight.w500)
                    // SvgPicture.asset(
                    //   AppImages.subscriptionIcon,
                    //   height: 20,
                    //   width: 20,
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final AuthCubit _authCubit = Di().sl<AuthCubit>();
final GetUserDataCubit _getUserData = Di().sl<GetUserDataCubit>();
