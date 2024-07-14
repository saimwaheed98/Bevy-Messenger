import 'package:flutter/material.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toasty_box.dart';

import '../utils/colors.dart';

class WarningHelper {
  static showWarningToast(String message, context) {
    return ToastService.showWarningToast(context,
        isClosable: true,
        length: ToastLength.short,
        shadowColor: AppColors.black.withOpacity(0.2),
        backgroundColor: AppColors.fieldsColor.withOpacity(0.8),
        positionCurve: Curves.easeInOut,
        slideCurve: Curves.easeOut,
        message: message);
  }

  static showErrorToast(String message, context) {
    return ToastService.showErrorToast(context,
        isClosable: true,
        length: ToastLength.short,
        shadowColor: AppColors.black.withOpacity(0.2),
        backgroundColor: AppColors.fieldsColor,
        positionCurve: Curves.easeInOut,
        slideCurve: Curves.easeOut,
        message: message);
  }

  static showSuccesToast(String message, context) {
    return ToastService.showSuccessToast(context,
        isClosable: true,
        length: ToastLength.short,
        shadowColor: AppColors.black.withOpacity(0.2),
        backgroundColor: Colors.green.shade300,
        positionCurve: Curves.easeInOut,
        slideCurve: Curves.easeOut,
        message: message);
  }
}
