part of '../cubit/login_cubit.dart';

class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoggingIn extends LoginState {}

final class LoggedIn extends LoginState {}

final class LoginFailed extends LoginState {}
