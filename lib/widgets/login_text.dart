import 'package:flutter/material.dart';
import '../utils/colors.dart';

class LoginRichText extends StatelessWidget {
  final Function()? onTap;
  final String accountText;
  final Color? textColor;
  final String authText;
  const LoginRichText(
      {super.key,
      this.onTap,
      required this.accountText,
      required this.authText,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: RichText(
          text: TextSpan(
        children: [
          TextSpan(
            text: '$accountText  ',
            style: TextStyle(
              color: AppColors.textColor.withOpacity(0.8),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(
            text: authText,
            style: TextStyle(
              color: textColor ?? AppColors.textColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      )),
    );
  }
}
