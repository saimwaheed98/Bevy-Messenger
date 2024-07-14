import 'package:bevy_messenger/pages/otp/domain/repositories/resend_otp_repository.dart';
import 'package:flutter/material.dart';

class ResendOtpUseCase {
  final ResendOtpRepository repository;

  ResendOtpUseCase(this.repository);

  Future<String> resendOtp(String phoneNumber, BuildContext context) {
    return repository.resendOtp(phoneNumber, context);
  }
}
