import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/pages/login/presentation/bloc/cubit/validate_text_fields_cubit.dart';
import 'package:bevy_messenger/pages/signup/presentation/bloc/cubit/create_profile_cubit.dart';
import 'package:bevy_messenger/routes/routes_imports.gr.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:bevy_messenger/utils/screen_sizes.dart';
import 'package:bevy_messenger/widgets/gesture_container.dart';
import 'package:bevy_messenger/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../widgets/phone_text_field.dart';
import '../../../otp/presentation/bloc/cubit/verify_otp_create_profile_cubit.dart';

@RoutePage()
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignUpPage> {
  final ValidateTextFieldsCubit _textFieldsCubit =
      Di().sl<ValidateTextFieldsCubit>();
  final CreateProfileCubit _createProfileCubit = Di().sl<CreateProfileCubit>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _createProfileCubit.checkFieldsSignUp();
      },
      child: Scaffold(
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
                      height: getHeight(context) * 0.1,
                    ),
                    const AppTextStyle(
                        text: 'Sign UP with Email',
                        fontSize: 24,
                        fontWeight: FontWeight.w700),
                    const SizedBox(
                      height: 5,
                    ),
                    AppTextStyle(
                        text:
                            'All Calls/Messages, Phone Calls and Video Calls,\n One on One Messenger, and Group Messenger are \nencrypted',
                        fontSize: 14,
                        color: AppColors.textColor.withOpacity(0.8),
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w700),
                    SizedBox(
                      height: getHeight(context) * 0.1,
                    ),
                    Column(
                      children: [
                        BlocBuilder (
                          bloc: _createProfileCubit,
                          builder: (context, state) {
                            return AuthTextField(
                              controller: _createProfileCubit.nameController,
                              feildName: 'Your Username',
                              errorText: _createProfileCubit.isTaken
                                  ? 'Username already taken'
                                  : '',
                              textColor: _createProfileCubit.isTaken
                                  ? AppColors.redColor
                                  : AppColors.white,
                              onChanged: (query) {
                                _createProfileCubit.checkUserName(context);
                              },
                              onSubmit: (value) {
                                _createProfileCubit.checkUserName(context);
                              },
                              suffixPressed: () {
                                _createProfileCubit.nameController.clear();
                              },
                              suffixIcon: const Icon(
                                Icons.cancel,
                                size: 16,
                                color: AppColors.textColor,
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        BlocBuilder(
                          bloc: _textFieldsCubit,
                          builder: (context, state) {
                            return AuthTextField(
                              controller: _createProfileCubit.emailController,
                              feildName: 'Your Email',
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
                              controller:
                                  _createProfileCubit.passwordController,
                              feildName: 'Password',
                              obscure: _createProfileCubit.obscurePassword,
                              suffixPressed: () {
                                _createProfileCubit.obscurePass();
                              },
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
                        const SizedBox(
                          height: 30,
                        ),
                        BlocBuilder(
                            bloc: _createProfileCubit,
                            builder: (context, state) {
                              return AuthTextField(
                                controller: _createProfileCubit
                                    .confirmPasswordController,
                                feildName: 'Confirm Password',
                                errorText: _textFieldsCubit.isPasswordValid
                                    ? ""
                                    : "Password Should be same",
                                onSubmit: (value) {
                                  _textFieldsCubit.checkIsPasswordMatch();
                                },
                                obscure: _createProfileCubit.obscurePassword,
                                suffixPressed: () {
                                  _createProfileCubit.obscurePass();
                                },
                                suffixIcon: Icon(
                                  _createProfileCubit.obscurePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 16,
                                  color: AppColors.textColor,
                                ),
                                textColor: _textFieldsCubit.isPasswordValid
                                    ? AppColors.white
                                    : AppColors.redColor,
                              );
                            }),
                        const SizedBox(
                          height: 30,
                        ),
                        BlocBuilder(
                          bloc: _textFieldsCubit,
                          builder: (context, state) {
                            return PhoneTextField(
                              feildName: 'Phone Number',
                              onChanged: (value) {
                                debugPrint(
                                    "data ${value.countryCode} : hello ${value.international}");
                                _createProfileCubit.phoneController.text =
                                    value.countryCode;
                                _textFieldsCubit.validatePhoneNumberTextFields(
                                    value.countryCode);
                              },
                              errorText: _textFieldsCubit.isPhoneNumberValid
                                  ? ''
                                  : 'Please enter a valid phone number',
                              textColor: _textFieldsCubit.isPhoneNumberValid
                                  ? AppColors.white
                                  : AppColors.redColor,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 30,
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
                        return GestureContainer(
                            isLoading: _createProfileCubit.isCreatingProfile,
                            buttonColor: _createProfileCubit.checkFieldsSignUp()
                                ? AppColors.redColor
                                : AppColors.textColor,
                            onPressed: () {
                              if(_createProfileCubit.isCreatingProfile) return;
                              _createProfileCubit.createProfile(context);
                            },
                            buttonText: "Continue",
                            heroTag: 'otp');
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        AutoRouter.of(context).replace(const LoginPageRoute());
                      },
                      child: const AppTextStyle(
                          text: "Already a Member? Login Here",
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

final VerifyOtpCreateProfileCubit _otpCreateProfileCubit =
    Di().sl<VerifyOtpCreateProfileCubit>();
