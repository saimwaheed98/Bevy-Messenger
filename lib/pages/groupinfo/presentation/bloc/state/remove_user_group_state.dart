part of '../cubit/remove_user_group_cubit.dart';

sealed class RemoveUserGroupState extends Equatable {
  @override
  List<Object> get props => [];
}

final class RemoveUserGroupInitial extends RemoveUserGroupState {
}

final class RemovingUserLoading extends  RemoveUserGroupState{}

final class RemovedUserLoaded extends RemoveUserGroupState{}



