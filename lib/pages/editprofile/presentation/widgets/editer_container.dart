import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:bevy_messenger/utils/screen_sizes.dart';
import 'package:flutter/material.dart';

class EditerContainer extends StatelessWidget {
  final String editText;
  final bool? isReadOnly;
  final TextEditingController controller;
  const EditerContainer(
      {super.key,
      required this.editText,
      required this.controller,
      this.isReadOnly});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: getWidth(context),
      padding: const EdgeInsets.symmetric(horizontal: 17),
      decoration: BoxDecoration(
        color: AppColors.black.withOpacity(0.25),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          AppTextStyle(
              text: editText,
              fontSize: 14,
              color: AppColors.textColor,
              fontWeight: FontWeight.w700),
          Expanded(
            child: TextFormField(
              cursorColor: AppColors.white,
              cursorHeight: 22,
              cursorWidth: 2,
              readOnly: isReadOnly ?? false,
              controller: controller,
              style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: "dmSans"),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter your $editText",
                hintStyle: const TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: "dmSans"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
