import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/pages/addusers/presentation/bloc/cubit/get_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'user_container.dart';

class UserContactsList extends StatelessWidget {
  final Function()? onTap;
  final bool? isAddingInfo;
  final bool isAdding;
  const UserContactsList(
      {super.key, this.onTap, this.isAddingInfo, required this.isAdding});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _getUserCubit,
        builder: (context, state) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _getUserCubit.contactsUsers.length,
            itemBuilder: (context, index) {
              var userList = _getUserCubit.contactsUsers.toList();
              var user = userList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: UserContainer(
                  onTap: onTap,
                  user: user,
                  isAddingInfo: isAddingInfo,
                ),
              );
            },
          );
        });
  }
}

final GetUserCubit _getUserCubit = Di().sl<GetUserCubit>();
