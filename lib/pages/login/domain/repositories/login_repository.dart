import 'package:flutter/material.dart';

abstract class LoginRepository {
  Future<String> login(BuildContext context);
}
