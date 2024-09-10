import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/pages/creategroup/presentation/bloc/cubit/create_group_cubit.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:bevy_messenger/utils/images_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../signup/data/models/usermodel/user_model.dart';

class ParticipiantContainer extends StatelessWidget {
  final UserModel user;
  const ParticipiantContainer({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: AppColors.containerBg,
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
                      text: user.name,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  width: 170,
                  child: AppTextStyle(
                      text: '@${user.name}',
                      fontSize: 14,
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            const Spacer(),
            if (user.id == _authCubit.userData.id)
              Container(
                width: 94,
                height: 26,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.green.withOpacity(0.3)),
                child: const AppTextStyle(
                    text: 'Room Admin',
                    fontSize: 12,
                    color: Colors.green,
                    fontWeight: FontWeight.w400),
              ),
            // if (user.id != _authCubit.userData.id)
            //   IconButton(
            //       onPressed: () {
            //         _createGroupCubit.addParticipiants(user);
            //       },
            //       icon: SvgPicture.asset(AppImages.leaveGroup))
          ],
        ),
      ),
    );
  }
}

final AuthCubit _authCubit = Di().sl<AuthCubit>();
final CreateGroupCubit _createGroupCubit = Di().sl<CreateGroupCubit>();
