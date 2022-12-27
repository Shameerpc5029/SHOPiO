import 'package:dio/dio.dart';
import 'package:ecommerce/bottom_nav.dart';
import 'package:ecommerce/model/sign_up_model/sign_up_model.dart';
import 'package:ecommerce/services/otp_service/otp_service.dart';
import 'package:ecommerce/services/sign_up_service/sign_up_service.dart';
import 'package:ecommerce/utils/exceptions/dio_exceptions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class VerifyOtpProvider extends ChangeNotifier {
  OtpService otpService = OtpService();
  FlutterSecureStorage storage = const FlutterSecureStorage();
  Dio dio = Dio();
  bool isLoading = false;
  String code = '';

  void onSubmitCode(String submitCode) {
    code = submitCode;
    notifyListeners();
  }

  void sumbitOtp(context, SignUpModel model) {
    if (code.length != 4) {
      PopUpSnackBar.popUp(
        context,
        'Please enter the OTP',
        Colors.red,
      );
    } else {
      isLoading = true;
      notifyListeners();
      otpService.verifyOtp(model.email, context, code).then((value) {
        if (value != null) {
          SignUpService().signUp(model, context).then((value) async {
            if (value != null) {
              await storage.write(key: 'token', value: value.accessToken);
              await storage.write(
                  key: 'refreshToken', value: value.refreshToken);
              Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(
                builder: (context) {
                  return const BottomNav();
                },
              ), (route) => false);
            }
            Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(
              builder: (context) {
                return const BottomNav();
              },
            ), (route) => false);
            isLoading = false;
            notifyListeners();
          });
        }
      });
    }
  }
}
