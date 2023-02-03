import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/model/otp_model/otp_enum.dart';
import 'package:ecommerce/services/forgot_password_service/forgot_password_service.dart';
import 'package:ecommerce/services/otp_service/otp_service.dart';
import 'package:ecommerce/utils/exceptions/dio_exceptions.dart';
import 'package:ecommerce/view/sign_up/otp_screen/otp_screen.dart';
import 'package:flutter/cupertino.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  bool isLoading = false;
  final TextEditingController forgotPasswordEmailcontroller =
      TextEditingController();

  void toOtpScreen(context) {
    isLoading = true;
    notifyListeners();
    ForgotPasswordService()
        .getUser(forgotPasswordEmailcontroller.text)
        .then((model) {
      if (model != null) {
        OtpService().sendOtp(model.email).then((value) {
          if (value != null) {
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) {
                  return OtpScreen(
                    signUpModel: model,
                    screenCheck: OtpEnum.forgotOtpScreen,
                  );
                },
              ),
            );
            forgotPasswordEmailcontroller.clear();
            isLoading = false;
            notifyListeners();
          } else {
            isLoading = false;
            notifyListeners();
          }
        });
      } else {
        isLoading = false;
        notifyListeners();
        AppToast.showToast('No user Found', AppColor().redColor);
      }
    });
  }

  String? emailValidation(String? value) {
    if (value!.isEmpty) {
      return "Please enter your email";
    } else if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value)) {
      return 'Invalid email , please enter correct email';
    } else {
      return null;
    }
  }
}
