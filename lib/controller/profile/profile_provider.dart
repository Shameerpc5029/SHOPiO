import 'dart:developer';

import 'package:ecommerce/controller/bottom_nav/bottom_nav_provider.dart';
import 'package:ecommerce/view/sign_in/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class ProfileProvider extends ChangeNotifier {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  void logOut(context) async {
    await storage.delete(key: 'token');
    await storage.delete(key: 'refreshToken');
    Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(
        builder: (context) => const SignInScreen(),
      ),
      (route) => false,
    );
    Provider.of<BottomNavProvider>(context, listen: false).currentIndex = 0;
    log(storage.toString());
  }
}
