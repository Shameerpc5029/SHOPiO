import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetCheck extends ChangeNotifier {
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  getConnectivity(context) {
    return subscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlertSet == false) {
          showPopUp(context);
          notifyListeners();
          isAlertSet = true;
        }
      },
    );
  }

  // @override
  // void dispose() {
  //   subscription.cancel();
  //   super.dispose();
  // }

  Future<void> showPopUp(BuildContext context) async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          "No Internet Connection",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: whiteColor,
          ),
        ),
        action: SnackBarAction(
          label: 'Retry',
          onPressed: () {
            subscription.cancel();
            notifyListeners();
          },
          textColor: whiteColor,
        ),
        backgroundColor: alertColor,
      ),
    );
  }
}
