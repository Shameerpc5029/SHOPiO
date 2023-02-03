import 'package:ecommerce/bottom_nav.dart';
import 'package:ecommerce/model/sign_in_model/sign_in_model.dart';
import 'package:ecommerce/services/sign_in_service/sign_in_service.dart';
import 'package:ecommerce/view/sign_up/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignInProvider extends ChangeNotifier {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isLoading = false;
  FlutterSecureStorage storage = const FlutterSecureStorage();
  SignInService signInService = SignInService();

  void singIn(context) async {
    isLoading = true;
    notifyListeners();
    final SignInModel signInModel = SignInModel(
      email: email.text,
      password: password.text,
    );
    await signInService.signUser(signInModel).then(
      (value) async {
        if (value != null) {
          await storage.write(key: 'token', value: value.accessToken);
          await storage.write(key: 'refreshToken', value: value.refreshToken);
          await storage.write(key: 'email', value: email.text.toString());

          Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(
            builder: (context) {
              return const BottomNav();
            },
          ), (route) => false);

          clearTextfild();
          isLoading = false;
          notifyListeners();
        } else {
          isLoading = false;
          notifyListeners();
        }
      },
    );
  }

  void clearTextfild() {
    email.clear();
    password.clear();
  }

  void goToSignUp(context) {
    Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(
        builder: (context) {
          return SignUpScreen();
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
