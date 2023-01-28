import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentProvider extends ChangeNotifier {
  Razorpay razorpay = Razorpay();

  void openCheckout(price, context) async {
    var options = {
      'key': 'rzp_test_7Oy2L1XgmtnASJ',
      'amount': price * 100,
      'name': 'SHOPiO',
      'description': 'Mobile Phones',
      'prefill': {'contact': '9961735029', 'email': 'shopio@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      razorpay.open(options);

      razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
          (PaymentSuccessResponse response) {
        handlePaymentSuccess(response);
      });
      razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
          (PaymentFailureResponse response) {
        handlePaymentError(response);
      });
      razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
          (ExternalWalletResponse response) {
        handleExternalWallet(response);
      });
    } on PaymentFailureResponse catch (e) {
      log(e.error.toString());
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS:${response.paymentId}", timeInSecForIosWeb: 4);
    notifyListeners();
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR:${response.code} - ${response.message}",
        timeInSecForIosWeb: 4);
    notifyListeners();
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET:${response.walletName}", timeInSecForIosWeb: 4);
    notifyListeners();
  }
}
