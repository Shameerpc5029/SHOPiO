import 'dart:developer';

import 'package:ecommerce/bottom_nav.dart';
import 'package:ecommerce/view/sign_in/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashProvider extends ChangeNotifier {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  String? signInstate;
  String? onboardValue;

  void checkLogin(context) async {
    await Future.delayed(const Duration(seconds: 3));
    onboardValue = await storage.read(key: 'onboard');
    signInstate = await storage.read(key: 'token');
    log(signInstate.toString());
    if (signInstate != null) {
      Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(
            builder: (context) => const BottomNav(),
          ),
          (route) => false);
    } else {
      await Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(
            builder: (context) => const SignInScreen(),
          ),
          (route) => false);
    }
  }
}
