import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/pages/signup/presentation/bloc/cubit/create_profile_cubit.dart';
import 'package:bevy_messenger/routes/routes_imports.gr.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:bevy_messenger/utils/images_path.dart';
import 'package:bevy_messenger/utils/screen_sizes.dart';
import 'package:bevy_messenger/widgets/gesture_container.dart';
import 'package:bevy_messenger/widgets/login_text.dart';
import 'package:flutter/material.dart';

@RoutePage()
class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            Transform.rotate(
              angle: 134.23,
              child: Container(
                height: 244,
                width: getHeight(context),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.primaryColor.withOpacity(0.7),
                        blurRadius: 200,
                        spreadRadius: 30,
                        offset: const Offset(0, 10)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: SizedBox(
                      height: 86,
                      width: 86,
                      child: Image.asset(AppImages.appIcon),
                    ),
                  ),
                  Text.rich(TextSpan(children: [
                    TextSpan(
                      text: 'Connect \nfriends \n',
                      style: TextStyle(
                          fontSize: 68,
                          fontFamily: 'dmSans',
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColor.withOpacity(0.8)),
                    ),
                    TextSpan(
                      text: 'easily &\nquickly',
                      style: TextStyle(
                          fontSize: 68,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textColor.withOpacity(0.8)),
                    ),
                  ])),
                  const AppTextStyle(
                      text:
                          'Our chat app is the perfect way to\nstay connected with friends and\nfamily.',
                      fontSize: 16,
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w700),
                  SizedBox(
                    height: getHeight(context) * 0.1,
                  ),
                  GestureContainer(
                      onPressed: () {
                        _createProfileCubit.isCreatingProfile = false;
                        AutoRouter.of(context).push(const SignUpPageRoute());
                      },
                      buttonText: 'Sign Up',
                      heroTag: 'signup')
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: LoginRichText(
          onTap: () {
            AutoRouter.of(context).push(const LoginPageRoute());
          },
          accountText: 'Already a Member?',
          authText: 'Login Here'),
    );
  }
}

final CreateProfileCubit _createProfileCubit = Di().sl<CreateProfileCubit>();
