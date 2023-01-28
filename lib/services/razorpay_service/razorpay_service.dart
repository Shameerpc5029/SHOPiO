
import 'package:ecommerce/utils/exceptions/dio_exceptions.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayService {
  void openRazorPay(Razorpay razorPay, options,context) {
    try {
      razorPay.open(options);
    } catch (e) {
      DioException().dioError(e,context);
    }
  }
}
