import 'dart:convert';
import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/helper/toast_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class PaymentDataSource {
  Map<String, dynamic>? paymentIntentData;
  Future<String> makePayment({
    required String amount,
    required String currency,
    required BuildContext context,
  }) async {
    try {
      String result = "";
      paymentIntentData = await createPaymentIntent(amount, currency, context);
      debugPrint("payment data $paymentIntentData");
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: 'Bevy Messenger',
          customerId: paymentIntentData!['customer'],
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
        ));
        result = await displayPaymentSheet(context, amount);
      }
      return result;
    } catch (e, s) {
      debugPrint('exception:$e$s');
      return "Error while making payment";
    }
  }

  Future<String> displayPaymentSheet(
      BuildContext context, String amount) async {
    try {
      final result =  await Stripe.instance.presentPaymentSheet();
      debugPrint("result data ${result.toString()}");
      return "success";
    } on Exception catch (e) {
      if (e is StripeException) {
        debugPrint("Error from Stripe: ${e.error.localizedMessage}");
        return "error";
      } else {
        debugPrint("Unforeseen error: ${e.toString()}");
        return "error";
      }
    } catch (e) {
      debugPrint("exception:$e");
      return "error";
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(
      String amount, String currency, BuildContext context) async {
    try {
      final AuthCubit authCubit = Di().sl<AuthCubit>();
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
        'receipt_email' : authCubit.userData.email
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51NbMtqElYGx6MFxDqxNIySZ4dbMddpZTt8TnSINUAz2Q6lFMcUvsS5YDlOz8TY96KArLFOnk5bTQ15ggoHZD4hw1005o8RkJLE',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      debugPrint("response ${jsonDecode(response.body)}");
      return jsonDecode(response.body);
    } catch (err) {
      WarningHelper.showWarningToast(
          "Error while creating payment please try again later", context);
      debugPrint('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount) * 100);
    return a.toString();
  }
}
