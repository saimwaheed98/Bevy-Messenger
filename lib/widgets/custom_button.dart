import 'package:bevy_messenger/utils/colors.dart';
import 'package:flutter/material.dart';

import '../utils/app_text_style.dart';

class CustomButton extends StatelessWidget {
  final Function() onPressed;
  final String buttonText;
  final Color? buttonColor;
  final String heroTag;
  final double? radius;
  final bool isLoading;
  final Widget? icon;
  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.buttonText,
      this.buttonColor,
      required this.heroTag,
      this.radius,
      this.isLoading = false,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            maximumSize: const Size(double.infinity, 48),
            backgroundColor: buttonColor ?? AppColors.redColor,
            minimumSize: const Size(double.infinity, 48),
            foregroundColor: AppColors.black,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 20),
            ),
          ),
          child: isLoading == true
              ? const SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primaryColor,
                    backgroundColor: AppColors.white,
                  ))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon ?? const SizedBox(),
                    if (icon != null)
                      const SizedBox(
                        width: 10,
                      ),
                    AppTextStyle(
                      text: buttonText,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ],
                )),
    );
  }
}
