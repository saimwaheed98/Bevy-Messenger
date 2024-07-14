import 'package:bevy_messenger/pages/signup/data/datasources/create_profile_datasource.dart';
import 'package:flutter/material.dart';

import '../../domain/repositories/create_profile_repositorie.dart';

class CreateProfileRepositoryImpl implements CreateProfileRepository {
  final CreateProfileDataSource createProfileDataSource;
  CreateProfileRepositoryImpl(this.createProfileDataSource);

  @override
  Future<String> createProfile(String phoneNumber, BuildContext context) {
    return createProfileDataSource.createProfile(phoneNumber, context);
  }
}
