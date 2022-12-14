import 'package:ecommerce/bottom_nav.dart';
import 'package:ecommerce/model/sign_up_model/sign_up_model.dart';
import 'package:ecommerce/services/sign_up_service/sign_up_service.dart';
import 'package:ecommerce/view/otp_screen/otp_screen.dart';
import 'package:ecommerce/view/sign_in/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';

class SignUpProvider extends ChangeNotifier {
  final fullName = TextEditingController();
  final mobileNumber = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final conformPassword = TextEditingController();
  bool isLoading = false;

  void goToHome(context) {
    Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(
      builder: (context) {
        return const BottomNav();
      },
    ), (route) => false);
  }

  void goToOtp(context) {
    Navigator.of(context).push(CupertinoPageRoute(
      builder: (context) {
        return const OtpScreen();
      },
    ));
  }

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
      return "Please Enter Your Conform Password";
    }
    if (value != password.text) {
      return "Please Conform Your Password";
    }
    if (value.length < 8) {
      return "Password length must be atleast 8 characters";
    } else {
      return null;
    }
  }

  String? passwordValidation(String? value) {
    if (value!.isEmpty) {
      return "Please Enter Your Password";
    }
    if (value.length < 8) {
      return "Password length must be atleast 8 characters";
    } else {
      return null;
    }
  }

  String? phoneNumberValidation(String? value) {
    if (value!.isEmpty) {
      return "Please Enter Your Password";
    }
    if (value.length > 10 || value.length < 10) {
      return "Mobile length must be 10 characters";
    } else {
      return null;
    }
  }

  String? emailValidation(String? value) {
    if (value!.isEmpty) {
      return "Please Enter Your E-mail";
    } else {
      return null;
    }
  }

  String? nameValidation(String? value) {
    if (value!.isEmpty) {
      return "Please Enter Your Full Name";
    } else {
      return null;
    }
  }

  SignUpService signUpService = SignUpService();
  Future<void> signUpUser(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final signUpUser = SignUpModel(
      fullName: fullName.text,
      email: email.text,
      mobileNumber: mobileNumber.text,
      password: password.text,
    );
    signUpService.signUp(signUpUser, context);
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
