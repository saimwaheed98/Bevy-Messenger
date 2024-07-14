import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/pages/creategroup/presentation/bloc/cubit/create_group_cubit.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupCreationSettingList extends StatelessWidget {
  final bool isRoom;
  const GroupCreationSettingList({super.key, required this.isRoom});

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
                    text: isRoom ?  'Premium Chat Room' : 'Premium Group',
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
              bloc: _createGroupCubit,
              builder: (context, state) {
                return Switch(
                  value: _createGroupCubit.premiumGroup,
                  activeColor: AppColors.redColor,
                  inactiveThumbColor: AppColors.redColor,
                  inactiveTrackColor: AppColors.black,
                  trackOutlineColor:
                      const MaterialStatePropertyAll(AppColors.fieldsColor),
                  trackColor:
                      const MaterialStatePropertyAll(AppColors.containerBg),
                  activeTrackColor: AppColors.transparent,
                  onChanged: (value) {
                    _createGroupCubit.setGroupPremium();
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

final CreateGroupCubit _createGroupCubit = Di().sl<CreateGroupCubit>();
