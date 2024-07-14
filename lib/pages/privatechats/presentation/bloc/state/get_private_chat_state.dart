part of "../cubit/get_private_chat_cubit.dart";

class GetPrivateChatState extends Equatable {
  const GetPrivateChatState();

  @override
  List<Object> get props => [];
}

class GetPrivateChatInitial extends GetPrivateChatState {}

class GetPrivateChatLoading extends GetPrivateChatState {}

class GetPrivateChatLoaded extends GetPrivateChatState {}

class GetPrivateChatError extends GetPrivateChatState {
  final String message;

  const GetPrivateChatError(this.message);

  @override
  List<Object> get props => [message];
}
