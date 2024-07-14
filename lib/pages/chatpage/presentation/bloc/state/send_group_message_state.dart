part of '../cubit/send_group_message_cubit.dart';

class SendGroupMessageState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class SendGroupMessageInitial extends SendGroupMessageState {}

final class SendingGroupMessage extends SendGroupMessageState {}

final class GroupMessageSent extends SendGroupMessageState {}

final class GroupMessageNotSent extends SendGroupMessageState {}
