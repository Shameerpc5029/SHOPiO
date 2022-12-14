import 'dart:developer';

import 'package:ecommerce/model/otp_model/otp_model.dart';
import 'package:ecommerce/services/otp_service/otp_service.dart';
import 'package:ecommerce/view/otp_screen/otp_screen.dart';
import 'package:flutter/cupertino.dart';

class OtpProvider extends ChangeNotifier {
  bool isLoading = false;
  OtpService otpService = OtpService();
  void sendOtp(String email, BuildContext context) {
    isLoading = true;
    notifyListeners();
    SendOtpModel sendOtpModel = SendOtpModel(email: email);
    log('otp send');
    otpService.sendOtp(sendOtpModel, context).then((value) {
      Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) {
          return const OtpScreen();
        },
      ));
    });
    log(sendOtpModel.toString());
    isLoading = false;
    notifyListeners();
  }
}
