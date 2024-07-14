part of '../cubit/get_user_cubit.dart';

class GetUserState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class GetUserInitial extends GetUserState {}

final class GetUserLoading extends GetUserState {}

final class GetUserLoaded extends GetUserState {}

final class GettingContactsUsers extends GetUserState {}

final class ContactUserGetted extends GetUserState {}

final class EmptyContactsUsers extends GetUserState {}

