import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/pages/signup/data/models/usermodel/user_model.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:flutter/material.dart';

import '../../../addusers/presentation/bloc/cubit/get_user_cubit.dart';
import '../bloc/cubit/other_user_data_cubit.dart';

blockUserDialouge(BuildContext context) {
  final AuthCubit authCubit = Di().sl<AuthCubit>();
  final OtherUserDataCubit getUserDataCubit = Di().sl<OtherUserDataCubit>();
  final GetUserCubit getUserCubit = Di().sl<GetUserCubit>();
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          elevation: 0,
          backgroundColor: AppColors.textSecColor,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: AppTextStyle(
                      text: "Block User",
                      fontSize: 20,
                      fontWeight: FontWeight.w600)),
              const AppTextStyle(
                  text:
                      "They wont be able to find your profile and chats.Bevy Messenger won't let them know you blocked them",
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: AppColors.primaryColor),
                      onPressed: () {
                        authCubit.addBlockedUser(
                            getUserDataCubit.userData?.id ?? "");
                        getUserCubit.removeUser(
                            getUserDataCubit.userData ?? const UserModel());
                        Navigator.of(context).pop();
                      },
                      child: const AppTextStyle(
                          text: "Block User",
                          fontSize: 13,
                          fontWeight: FontWeight.bold)),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          side: const BorderSide(
                              color: Color(0xff868686), width: 1),
                          backgroundColor: AppColors.buttonColor),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const AppTextStyle(
                          text: "Cancel",
                          fontSize: 13,
                          fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ));
    },
  );
}
