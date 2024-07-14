import 'package:bevy_messenger/data/datasources/payment_datasource.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part '../states/payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentDataSource _paymentDataSource;
  PaymentCubit(this._paymentDataSource) : super(PaymentStateInitial());

  bool isPaying = false;

  Future<String> pay(BuildContext context) async {
    emit(PaymentStateLoading());
    isPaying = true;
    String result = await _paymentDataSource.makePayment(
        amount: "10", currency: "USD", context: context);
    if (result.contains("success")) {
      isPaying = false;
      emit(PaymentStateSuccess("Payment Successful"));
      return "success";
    } else {
      isPaying = false;
      emit(PaymentStateFailure("Payment Failed"));
      return "failed";
    }
  }
}
