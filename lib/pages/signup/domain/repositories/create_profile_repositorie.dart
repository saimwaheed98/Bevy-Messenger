import 'package:flutter/material.dart';

abstract class CreateProfileRepository {
  Future<String> createProfile(String phoneNumber, BuildContext context);
}
