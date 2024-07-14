import 'package:bevy_messenger/pages/otp/data/datasources/verify_otp_datasource.dart';
import 'package:flutter/material.dart';
import '../../domain/repositories/verify_otp_repositorie.dart';

class VerifyOtpRepositoryImpl extends VerifyOtpRepository {
  final VerifyOtpDataSource verifyOtpDataSource;
  VerifyOtpRepositoryImpl(this.verifyOtpDataSource);
  @override
  Future<String> verifyOtpAndCreateProfile(
      String otp, BuildContext context) {
    return verifyOtpDataSource.verifyOtpAndCreateProfile(otp, context);
  }
}
