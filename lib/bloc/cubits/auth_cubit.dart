import 'dart:developer';
import 'dart:io';

import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:bevy_messenger/helper/toast_messages.dart';
import 'package:bevy_messenger/pages/signup/data/models/usermodel/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/subscription/data/model/subscription_model.dart';
part '../states/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthStateInitial());

  List<String> otherUsernames = [];
  List<String> otherUserEmail = [];

  Future<void> getOtherUsernames() async {
    emit(AuthStateLoading());
    otherUsernames = await AuthDataSource.getOtherUsernames();
    otherUserEmail = await AuthDataSource.getOtherEmails();
    emit(AuthStateLoded());
  }

  // get the user data anywhere
  UserModel userData = UserModel(
    id: AuthDataSource.auth.currentUser?.uid ?? '',
    name: '',
    email: '',
    phone: '',
    isOnline: true,
    address: '',
    imageUrl: '',
    password: '',
    createdAt: '',
    pushToken: '',
    subscription: true,
    blockedUsers: [],
    city: "",
    country: "",
    lastActive: "",
    state: "",
    blockedBy: [],
  );

  List<SubscriptionModel> userSubscriptions = [];

  // get the data of the user
  void getUserDataLocal(UserModel userModel) {
    emit(AuthStateLoading());
    userData = userModel;
    emit(AuthStateLoded());
  }

  // update the subscription list
  void updateSubscriptionList(SubscriptionModel subscription) {
    emit(AuthStateLoading());
    userSubscriptions.add(subscription);
    log(userSubscriptions.toString());
    emit(AuthStateLoded());
  }

  // update the username
  void updateName(String name) {
    emit(AuthStateLoading());
    userData = userData.copyWith(name: name);
    emit(AuthStateLoading());
  }

  // update the address
  void updateAddress(String country, String state, String city) {
    emit(AuthStateLoading());
    userData = userData.copyWith(country: country);
    userData = userData.copyWith(state: state);
    userData = userData.copyWith(city: city);
    emit(AuthStateLoded());
  }

  // update the phone number
  // update the address
  void updatePhoneNumber(String phoneNumber) {
    emit(AuthStateLoading());
    userData = userData.copyWith(phone: phoneNumber);
    emit(AuthStateLoded());
  }

  // update the image url
  void updateImageUrl(String imageUrl) {
    emit(AuthStateLoading());
    userData = userData.copyWith(imageUrl: imageUrl);
    emit(AuthStateLoded());
  }

  // add the user in the block list
  Future<void> addBlockedUser(String userId) async {
    emit(AuthStateLoading());
    userData =
        userData.copyWith(blockedUsers: [...userData.blockedUsers, userId]);
    await AuthDataSource.addBlockedUser(userId);
    log('user Blocked: ${userData.blockedUsers}');
    emit(AuthStateLoded());
  }

  // remove the block user
  Future<void> removeBlockedUser(String userId) async {
    emit(AuthStateLoading());
    userData = userData.copyWith(
        blockedUsers: userData.blockedUsers
            .where((element) => element != userId)
            .toList());
    await AuthDataSource.unBlockUser(userId);
    log('user Blocked: ${userData.blockedUsers}');
    emit(AuthStateLoded());
  }

  // update the user image file
  Future<void> updateUserImageFile(File imageFile) async {
    emit(AuthStateLoading());
    await AuthDataSource.uploadProfileImage(imageFile).then((image) {
      updateImageUrl(image);
    });
    emit(AuthStateLoded());
  }

Future<void> getSelfInfo() async {
  emit(AuthStateLoading());
  
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('userId');
    
    if (userId == null || userId.isEmpty) {
      emit(AuthStateError());
      return;
    }

    await _fetchAndSetUserInfo();
  } catch (e) {
    log('Failed to get self info: ${e.toString()}');
    emit(AuthStateError());
  }
}

Future<void> _fetchAndSetUserInfo() async {
  try {
    final userInfo = await AuthDataSource.getSelfInfo();
    userData = userInfo;

    final subscriptions = await AuthDataSource.getSubscriptions();
    userSubscriptions = subscriptions;

     emit(AuthStateLoded());
  } catch (e) {
    log('Failed to fetch user info or subscriptions: ${e.toString()}');
    emit(AuthStateError());
  }
}


  // update the subscription status
  removeSubscriptionList(String id) {
    emit(AuthStateLoading());
    var subscriptionIndex =
        userSubscriptions.indexWhere((element) => element.subscriptionId == id);
    if (subscriptionIndex != -1) {
      var updatedSubscriptions =
          List<SubscriptionModel>.from(userSubscriptions);
      updatedSubscriptions[subscriptionIndex] =
          updatedSubscriptions[subscriptionIndex]
              .copyWith(subscriptionStatus: false);
      userSubscriptions = updatedSubscriptions;
      log(userSubscriptions.toString());
      emit(AuthStateLoded());
    } else {
      log("error");
    }
  }

  // update the subscription status
  updateTheSubscriptionForMonth(String id) {
    emit(AuthStateLoading());
    var subscriptionIndex =
        userSubscriptions.indexWhere((element) => element.subscriptionId == id);
    if (subscriptionIndex != -1) {
      var updatedSubscriptions =
          List<SubscriptionModel>.from(userSubscriptions);
      final newEndingDate = DateTime.now().add(const Duration(days: 30));
      updatedSubscriptions[subscriptionIndex] =
          updatedSubscriptions[subscriptionIndex]
              .copyWith(endingData: newEndingDate.toString());
      userSubscriptions = updatedSubscriptions;
      log(userSubscriptions.toString());
      emit(AuthStateLoded());
    } else {
      log("error");
    }
  }

  // update the user info
  Future<void> updateUserInfo(String name, String phoneNumber, String country,
      String city, String state, BuildContext context) async {
    emit(AuthStateLoading());
    updateAddress(country, state, city);
    updateName(name);
    updatePhoneNumber(phoneNumber);
    await AuthDataSource.updateUserInfo(name, country, city, state, phoneNumber)
        .then((value) {
      emit(AuthStateLoded());
    });
    // ignore: use_build_context_synchronously
    WarningHelper.showSuccesToast("Info has been saved", context);
  }

  // update the online status
  Future<void> updateOnlineStatus(bool isOnline) async {
    await AuthDataSource.updateActiveStatus(isOnline);
  }
}
