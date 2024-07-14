import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:bevy_messenger/helper/cached_image_helper.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_user_data_cubit.dart';
import 'package:bevy_messenger/pages/creategroup/presentation/bloc/cubit/create_group_cubit.dart';
import 'package:bevy_messenger/pages/signup/data/models/usermodel/user_model.dart';
import 'package:bevy_messenger/routes/routes_imports.gr.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:bevy_messenger/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator_imports.dart';
import '../../../../helper/conversation_id_getter.dart';
import '../../../chatpage/data/model/message_model.dart';

class UserContainer extends StatelessWidget {
  final UserModel user;
  final Function()? onTap;
  final bool? isAddingInfo;
  const UserContainer(
      {super.key, required this.user, this.onTap, this.isAddingInfo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null
          ? () async {
              log("isadding $isAddingInfo");
              _createGroupCubit.addParticipiants(user);
              if (isAddingInfo == true) {
                log("this is true message");
                  _createGroupCubit.addParticipiants(user);
                  _getUserDataCubit.addToMemberList(user.id);
                  await AuthDataSource.addParticipantsToGroup(
                      _getUserDataCubit.groupData.id, [user.id]);
              }else if (isAddingInfo == false ){
                _createGroupCubit.addParticipiants(user);
                _getUserDataCubit.removeFromMemberList(user.id);
                await AuthDataSource.removeParticipiants(
                    _getUserDataCubit.groupData.id, [user.id]);
              }
            }
          : () async {
              _getUserDataCubit.getUserData(user);
              _getUserDataCubit.setChatStatus(ChatStatus.user);
              AutoRouter.of(context).push(const ChatPageRoute());
            },
      child: StreamBuilder(
          stream: AuthDataSource.firestore
              .collection('chats')
              .doc(conversationId(user.id))
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
              element.receiverId != user.id)
              .length ??
              0;
          return Container(
            height: 75,
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.black.withOpacity(0.25)),
            child: Row(
              children: [
                Stack(
                  children: [
                    if (user.imageUrl.isNotEmpty)
                      CachedImageHelper(
                          imageUrl: user.imageUrl, height: 61, width: 61),
                    if (user.imageUrl.isEmpty)
                      Container(
                        height: 61,
                        width: 61,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.containerBg,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.white, width: 1.2),
                        ),
                        child: Text(
                            user.name[0].toUpperCase() + user.name[1].toUpperCase(),
                            style: const TextStyle(
                                color: AppColors.textColor,
                                fontSize: 24,
                                fontWeight: FontWeight.w700)),
                      ),
                    if (user.isOnline)
                      Positioned(
                        bottom: 3,
                        right: 3,
                        child: Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.white, width: 2),
                              color: Colors.green,
                              shape: BoxShape.circle),
                        ),
                      ),
                    BlocBuilder(
                      bloc: _createGroupCubit,
                      builder: (context, state) {
                        return onTap != null &&
                                _createGroupCubit.participants.contains(user)
                            ? Container(
                                height: 61,
                                width: 61,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue.withOpacity(0.5)),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              )
                            : const SizedBox();
                      },
                    )
                  ],
                ),
                const SizedBox(
                  width: 12,
                ),
                SizedBox(
                  width: 160,
                  child: AppTextStyle(
                      text: user.name,
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                if(unreadMessages != 0)
                const CircleAvatar(
                  backgroundColor: AppColors.redColor,
                  radius: 10,
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}

final GetUserDataCubit _getUserDataCubit = Di().sl<GetUserDataCubit>();
final CreateGroupCubit _createGroupCubit = Di().sl<CreateGroupCubit>();
