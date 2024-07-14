part of '../cubits/check_app_update_cubit.dart';

sealed class CheckAppUpdateState extends Equatable {
  const CheckAppUpdateState();

  @override
  List<Object> get props => [];
}

final class CheckAppUpdateInitial extends CheckAppUpdateState {}

final class CheckAppUpdateAvailable extends CheckAppUpdateState {}

final class CheckAppUpdateNotAvailable extends CheckAppUpdateState {}
