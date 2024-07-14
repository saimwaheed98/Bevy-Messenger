import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:bevy_messenger/helper/toast_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator_imports.dart';
import '../../../../utils/app_text_style.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/images_path.dart';
import '../../../../utils/screen_sizes.dart';
import '../../../../widgets/gesture_container.dart';
import '../../../../widgets/text_field.dart';
import '../../../login/presentation/bloc/cubit/validate_text_fields_cubit.dart';

@RoutePage()
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final ValidateTextFieldsCubit _textFieldsCubit =
      Di().sl<ValidateTextFieldsCubit>();

  final TextEditingController _emailController = TextEditingController();

  bool isLoading = false;

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
                      text: "Forgot Password",
                      fontSize: 48,
                      fontWeight: FontWeight.w700),
                  const SizedBox(
                    height: 5,
                  ),
                  AppTextStyle(
                      text:
                          'Enter your email address below to reset your password. You will receive an email with instructions on how to reset your password.',
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
                            controller: _emailController,
                            feildName: 'Your email',
                            errorText: _textFieldsCubit.isEmailValid
                                ? ''
                                : 'Please enter a valid email',
                            textColor: _textFieldsCubit.isEmailValid
                                ? AppColors.white
                                : AppColors.redColor,
                            onChanged: (query) {
                              _textFieldsCubit.validateEmailTextFields(query);
                            },
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
                  GestureContainer(
                      isLoading: isLoading,
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await AuthDataSource.auth
                            .sendPasswordResetEmail(
                                email: _emailController.text)
                            .then((value) {
                          WarningHelper.showWarningToast(
                              "Password has been sended to your email address",
                              context);
                          setState(() {
                            isLoading = false;
                          });
                        }).onError((error, stackTrace) {
                          WarningHelper.showWarningToast(
                              error.toString(), context);
                          setState(() {
                            isLoading = false;
                          });
                        });
                      },
                      buttonText: "Reset Password",
                      heroTag: 'Reset Password'),
                  const SizedBox(
                    height: 10,
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
