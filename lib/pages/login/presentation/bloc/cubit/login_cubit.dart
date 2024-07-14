// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/helper/toast_messages.dart';
import 'package:bevy_messenger/pages/login/domain/usecases/login_usecase.dart';
import 'package:bevy_messenger/routes/routes_imports.gr.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part "../state/login_state.dart";

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  LoginCubit(this._loginUseCase) : super(LoginInitial());

  bool isLoginIn = false;

  // login function
  Future<String> login(BuildContext context) async {
    if (isLoginIn) return "Wait";
    emit(LoggingIn());
    isLoginIn = true;
    final result = await _loginUseCase.login(context);
    if (result.contains("Success")) {
      isLoginIn = false;
      emit(LoggedIn());
      WarningHelper.showSuccesToast("Login Successfuly", context);
      AutoRouter.of(context).pushAndPopUntil(
        const HomeBottomBarRoute(),
        predicate: (route) => false,
      );
      return result;
    } else {
      isLoginIn = false;
      emit(LoginFailed());
      throw Exception("Failed to login");
    }
  }
}
