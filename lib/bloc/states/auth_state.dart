part of '../cubits/auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthStateInitial extends AuthState {}

final class AuthStateLoading extends AuthState {}

final class AuthStateLoded extends AuthState {}
final class AuthStateError extends AuthState {}
