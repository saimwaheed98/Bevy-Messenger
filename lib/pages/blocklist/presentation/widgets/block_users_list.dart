import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:bevy_messenger/pages/privatechats/presentation/bloc/cubit/get_private_chat_cubit.dart';
import 'package:bevy_messenger/pages/signup/data/models/usermodel/user_model.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../bloc/cubits/auth_cubit.dart';
import '../../../../core/di/service_locator_imports.dart';
import '../../../privatechats/presentation/widgets/user_chat_container_des.dart';

class BlockUsersList extends StatelessWidget {
  BlockUsersList({super.key});

  final GetPrivateChatCubit _getPrivateChatCubit =
      Di().sl<GetPrivateChatCubit>();

  final AuthCubit _authCubit = Di().sl<AuthCubit>();
  @override
  Widget build(BuildContext context) {
            return StreamBuilder(
                stream: AuthDataSource.firestore.collection("users").where("blockedBy", arrayContains: _authCubit.userData.id).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Column(
                      children: [
                        Center(
                          child: CircularProgressIndicator(
                            backgroundColor: AppColors.textSecColor,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: AppTextStyle(
                          text: "Error while getting data ",
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    );
                  } else if (snapshot.data?.docs.isEmpty ?? false) {
                    return const Center(
                      child: AppTextStyle(
                          text: "No blocked user found",
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    );
                  } else {
                    var data = snapshot.data?.docs;
                    var list = data
                            ?.map((e) => UserModel.fromJson(e.data()))
                            .toList() ??
                        [];
                    var filteredUsers = list
                        .where((element) => _authCubit.userData.blockedUsers
                            .contains(element.id))
                        .toList();
                    _getPrivateChatCubit.getBlockedChats(filteredUsers);
                    return BlocBuilder(
                        bloc: _getPrivateChatCubit,
                        builder: (context, state) {
                          return Flexible(
                            fit: FlexFit.loose,
                            child: ListView.builder(
                                itemCount: _getPrivateChatCubit
                                    .blockedUsersList.length,
                                itemBuilder: (context, index) {
                                  var user = _getPrivateChatCubit
                                      .blockedUsersList[index];
                                  return Slidable(
                                    direction: Axis.horizontal,
                                    startActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) async {
                                            _getPrivateChatCubit
                                                .removeUser(user);
                                            _authCubit.removeBlockedUser(user.id);
                                            await AuthDataSource
                                                .unBlockUser(user.id);
                                          },
                                          backgroundColor:
                                              AppColors.secRedColor,
                                          foregroundColor: Colors.white,
                                          flex: 4,
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            topLeft: Radius.circular(10),
                                          ),
                                          autoClose: true,
                                          icon: Icons.delete,
                                          label: 'UnBlock user',
                                        ),
                                      ],
                                    ),
                                    child: UserChatContainer(
                                      userModel: user,
                                    ),
                                  );
                                }),
                          );
                        });
                  }
                });


  }
}
