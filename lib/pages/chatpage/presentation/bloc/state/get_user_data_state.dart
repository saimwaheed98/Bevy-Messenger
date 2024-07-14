part of '../cubit/get_user_data_cubit.dart';

class GetUserDataState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class GetUserDataInitial extends GetUserDataState {}

final class GetUserDataLoading extends GetUserDataState {}

final class GetUserDataLoaded extends GetUserDataState {}

final class GettingGroupData extends GetUserDataState {}

final class GroupDataGetted extends GetUserDataState {}
