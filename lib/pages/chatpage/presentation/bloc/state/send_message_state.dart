part of '../cubit/send_message_cubit.dart';

class SendMessageState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class SendMessageInitial extends SendMessageState {}

final class SendMessageLoading extends SendMessageState {}

final class SendMessageSuccess extends SendMessageState {}
