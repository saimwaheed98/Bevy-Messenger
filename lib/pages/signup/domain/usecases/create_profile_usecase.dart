import 'package:bevy_messenger/pages/signup/domain/repositories/create_profile_repositorie.dart';
import 'package:flutter/material.dart';

class CreateProfileUsecase {
  final CreateProfileRepository _profileRepository;
  CreateProfileUsecase(this._profileRepository);

  Future<String> createProfile(String phoneNumber, BuildContext context) {
    return _profileRepository.createProfile(phoneNumber, context);
  }
}
