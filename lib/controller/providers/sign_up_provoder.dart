import 'package:ecommerce/bottom_nav.dart';
import 'package:ecommerce/view/sign_in/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';

class SignUpProvider extends ChangeNotifier {
  final fullName = TextEditingController();
  final mobileNumber = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final conformPassword = TextEditingController();

  void goToHome(context) {
    Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(
      builder: (context) {
        return const BottomNav();
      },
    ), (route) => false);
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
}
