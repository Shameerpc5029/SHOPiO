import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentProvider extends ChangeNotifier {
  Razorpay razorpay = Razorpay();

  void openCheckout(price) async {
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
    } on PaymentFailureResponse catch (e) {
      log(e.error.toString());
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response, context) {
    Fluttertoast.showToast(
        msg: "SUCCESS:${response.paymentId}", timeInSecForIosWeb: 4);
    notifyListeners();
    // PopUpSnackBar.popUp(context, "SUCCESS:${response.paymentId}", greyColor);
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR:${response.code} - ${response.message}",
        timeInSecForIosWeb: 4);
    notifyListeners();

    // PopUpSnackBar.popUp(
    //     context, "ERROR:${response.code} - ${response.message}", greyColor);
  }

  void handleExternalWallet(ExternalWalletResponse response, context) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET:${response.walletName}", timeInSecForIosWeb: 4);
    notifyListeners();

    // PopUpSnackBar.popUp(
    //     context, "EXTERNAL_WALLET:${response.walletName}", greyColor);
  }
}
