import 'dart:developer';

import 'package:bevy_messenger/bloc/cubits/internet_con_cubit.dart';
import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:bevy_messenger/helper/toast_messages.dart';
import 'package:bevy_messenger/pages/creategroup/data/models/chat_group_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/di/service_locator_imports.dart';

abstract class CreateGroupDataSource {
  Future<String> createGroup(BuildContext contxet, GroupModel groupData);
}

class CreateGroupDataSourceImpl implements CreateGroupDataSource {
  @override
  Future<String> createGroup(BuildContext context, GroupModel groupData) async {
    final InternetConCubit internetConnection = Di().sl<InternetConCubit>();
    await internetConnection.checkInternetConnection();
    if (internetConnection.isConnected) {
      try {
        AuthDataSource.firestore
            .collection("groups")
            .doc(groupData.id)
            .set(groupData.toJson());
        return "success";
      } catch (e) {
        // ignore: use_build_context_synchronously
        WarningHelper.showErrorToast("Error while creating group", context);
        log("Error while creating group: $e");
        return e.toString();
      }
    } else {
      // ignore: use_build_context_synchronously
      WarningHelper.showErrorToast(
          "Plesse check your internet then try again", context);
      return "internet not connected";
    }
  }
}
