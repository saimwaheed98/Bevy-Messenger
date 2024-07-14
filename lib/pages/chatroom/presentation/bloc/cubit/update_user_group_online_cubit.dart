import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

import '../../../domain/usecases/update_group_user_online_usecase.dart';

part '../state/update_user_group_online_state.dart';

class UpdateUserGroupOnlineCubit extends Cubit<UpdateUserGroupOnlineState> {
  final UpdateUserGroupOnlineUseCase _updateUserGroupOnlineUseCase;
  UpdateUserGroupOnlineCubit(this._updateUserGroupOnlineUseCase)
      : super(UpdateUserGroupOnlineInitial());
  final AuthCubit authCubit = Di().sl<AuthCubit>();

  Future<void> updateGroupUserOnline(String groupId) async {
    emit(UpdateUserGroupOnlineLoading());
    await _updateUserGroupOnlineUseCase.updateStatus(
        groupId, authCubit.userData.id);
    emit(UpdateUserGroupOnlineSuccess());
  }

  Future<void> removeOnlineStatus(String groupId) async {
    emit(UpdateUserGroupOnlineLoading());
    await _updateUserGroupOnlineUseCase.removeOnlineStatus(
        groupId, authCubit.userData.id);
    emit(UpdateUserGroupOnlineSuccess());
  }

  // update and remove the online status by system chanels
  Future<void> updateGroupUserOnlineBySystem(String groupId) async {
    SystemChannels.lifecycle.setMessageHandler((message) async {
      if (message.toString().contains('resume')) {
        await _updateUserGroupOnlineUseCase.updateStatus(
            groupId, authCubit.userData.id);
      } else {
        await _updateUserGroupOnlineUseCase.removeOnlineStatus(
            groupId, authCubit.userData.id);
      }
      return Future.value(message);
    });
  }
}
