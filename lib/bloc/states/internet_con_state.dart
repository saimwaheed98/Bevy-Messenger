part of '../cubits/internet_con_cubit.dart';

sealed class InternetConState extends Equatable {
  const InternetConState();

  @override
  List<Object> get props => [];
}

final class InternetConInitial extends InternetConState {}

final class InternetConConnected extends InternetConState {}

final class InternetConDisconnected extends InternetConState {}
