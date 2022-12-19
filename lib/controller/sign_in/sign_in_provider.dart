import 'package:ecommerce/bottom_nav.dart';
import 'package:ecommerce/view/sign_up/sign_up.dart';
import 'package:ecommerce/view/sign_up/sign_up_screen.dart';
import 'package:flutter/cupertino.dart';

class SignInProvider extends ChangeNotifier {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  void goToHome(context) {
    Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(
        builder: (context) {
          return const BottomNav();
        },
      ),
      (route) => false,
    );
  }

  void goToSignUp(context) {
    Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(
        builder: (context) {
          return  SignUpScreen();
        },
      ),
      (route) => false,
    );
  }

  bool obscureText = true;
  void passwordIsVisble() {
    obscureText = !obscureText;
    notifyListeners();
  }

  String? passwordValidation(String? value) {
    if (value!.isEmpty) {
      return "Enter Your Password";
    }
    if (value.length < 8) {
      return "Password length must be atleast 8 characters";
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
}
