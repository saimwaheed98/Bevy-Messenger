import 'package:bevy_messenger/helper/cached_image_helper.dart';
import 'package:bevy_messenger/pages/signup/data/models/usermodel/user_model.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class RecentChatContainer extends StatelessWidget {
  final UserModel userModel;
  const RecentChatContainer({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.5),
      child: Column(
        children: [
          CachedImageHelper(
              imageUrl: userModel.imageUrl, height: 60, width: 60),
          const SizedBox(
            height: 5,
          ),
          AppTextStyle(
              text: userModel.name, fontSize: 14, fontWeight: FontWeight.w500)
        ],
      ),
    );
  }
}
