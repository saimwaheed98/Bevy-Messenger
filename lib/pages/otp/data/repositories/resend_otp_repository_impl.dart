import 'package:flutter/material.dart';

import '../../domain/repositories/resend_otp_repository.dart';
import '../datasources/resend_otp_datasource.dart';

class ResendOtpRepositoryImpl extends ResendOtpRepository {
  final ResendOtpDataSource dataSource;

  ResendOtpRepositoryImpl(this.dataSource);

  @override
  Future<String> resendOtp(String phoneNumber, BuildContext context) {
    return dataSource.resendOtp(phoneNumber, context);
  }
}
