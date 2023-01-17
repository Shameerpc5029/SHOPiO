import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/utils/exceptions/dio_exceptions.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentService {
  void razorpayPayment(Razorpay razorpay, options, context) {
    try {
      razorpay.open(options);
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e, context);
    }
  }
}
