import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/bottom_nav.dart';
import 'package:ecommerce/model/otp_model/verify_otp_model.dart';
import 'package:ecommerce/services/otp_service/verify_otp_service.dart';
import 'package:flutter/material.dart';

class VerifyOtpProvider extends ChangeNotifier {
  VerifyOtpService verifyOtpService = VerifyOtpService();
  Dio dio = Dio();
  bool isLoading = false;
  String code = '';

  void onSubmitCode(String submitCode) {
    log(submitCode);
    code = submitCode;
    notifyListeners();
  }

  void sumbitOtp(String email, String code, BuildContext context) {
    isLoading = true;
    notifyListeners();

    VerifyOtpModel verifyOtpModel = VerifyOtpModel(email: email, code: code);

    verifyOtpService.verifyOtp(verifyOtpModel, code, context).then((value) {
      if (value != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return const BottomNav();
            },
          ),
        );
      }
    });

    isLoading = false;
    notifyListeners();
  }
}
