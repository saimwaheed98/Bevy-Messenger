part of '../cubits/get_notification_click_cubit.dart';

sealed class GetNotificationClickState extends Equatable {
  const GetNotificationClickState();

  @override
  List<Object> get props => [];
}

final class GetNotificationClickInitial extends GetNotificationClickState {}

// get the notification click
final class GetNotificationClickLoading extends GetNotificationClickState {}

final class GetNotificationClickLoaded extends GetNotificationClickState {}
