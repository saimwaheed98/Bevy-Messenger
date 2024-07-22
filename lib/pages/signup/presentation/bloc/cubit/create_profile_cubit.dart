import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/helper/toast_messages.dart';
import 'package:bevy_messenger/pages/signup/domain/usecases/create_profile_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/di/service_locator_imports.dart';
import '../../../../../routes/routes_imports.gr.dart';
import '../../../../login/presentation/bloc/cubit/validate_text_fields_cubit.dart';
part '../state/create_profile_state.dart';

class CreateProfileCubit extends Cubit<CreateProfileState> {
  final CreateProfileUsecase createProfileUsecase;
  CreateProfileCubit(this.createProfileUsecase) : super(CreateProfileInitial());

  bool isCreatingProfile = false;

  bool obscurePassword = true;

  obscurePass() {
    emit(CreateProfileLoading());
    obscurePassword = !obscurePassword;
    emit(CreateProfileSuccess());
  }

  String otpVerificationCode = '';
  int resendToken = 0;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isTaken = false;

  // check that if the user name is already taken
  checkUserName(BuildContext context) {
    final AuthCubit authCubit = Di().sl<AuthCubit>();
    emit(CreateProfileLoading());
    debugPrint('otherUsernames ${authCubit.otherUsernames}');
    for (var element in authCubit.otherUsernames) {
      if (element.replaceAll(" ", "") ==
          nameController.text.replaceAll(" ", "")) {
        isTaken = true;
        emit(CreateProfileSuccess());
        WarningHelper.showWarningToast('Username is already taken', context);
        return;
      } else {
        isTaken = false;
        emit(CreateProfileSuccess());
      }
    }
  }

  // check that if the field are filled
  bool checkFieldsLogin() {
    final ValidateTextFieldsCubit valid = Di().sl<ValidateTextFieldsCubit>();
    emit(CreateProfileLoading());
    valid.validateEmailTextFields(emailController.text);
    if (valid.isEmailValid && passwordController.text.length >= 6) {
      emit(CreateProfileSuccess());
      return true;
    } else {
      emit(CreateProfileSuccess());
      return false;
    }
  }

  // cd

  // check that if the field are filled
  bool checkFieldsSignUp() {
    final ValidateTextFieldsCubit valid = Di().sl<ValidateTextFieldsCubit>();
    emit(CreateProfileLoading());
    valid.validateEmailTextFields(emailController.text);
    if (valid.isEmailValid &&
        passwordController.text.length >= 6 &&
        nameController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        confirmPasswordController.text.length > 6) {
      emit(CreateProfileSuccess());
      return true;
    } else {
      emit(CreateProfileSuccess());
      return false;
    }
  }

  Future<void> createProfile(BuildContext context) async {
    if (!isAllFieldsValid()) {
      WarningHelper.showWarningToast('Please fill all fields', context);
    } else if (!isPasswordValid()) {
      WarningHelper.showWarningToast('Password should be same', context);
    } else {
      if (isTaken == false) {
        emit(CreateProfileLoading());
        isCreatingProfile = true;
        final result = await createProfileUsecase.createProfile(
            phoneController.text, context);
        if (result == 'success') {
        AutoRouter.of(context).replace(OtpPageRoute());
          emit(CreateProfileSuccess());
        } else {
          log("result $result");
          isCreatingProfile = false;
          emit(const CreateProfileFailed(message: 'Failed to create profile'));
        }
      }else{
        WarningHelper.showWarningToast('Please Change Your Username. This Is Already Taken', context);
      }
    }
  }

  bool isAllFieldsValid() {
    return emailController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty;
  }

  bool isPasswordValid() {
    return passwordController.text == confirmPasswordController.text;
  }

  void clearTextFields() {
    emailController.clear();
    nameController.clear();
    phoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    resendToken = 0;
    otpVerificationCode = '';
  }

  getOtpData(String verificationCode, int resendToken) {
    emit(CreateProfileLoading());
    otpVerificationCode = verificationCode;
    this.resendToken = resendToken;
    emit(CreateProfileSuccess());
  }
}
