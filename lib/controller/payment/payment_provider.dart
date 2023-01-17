import 'dart:developer';

import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/utils/exceptions/dio_exceptions.dart';
import 'package:flutter/material.dart';
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
    PopUpSnackBar.popUp(context, "SUCCESS:${response.paymentId}", greyColor);
  }

  void handlePaymentError(PaymentFailureResponse response, context) {
    PopUpSnackBar.popUp(
        context, "ERROR:${response.code} - ${response.message}", greyColor);
  }

  void handleExternalWallet(ExternalWalletResponse response, context) {
    PopUpSnackBar.popUp(
        context, "EXTERNAL_WALLET:${response.walletName}", greyColor);
  }
}
