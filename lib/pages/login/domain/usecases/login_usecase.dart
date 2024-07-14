import 'package:flutter/material.dart';

import '../repositories/login_repository.dart';

class LoginUseCase {
  final LoginRepository repository;
  LoginUseCase(this.repository);

  Future<String> login(BuildContext context) {
    return repository.login(context);
  }
}
