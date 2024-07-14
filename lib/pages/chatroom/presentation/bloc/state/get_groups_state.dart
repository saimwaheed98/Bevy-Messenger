part of '../cubit/get_groups_cubit.dart';

class GetGroupsState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class GetGroupsInitial extends GetGroupsState {}

final class GettingGroups extends GetGroupsState {}

final class GroupsGetted extends GetGroupsState {}

final class EmptyGroups extends GetGroupsState {}
