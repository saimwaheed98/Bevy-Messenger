import 'package:flutter/material.dart';

abstract class ResendOtpRepository {
  Future<String> resendOtp(String phoneNumber, BuildContext context);
}
