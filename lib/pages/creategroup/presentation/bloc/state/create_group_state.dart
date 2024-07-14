part of '../cubit/create_group_cubit.dart';

class CreateGroupState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class CreateGroupInitial extends CreateGroupState {}

final class CreatingGroup extends CreateGroupState {}

final class GroupCreated extends CreateGroupState {
  final String message;

  GroupCreated(this.message);

  @override
  List<Object?> get props => [message];
}

final class GroupCreationFailed extends CreateGroupState {
  final String message;

  GroupCreationFailed(this.message);

  @override
  List<Object?> get props => [message];
}

// get the participiants state
final class AddingParticipiants extends CreateGroupState {}

final class ParticipiantsAdded extends CreateGroupState {}

// set the group is premium

final class SettingGroupPremium extends CreateGroupState {}

final class GroupPremiumSet extends CreateGroupState {}
