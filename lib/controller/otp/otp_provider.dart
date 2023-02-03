import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ecommerce/bottom_nav.dart';
import 'package:ecommerce/model/otp_model/otp_enum.dart';
import 'package:ecommerce/model/sign_up_model/sign_up_model.dart';
import 'package:ecommerce/services/otp_service/otp_service.dart';
import 'package:ecommerce/services/sign_up_service/sign_up_service.dart';
import 'package:ecommerce/utils/exceptions/dio_exceptions.dart';
import 'package:ecommerce/view/sign_in/forgot_password/new_password_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class VerifyOtpProvider extends ChangeNotifier {
  OtpService otpService = OtpService();
  FlutterSecureStorage storage = const FlutterSecureStorage();
  Dio dio = Dio();
  bool isLoading = false;
  String code = '';
  bool clear = false;
  int timeRemaining = 30;
  Timer? timer;
  bool enableResend = false;

  void setResendVisibility(bool newValue, context, String email) {
    clear = true;
    notifyListeners();
    OtpService().sendOtp(email).then((value) {
      if (value != null) {
        clear = false;
        notifyListeners();
        enableResend = newValue;
        timeRemaining = 30;
      } else {
        return null;
      }
    });
  }

  void changeTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (timeRemaining != 0) {
        timeRemaining--;
        notifyListeners();
      } else {
        enableResend = true;
        notifyListeners();
      }
    });
  }

  void onSubmitCode(String submitCode) {
    code = submitCode;
    notifyListeners();
  }

  void sumbitOtp(context, SignUpModel model, OtpEnum screenCheck) async {
    if (code.length != 4) {
      PopUpSnackBar.popUp(
        context,
        'Please enter the OTP',
        Colors.red,
      );
    } else {
      isLoading = true;
      notifyListeners();
      if (screenCheck == OtpEnum.signOtpScreen) {
        await otpService.verifyOtp(model.email, code).then((value) {
          if (value != null) {
            SignUpService().signUp(model).then((value) async {
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
          } else {
            isLoading = false;
            notifyListeners();
          }
        });
      } else if (screenCheck == OtpEnum.forgotOtpScreen) {
        await OtpService().verifyOtp(model.email, code).then((value) {
          if (value != null) {
            Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(
              builder: (context) {
                return NewPasswordScreen(
                  model: model,
                );
              },
            ), (route) => false).then((value) {
              isLoading = false;
              notifyListeners();
            });
          } else {
            null;
            isLoading = false;
            notifyListeners();
          }
        });
      }
    }
  }
}
