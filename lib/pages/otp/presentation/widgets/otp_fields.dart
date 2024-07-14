import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/pages/otp/presentation/bloc/cubit/verify_otp_create_profile_cubit.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpField extends StatelessWidget {
  const OtpField({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 60,
      textStyle: const TextStyle(
          fontSize: 20,
          color: AppColors.textColor,
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: const Color(0xff2C2D2F),
        borderRadius: BorderRadius.circular(5),
      ),
    );

    return Pinput(
      length: 6,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme,
      androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
      showCursor: true,
      onCompleted: (pin) {
        _createProfileCubit.setOtp(pin);
      },
    );
  }
}

final VerifyOtpCreateProfileCubit _createProfileCubit =
    Di().sl<VerifyOtpCreateProfileCubit>();
