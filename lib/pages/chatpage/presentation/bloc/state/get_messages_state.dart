part of '../cubit/get_messages_cubit.dart';

class GetMessagesState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class GetMessagesInitial extends GetMessagesState {}

final class GettingMessages extends GetMessagesState {}

final class MessagesGetted extends GetMessagesState {
  final List<MessageModel> messages;

  MessagesGetted(this.messages);

  @override
  List<Object?> get props => [messages];
}
