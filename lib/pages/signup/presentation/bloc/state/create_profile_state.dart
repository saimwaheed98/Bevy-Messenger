part of '../cubit/create_profile_cubit.dart';

abstract class CreateProfileState extends Equatable {
  const CreateProfileState();

  @override
  List<Object> get props => [];
}

class CreateProfileInitial extends CreateProfileState {}

class CreateProfileLoading extends CreateProfileState {}

class CreateProfileSuccess extends CreateProfileState {}

class CreateProfileFailed extends CreateProfileState {
  final String message;
  const CreateProfileFailed({required this.message});
}