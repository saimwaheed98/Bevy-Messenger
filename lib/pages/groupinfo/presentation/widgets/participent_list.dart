import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:bevy_messenger/helper/toast_messages.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_user_data_cubit.dart';
import 'package:bevy_messenger/pages/creategroup/data/models/chat_group_model.dart';
import 'package:bevy_messenger/pages/creategroup/presentation/bloc/cubit/create_group_cubit.dart';
import 'package:bevy_messenger/pages/creategroup/presentation/widgets/participiant_container_widget.dart';
import 'package:bevy_messenger/pages/groupinfo/presentation/bloc/cubit/remove_user_group_cubit.dart';
import 'package:bevy_messenger/pages/signup/data/models/usermodel/user_model.dart';
import 'package:bevy_messenger/routes/routes_imports.gr.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../userProfile/presentation/bloc/cubit/other_user_data_cubit.dart';

class ParticipentList extends StatelessWidget {
  final GroupModel groupData;
  const ParticipentList({super.key, required this.groupData});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _getUserDataCubit,
      builder: (context, state) {
        return _getUserDataCubit.groupData.members.isEmpty ? const Center(
          child: AppTextStyle(text: "Lets add users", fontSize: 27, fontWeight: FontWeight.w500),
        ) : StreamBuilder(
            stream: AuthDataSource.firestore
                .collection("users")
                .where("id", whereIn: _getUserDataCubit.groupData.members)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                var data = snapshot.data?.docs;
                var list =
                    data?.map((e) => UserModel.fromJson(e.data())).toList();
                _createGroupCubit.getParticpants(list ?? []);
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: list?.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var user = list?[index];
                    return ParticipiantContainer(
                      onLongPress: () {
                        if(groupData.category == GroupCategory.group.name){
                          if(user?.id == groupData.adminId && groupData.adminId == _authCubit.userData.id){
                            WarningHelper.showWarningToast("You cannot remove your self", context);
                          }else{
                            if(groupData.adminId == _authCubit.userData.id){
                              _removeUserGroupState.removeUser(user?.id ?? "");
                            }
                          }
                        }
                      },
                      onTap: () {
                        _otherUserDataCubit.getUserData(user ?? const UserModel());
                        AutoRouter.of(context).push(UserProfilePageRoute(
                          isGroup: true
                        ));
                      },
                      groupData: groupData,
                      user: user ?? const UserModel(),
                    );
                  },
                );
              }
            });
      },
    );
  }
}
final OtherUserDataCubit _otherUserDataCubit = Di().sl<OtherUserDataCubit>();
final AuthCubit _authCubit = Di().sl<AuthCubit>();
final RemoveUserGroupCubit _removeUserGroupState = Di().sl<RemoveUserGroupCubit>();
final CreateGroupCubit _createGroupCubit = Di().sl<CreateGroupCubit>();
final GetUserDataCubit _getUserDataCubit = Di().sl<GetUserDataCubit>();
