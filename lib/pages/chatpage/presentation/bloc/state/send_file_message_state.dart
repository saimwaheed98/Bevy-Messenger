part of '../cubit/send_file_message_cubit.dart';

class SendFileMessageState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class SendFileMessageInitial extends SendFileMessageState {}

final class SendFileMessageLoading extends SendFileMessageState {}

final class SendFileMessageSuccess extends SendFileMessageState {}

final class SendFileMessageFailure extends SendFileMessageState {}
