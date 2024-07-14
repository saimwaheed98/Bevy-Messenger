import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/pages/otp/presentation/bloc/cubit/resend_otp_cubit.dart';
import 'package:bevy_messenger/pages/otp/presentation/bloc/cubit/verify_otp_create_profile_cubit.dart';
import 'package:bevy_messenger/pages/otp/presentation/widgets/otp_fields.dart';
import 'package:bevy_messenger/widgets/login_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator_imports.dart';
import '../../../../utils/app_text_style.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/screen_sizes.dart';
import '../../../../widgets/gesture_container.dart';
import '../../../signup/presentation/bloc/cubit/create_profile_cubit.dart';

@RoutePage()
class OtpPage extends StatelessWidget {
  OtpPage({super.key});

  final VerifyOtpCreateProfileCubit _otpCreateProfileCubit =
      Di().sl<VerifyOtpCreateProfileCubit>();
  final ResendOtpCubit _resendOtpCubit = Di().sl<ResendOtpCubit>();

  final CreateProfileCubit createProfileCubit = Di().sl<CreateProfileCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textSecColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: CustomScrollView(slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                        onPressed: () {
                          AutoRouter.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          color: AppColors.white,
                        )),
                  ),
                  SizedBox(
                    height: getWidth(context) * 0.3,
                  ),
                  const AppTextStyle(
                      text: 'Enter your verification code',
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                  const SizedBox(
                    height: 5,
                  ),
                  AppTextStyle(
                      text:
                          'We have sent a verification code to\n${createProfileCubit.phoneController.text}',
                      fontSize: 14,
                      color: AppColors.textColor.withOpacity(0.8),
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w700),
                  const SizedBox(
                    height: 20,
                  ),
                  const OtpField(),
                  const SizedBox(
                    height: 32,
                  ),
                  InkWell(
                    onTap: () {
                      _resendOtpCubit.resendOtp(context);
                    },
                    child: const LoginRichText(
                        accountText: 'Haven’t received the code?',
                        textColor: AppColors.redColor,
                        authText: 'Resend code'),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  BlocBuilder(
                    bloc: _otpCreateProfileCubit,
                    builder: (context, state) {
                      return GestureContainer(
                          isLoading: _otpCreateProfileCubit.isVerifyingOtp,
                          onPressed: () {
                            _otpCreateProfileCubit.verifyOtpAndCreateProfile(
                                _otpCreateProfileCubit.getOtp, context);
                          },
                          buttonText: "Continiue",
                          heroTag: 'otp');
                    },
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
