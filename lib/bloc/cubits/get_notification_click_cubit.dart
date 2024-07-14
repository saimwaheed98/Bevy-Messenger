import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../data/datasources/check_notification_click_datasource.dart';

part '../states/get_notification_click_state.dart';

class GetNotificationClickCubit extends Cubit<GetNotificationClickState> {
  final CheckNotificationClickDataSource checkNotificationClickDataSource;
  GetNotificationClickCubit(this.checkNotificationClickDataSource)
      : super(GetNotificationClickInitial());

  // get the notification click

  Future<void> getNotificationClick(BuildContext context) async {
    emit(GetNotificationClickLoading());
    checkNotificationClickDataSource.checkNotificationClick(context);
    emit(GetNotificationClickLoaded());
  }

  // handle the interected message
  Future<void> handleInteractedMessage(BuildContext context) async {
    emit(GetNotificationClickLoading());
    await checkNotificationClickDataSource.setupInteractedMessage(context);
    emit(GetNotificationClickLoaded());
  }
}
