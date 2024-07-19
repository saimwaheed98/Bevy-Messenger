import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/pages/login/presentation/bloc/cubit/login_cubit.dart';
import 'package:bevy_messenger/pages/login/presentation/bloc/cubit/validate_text_fields_cubit.dart';
import 'package:bevy_messenger/pages/signup/presentation/bloc/cubit/create_profile_cubit.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:bevy_messenger/utils/images_path.dart';
import 'package:bevy_messenger/utils/screen_sizes.dart';
import 'package:bevy_messenger/widgets/gesture_container.dart';
import 'package:bevy_messenger/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../routes/routes_imports.gr.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ValidateTextFieldsCubit _textFieldsCubit =
      Di().sl<ValidateTextFieldsCubit>();
  final CreateProfileCubit _createProfileCubit = Di().sl<CreateProfileCubit>();
  final LoginCubit _loginCubit = Di().sl<LoginCubit>();

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
                          color: AppColors.black,
                        )),
                  ),
                  SizedBox(
                    height: 86,
                    width: 86,
                    child: Image.asset(AppImages.appIcon),
                  ),
                  const AppTextStyle(
                      text: 'Log in',
                      fontSize: 48,
                      fontWeight: FontWeight.w700),
                  const SizedBox(
                    height: 5,
                  ),
                  AppTextStyle(
                      text:
                          'Welcome back! Sign in using your\n  email to continue us',
                      fontSize: 14,
                      color: AppColors.textColor.withOpacity(0.8),
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w700),
                  SizedBox(
                    height: getHeight(context) * 0.15,
                  ),
                  Column(
                    children: [
                      BlocBuilder(
                        bloc: _textFieldsCubit,
                        builder: (context, state) {
                          return AuthTextField(
                            controller: _createProfileCubit.emailController,
                            feildName: 'Your email',
                            inputType: TextInputType.emailAddress,
                            errorText: _textFieldsCubit.isEmailValid
                                ? ''
                                : 'Please enter a valid email',
                            textColor: _textFieldsCubit.isEmailValid
                                ? AppColors.white
                                : AppColors.redColor,
                            suffixPressed: () {
                              _createProfileCubit.emailController.clear();
                            },
                            suffixIcon: const Icon(
                              Icons.cancel,
                              size: 16,
                              color: AppColors.textColor,
                            ),
                            onSubmit: (p0) => _createProfileCubit.checkFieldsLogin(),
                            onChanged: (query) {
                              _textFieldsCubit.validateEmailTextFields(query);
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      BlocBuilder(
                        bloc: _createProfileCubit,
                        builder: (context, state) {
                          return AuthTextField(
                            controller: _createProfileCubit.passwordController,
                            feildName: 'Password',
                            inputType: TextInputType.visiblePassword,
                            obscure: _createProfileCubit.obscurePassword,
                            suffixPressed: () {
                              _createProfileCubit.obscurePass();
                            },
                            onSubmit: (p0) => _createProfileCubit.checkFieldsLogin(),
                            suffixIcon: Icon(
                              _createProfileCubit.obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 16,
                              color: AppColors.textColor,
                            ),
                          );
                        },
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            AutoRouter.of(context)
                                .push(const ForgotPasswordPageRoute());
                          },
                          child: const AppTextStyle(
                              text: 'Forgot Password',
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Spacer(),
                  BlocBuilder(
                    bloc: _createProfileCubit,
                    builder: (context, state) {
                      return BlocBuilder(
                          bloc: _loginCubit,
                          builder: (context, state) {
                            return GestureContainer(
                                isLoading: _loginCubit.isLoginIn,
                                buttonColor: _createProfileCubit.checkFieldsLogin() ? AppColors.redColor
                                    : AppColors.textColor,
                                onPressed: () async {
                                  if (_createProfileCubit
                                          .passwordController.text.isNotEmpty &&
                                      _createProfileCubit
                                          .emailController.text.isNotEmpty) {
                                    // await _loginCubit.login(context);
                                  }
                                },
                                buttonText: "Login",
                                heroTag: 'login');
                          });
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {
                      AutoRouter.of(context).push(const SignUpPageRoute());
                    },
                    child: const AppTextStyle(
                        text: "Not a Member? Sign Up here",
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 40,
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
