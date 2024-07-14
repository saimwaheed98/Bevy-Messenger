import 'package:flutter/material.dart';


abstract class VerifyOtpRepository {
  Future<String> verifyOtpAndCreateProfile(String otp, BuildContext context);
}
