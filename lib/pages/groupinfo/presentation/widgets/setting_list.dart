import 'dart:developer';

import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_user_data_cubit.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator_imports.dart';
import '../../../../utils/enums.dart';

class GroupSettingList extends StatefulWidget {
  const GroupSettingList({super.key});

  @override
  State<GroupSettingList> createState() => _GroupSettingListState();
}

class _GroupSettingListState extends State<GroupSettingList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppTextStyle(
            text: 'Participants Settings',
            fontSize: 14,
            color: AppColors.textColor,
            fontWeight: FontWeight.w700),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            const Icon(
              Icons.credit_card_rounded,
              color: AppColors.redColor,
            ),
            const SizedBox(
              width: 10,
            ),
              Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextStyle(
                    text: _getUserDataCubit.groupData.category == GroupCategory.room.name ? 'Premium Chat Room' : "Premium group",
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
                const SizedBox(
                  height: 5,
                ),
                const AppTextStyle(
                    text: 'Only for premium users',
                    fontSize: 14,
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w400),
              ],
            ),
            const Spacer(),
            BlocBuilder(
              bloc: _getUserDataCubit,
              builder: (context, state) {
                return Switch(
                  value: _getUserDataCubit.groupData.premium,
                  activeColor: AppColors.redColor,
                  inactiveThumbColor: AppColors.redColor,
                  inactiveTrackColor: AppColors.black,
                  trackOutlineColor:
                      const MaterialStatePropertyAll(AppColors.fieldsColor),
                  trackColor:
                      const MaterialStatePropertyAll(AppColors.containerBg),
                  activeTrackColor: AppColors.transparent,
                  onChanged: (value) async {
                    setState(() {
                      _getUserDataCubit.groupData =
                          _getUserDataCubit.groupData.copyWith(premium: value);
                      log("data ${_getUserDataCubit.groupData.premium}");
                    });
                    await AuthDataSource.updateGroupIsPremium(
                        _getUserDataCubit.groupData.id, value);
                  },
                );
              },
            )
          ],
        )
      ],
    );
  }
}

final GetUserDataCubit _getUserDataCubit = Di().sl<GetUserDataCubit>();
