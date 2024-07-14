part of '../cubits/payment_cubit.dart';

class PaymentState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class PaymentStateInitial extends PaymentState {}

final class PaymentStateLoading extends PaymentState {}

final class PaymentStateSuccess extends PaymentState {
  final String message;
  PaymentStateSuccess(this.message);
}

final class PaymentStateFailure extends PaymentState {
  final String message;
  PaymentStateFailure(this.message);
}
