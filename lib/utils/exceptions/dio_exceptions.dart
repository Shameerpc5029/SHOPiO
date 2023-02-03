import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DioException implements Exception {
  void dioError(Object e) {
    if (e is DioError) {
      if (e.response?.statusCode == 401) {
        AppToast.showToast('Invalid input', AppColor().redColor);

        // PopUpSnackBar.popUp(
        //   context,
        //   'Invalid input',
        //   alertColor,
        // );
      } else if (e.response?.statusCode == 400) {
        AppToast.showToast('Unknown fieldt', AppColor().redColor);

        // PopUpSnackBar.popUp(
        //   context,
        //   'Unknown field',
        //   alertColor,
        // );
      } else if (e.response?.statusCode == 403) {
        AppToast.showToast('User credential is not working', AppColor().redColor);

        // PopUpSnackBar.popUp(
        //   context,
        //   'User credential is not working',
        //   alertColor,
        // );
      } else if (e.toString() ==
          "[Error]: (006) Request Throttled. Over Rate limit: up to 2 per sec. See geocode.xyz/pricing") {
        // PopUpSnackBar.popUp(
        //   context,
        //   'Failed, Please try again',
        //   alertColor,

        // );
        AppToast.showToast('Failed, Please try again', AppColor().redColor);
      }
    }
    if (e is SocketException) {
      // PopUpSnackBar.popUp(
      //   context,
      //   'No Internet Connection',
      //   alertColor,
      // );
      log('No Internet');
      AppToast.showToast('No Internet Connection', AppColor().redColor);
    }
    if (e is TimeoutException) {
      // PopUpSnackBar.popUp(
      //   context,
      //   'Connection Timeout',
      //   alertColor,
      // );
      AppToast.showToast('Connection Timeout', AppColor().redColor);
    }
    if (e is MissingPluginException) {
      // PopUpSnackBar.popUp(
      //   context,
      //   'Plugin error occured',
      //   alertColor,
      // );
      AppToast.showToast('Plugin error occured', AppColor().redColor);
    }
    if (e is PlatformException) {
      // PopUpSnackBar.popUp(
      //   context,
      //   'Platform Error Occured',
      //   alertColor,
      // );
      AppToast.showToast('Platform Error Occured', AppColor().redColor);
    }
  }
}

class PopUpSnackBar {
  static Future<void> popUp(
      BuildContext context, String text, Color color) async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style:  TextStyle(
            fontWeight: FontWeight.w400,
            color:AppColor(). whiteColor,
          ),
        ),
        backgroundColor: color,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

class AppToast {
  static Future<void> showToast(
    String msg,
    Color color, [
    Toast toastLength = Toast.LENGTH_SHORT,
  ]) async {
    await Fluttertoast.cancel();
    await Fluttertoast.showToast(
      msg: msg,
      backgroundColor: color,
      toastLength: toastLength,
    );
  }
}
