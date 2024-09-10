import 'dart:developer';

import 'package:bevy_messenger/bloc/cubits/image_picker_cubit.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/pages/bottombar/presentation/bloc/cubit/bottom_bar_cubit.dart';
import 'package:bevy_messenger/pages/creategroup/presentation/bloc/cubit/create_group_cubit.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../userProfile/presentation/bloc/cubit/other_user_data_cubit.dart';

class BottomBarItem extends StatelessWidget {
  final String icon;
  final String text;
  final int index;
  const BottomBarItem(
      {super.key, required this.icon, required this.text, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _barCubit,
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            // if (_barCubit.currentIndex != 1) {

            _otherUserDataCubit.userData = null;
            _createGroupCubit.emptyParticipants();
            _imagePickerCubit.clearImage();
            _imagePickerCubit.clearVideo();
            _imagePickerCubit.clearFile();

            log("making image empty");
            // }
            _barCubit.changeIndex(index);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_barCubit.currentIndex == index)
                Container(
                  height: 3,
                  width: 14,
                  decoration: BoxDecoration(
                      color: AppColors.redColor,
                      borderRadius: BorderRadius.circular(18)),
                ),
              const SizedBox(
                height: 6,
              ),
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                    color: _barCubit.currentIndex == index
                        ? AppColors.redColor
                        : AppColors.transparent,
                    shape: BoxShape.circle),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(icon),
                  ],
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              AppTextStyle(
                  text: text, fontSize: 10, fontWeight: FontWeight.w600)
            ],
          ),
        );
      },
    );
  }
}

final OtherUserDataCubit _otherUserDataCubit = Di().sl<OtherUserDataCubit>();
final BottomBarCubit _barCubit = Di().sl<BottomBarCubit>();
final CreateGroupCubit _createGroupCubit = Di().sl<CreateGroupCubit>();
final ImagePickerCubit _imagePickerCubit = Di().sl<ImagePickerCubit>();
