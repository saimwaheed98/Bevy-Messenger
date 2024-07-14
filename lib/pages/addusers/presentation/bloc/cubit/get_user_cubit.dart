import 'dart:async';
import 'dart:developer';

import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:bevy_messenger/pages/signup/data/models/usermodel/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:shared_preferences/shared_preferences.dart';
part '../state/get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  GetUserCubit() : super(GetUserInitial());

  final TextEditingController searchController = TextEditingController();
  final _userStreamController = StreamController<UserModel>.broadcast();
  Stream<UserModel> get userStream => _userStreamController.stream;

  // add the saerch value in the controller
  addValueInController(String value) {
    searchController.text = value;
  }

  List<UserModel> users = [];
  List<UserModel> searchedUsers = [];
  bool isSearching = false;

  void getUsers(List<UserModel> users) {
    emit(GetUserLoading());
    users.removeWhere((user) => contactsUsers.contains(user));
    this.users = users;
    emit(GetUserLoaded());
  }

  // remove the user from usersList
  removeUser(UserModel user) {
    emit(GetUserLoading());
    users.remove(user);
    emit(GetUserLoaded());
  }

  // then add the bloc user in the chat room block list
  addUserToGroupBlockList(String userId, String groupId) async {
    final AuthCubit authCubit = Di().sl<AuthCubit>();
    await AuthDataSource.firestore.collection("groups").doc(groupId).update({
      'members': FieldValue.arrayRemove([userId]),
      "updatedAt": DateTime.now().millisecondsSinceEpoch.toString(),
      "updatedBy": authCubit.userData.id,
      "blockedUsers": FieldValue.arrayUnion([userId])
    });
  }

  // search the users
  searchUsers(String query) {
    emit(GetUserLoading());
    isSearching = true;

    List<UserModel> filteredUsers =
        users.where((user) => !contactsUsers.contains(user)).toList();

    List<UserModel> userdata = [
      ...filteredUsers,
      ...contactsUsers,
    ];

    List<UserModel> searchedUsers = userdata
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()) ||
            element.phone.contains(query))
        .toList();

    this.searchedUsers = searchedUsers;
    emit(GetUserLoaded());
  }

  cancelSearch() {
    emit(GetUserLoading());
    isSearching = false;
    emit(GetUserLoaded());
  }

  // get the users on bevy which are from contacts
  List<String> contacts = [];
  final Set<UserModel> contactsUsers = {};


  Future<void> fetchContactsAndUsers() async {
    emit(GettingContactsUsers());
    try {
      List<Contact> contacts = await _getContacts();
      List<String> contactNumbers = _extractContactNumbers(contacts);
      await _fetchUsersFromDatabase(contactNumbers);
      log('Contacts and users fetched');
      emit(ContactUserGetted());
    } catch (e, stackTrace) {
      log('Error fetching contacts and users: $e $stackTrace');
    }
  }

  Future<List<Contact>> _getContacts() async {
    if (await FlutterContacts.requestPermission()) {
      return FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: false,
      );
    } else {
      throw Exception('Permission denied to access contacts');
    }
  }

  List<String> _extractContactNumbers(List<Contact> contacts) {
    return contacts.expand((contact) {
      return contact.phones.map((phone) => phone.normalizedNumber);
    }).toList();
  }

  Future<void> _fetchUsersFromDatabase(List<String> contactNumbers) async {
    for (var number in contactNumbers) {
      // log("user number $formattedNumber");
      await _fetchUserFromDatabase(number);
    }
  }

  Future<void> _fetchUserFromDatabase(String phoneNumber) async {
    try {
      final snapshot = await AuthDataSource.firestore
          .collection("users")
          .where("phone", isEqualTo: phoneNumber)
          .get();
      if (snapshot.docs.isNotEmpty) {
        final user = UserModel.fromJson(snapshot.docs.first.data());
        if (contactsUsers.add(user)) {
          users.remove(user);
          _userStreamController.add(user);
          emit(ContactUserGetted());
        }
        log('User found for phone number: $contactsUsers');
      }
    } catch (e, stackTrace) {
      log(
        'Error fetching user for phone number: $phoneNumber with error: $e $stackTrace',
      );
      _userStreamController.addError(e, stackTrace);
    }
  }

  // get the search list
  List<String> searchList = [];
  Future<void> getSearchList() async {
    emit(GetUserLoading());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    emit(GetUserLoaded());
    searchList = prefs.getStringList("searchList") ?? [];
    log("search list $searchList");
    emit(GetUserLoaded());
  }

  // remove the query from the list
  Future<void> removeSearchQuery(String query) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> searchList = prefs.getStringList("searchList") ?? [];
    emit(GetUserLoading());
    if (searchList.contains(query)) {
      emit(GetUserLoaded());
      searchList.remove(query);
      prefs.setStringList("searchList", searchList);
      this.searchList.remove(query);
      log("search list $searchList");
      emit(GetUserLoaded());
    }
  }

  // save the search in the local db
  Future<void> saveSearch(String query) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> searchList = prefs.getStringList("searchList") ?? [];
    emit(GetUserLoading());
    if (query.isNotEmpty) {
      if (!searchList.contains(query)) {
        searchList.add(query);
        prefs.setStringList("searchList", searchList);
        log("search list $searchList");
        emit(GetUserLoaded());
        this.searchList = searchList;
        emit(GetUserLoaded());
      }
    }
  }
}
