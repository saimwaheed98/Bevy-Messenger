import 'package:flutter/material.dart';

import '../../domain/repositories/login_repository.dart';
import '../datasources/login_datasource.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginDataSource loginDataSource;
  LoginRepositoryImpl(this.loginDataSource);
  @override
  Future<String> login(BuildContext context) {
    return loginDataSource.login(context);
  }
}
