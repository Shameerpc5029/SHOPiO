import 'package:ecommerce/model/sign_up_model/sign_up_model.dart';
import 'package:ecommerce/services/otp_service/otp_service.dart';
import 'package:ecommerce/services/sign_up_service/sign_up_service.dart';
import 'package:ecommerce/view/sign_up/otp_screen/otp_screen.dart';
import 'package:ecommerce/view/sign_in/sign_in.dart';

import 'package:flutter/cupertino.dart';

class SignUpProvider extends ChangeNotifier {
  final TextEditingController fullName = TextEditingController();
  final TextEditingController mobileNumber = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController conformPassword = TextEditingController();
  bool isLoading = false;

  void goToSignIn(context) {
    Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(
      builder: (context) {
        return const SignInScreen();
      },
    ), (route) => false);
  }

  bool obscureText = true;
  void passwordIsVisble() {
    obscureText = !obscureText;
    notifyListeners();
  }

  String? conformPasswordValidation(String? value) {
    if (value!.isEmpty) {
      return "Please enter your conform password";
    }
    if (value != password.text) {
      return "Please conform your password";
    }
    if (value.length < 8) {
      return "Password length must be atleast 8 characters";
    } else {
      return null;
    }
  }

  String? passwordValidation(String? value) {
    if (value!.isEmpty) {
      return "Please enter your password";
    }
    if (value.length < 8) {
      return "Password length must be atleast 8 characters";
    } else {
      return null;
    }
  }
  // RegExp regex = new RegExp(pattern);

  String? phoneNumberValidation(String? value) {
    if (value!.isEmpty) {
      return "Please enter your password";
    }

    if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value)) {
      return 'Enter Valid Phone Number';
    }

    if (value.length > 10 || value.length < 10) {
      return "Mobile length must be 10 characters";
    } else {
      return null;
    }
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

  String? nameValidation(String? value) {
    if (value!.isEmpty) {
      return "Please enter your full name";
    } else {
      return null;
    }
  }

  SignUpService signUpService = SignUpService();
  Future<void> signUpUser(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final model = SignUpModel(
      fullName: fullName.text,
      email: email.text,
      mobileNumber: mobileNumber.text,
      password: password.text,
    );
    OtpService().sendOtp(model.email, context).then((value) {
      if (value != null) {
        Navigator.of(context).push(CupertinoPageRoute(
          builder: (context) {
            return OtpScreen(
              model: model,
            );
          },
        ));
        clearTextfield();
      } else {
        return;
      }
    });
    isLoading = false;
    notifyListeners();
  }

  void clearTextfield() {
    fullName.clear();
    email.clear();
    mobileNumber.clear();
    password.clear();
    conformPassword.clear();
  }
}
