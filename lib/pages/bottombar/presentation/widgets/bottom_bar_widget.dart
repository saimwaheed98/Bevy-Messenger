import 'dart:ui';

import 'package:bevy_messenger/pages/bottombar/presentation/widgets/bottom_bar_item.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:bevy_messenger/utils/images_path.dart';
import 'package:flutter/material.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 100,
      elevation: 10,
      surfaceTintColor: AppColors.transparent,
      color: AppColors.transparent,
      child: SizedBox(
        child: Container(
          height: 69,
          width: 310,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19),
            color: AppColors.bottomNavColor.withOpacity(0.49),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(19),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 5),
              child: Container(
                color: const Color(0xff9098C3).withOpacity(0.18),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 19),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BottomBarItem(
                        icon: AppImages.homeIcon,
                        text: 'Home',
                        index: 0,
                      ),
                      BottomBarItem(
                        icon: AppImages.profileIcon,
                        text: 'Profile',
                        index: 1,
                      ),
                      BottomBarItem(
                        icon: AppImages.chatIcon,
                        text: 'Chat Room',
                        index: 2,
                      ),
                      // BottomBarItem(
                      //   icon: AppImages.communityIcon,
                      //   text: 'Communities',
                      //   index: 3,
                      // ),
                      BottomBarItem(
                        icon: AppImages.privateChatIcon,
                        text: 'Your Bevy',
                        index: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
