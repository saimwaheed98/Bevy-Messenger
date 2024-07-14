part of '../cubit/verify_otp_create_profile_cubit.dart';

class VerifyOtpCreateProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class VerifyOtpCreateProfileInitial extends VerifyOtpCreateProfileState {}

class VerifyOtpCreateProfileLoading extends VerifyOtpCreateProfileState {}

class VerifyOtpCreateProfileSuccess extends VerifyOtpCreateProfileState {}

class VerifyOtpCreateProfileFailed extends VerifyOtpCreateProfileState {
  final String message;
  VerifyOtpCreateProfileFailed({required this.message});
}

class GettingOtp extends VerifyOtpCreateProfileState {}

class OtpGetted extends VerifyOtpCreateProfileState {}
