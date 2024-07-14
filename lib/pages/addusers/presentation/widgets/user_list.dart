import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:bevy_messenger/pages/addusers/presentation/bloc/cubit/get_user_cubit.dart';
import 'package:bevy_messenger/pages/addusers/presentation/widgets/user_container.dart';
import 'package:bevy_messenger/pages/signup/data/models/usermodel/user_model.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator_imports.dart';

class UserList extends StatelessWidget {
  final Function()? onTap;
  final bool? isAddingInfo;
const UserList({super.key, this.onTap, this.isAddingInfo});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _authCubit,
      builder: (context, state) {
        return StreamBuilder(
          stream: AuthDataSource.firestore
              .collection("users")
              .where("email" , isNotEqualTo: "admin@ourbevy.com")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data?.docs.isEmpty ?? false) {
              return const Column(
                children: [
                  Center(
                    child: AppTextStyle(
                        text: "No users founds",
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return const Column(
                children: [
                  Center(
                    child: AppTextStyle(
                        text: "Error while fetching users",
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  )
                ],
              );
            } else if (snapshot.data?.docs.isNotEmpty ?? false) {
              var data = snapshot.data?.docs;
              var userList =
                  data?.map((e) => UserModel.fromJson(e.data())).toList() ?? [];
              var filteredUsers = userList
                  .where((element) => element.id != _authCubit.userData.id)
                  .where((element) => !_authCubit.userData.blockedUsers
                      .contains(element.id)).toList();
              _getUserCubit.getUsers(filteredUsers);
              return BlocBuilder(
                bloc: _getUserCubit,
                builder: (context, state) {
                  return ListView.builder(
                     physics: const NeverScrollableScrollPhysics(),
                     shrinkWrap: true,
                    itemCount: _getUserCubit.isSearching
                        ? _getUserCubit.searchedUsers.length
                        : _getUserCubit.users.length,
                    itemBuilder: (context, index) {
                      var user = _getUserCubit.isSearching
                          ? _getUserCubit.searchedUsers[index]
                          : _getUserCubit.users[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: UserContainer(
                          user: user,
                          onTap: onTap,
                          isAddingInfo: isAddingInfo,
                        ),
                      );
                    },
                  );
                },
              );
            } else {
              return const Column(
                children: [
                  Center(
                    child: CircularProgressIndicator(
                      backgroundColor: AppColors.secRedColor,
                      color: AppColors.white,
                    ),
                  )
                ],
              );
            }
          },
        );
      },
    );
  }
}

final AuthCubit _authCubit = Di().sl<AuthCubit>();
final GetUserCubit _getUserCubit = Di().sl<GetUserCubit>();
