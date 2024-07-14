import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class ArrowBack extends StatelessWidget {
  final Function()? onTap;
  const ArrowBack({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return    GestureDetector(
      onTap: onTap ?? () async {
        AutoRouter.of(context).pop();
      },
      child: Container(
        height: 40,
        width: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.containerBg,
          border: Border.all(color: AppColors.containerBorder, width: 1.2),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.arrow_back_ios,
          size: 18,
          color: AppColors.white,
        ),
      ),
    );
  }
}
