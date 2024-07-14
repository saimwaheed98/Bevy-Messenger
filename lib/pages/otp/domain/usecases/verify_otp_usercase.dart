import 'package:bevy_messenger/pages/otp/domain/repositories/verify_otp_repositorie.dart';
import 'package:flutter/material.dart';

class VerifyOtpUseCase {
  final VerifyOtpRepository verifyOtpRepository;
  VerifyOtpUseCase(this.verifyOtpRepository);

  Future<String> verifyOtpAndCreateProfile(
      String otp, BuildContext context) async {
    return verifyOtpRepository.verifyOtpAndCreateProfile(otp, context);
  }
}
