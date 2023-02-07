import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DioException implements Exception {
  void dioError(Object e) {
    if (e is DioError) {
      if (e.response?.statusCode == 401) {
        AppToast.showToast('Invalid input', AppColor().redColor);
      } else if (e.response?.statusCode == 400) {
        AppToast.showToast('Unknown fieldt', AppColor().redColor);
      } else if (e.response?.statusCode == 403) {
        AppToast.showToast(
            'User credential is not working', AppColor().redColor);
      } else if (e.toString() ==
          "[Error]: (006) Request Throttled. Over Rate limit: up to 2 per sec. See geocode.xyz/pricing") {
        AppToast.showToast('Failed, Please try again', AppColor().redColor);
      }
    }
    if (e is SocketException) {
      log('No Internet');
      AppToast.showToast('No Internet Connection', AppColor().redColor);
    }
    if (e is TimeoutException) {
      AppToast.showToast('Connection Timeout', AppColor().redColor);
    }
    if (e is MissingPluginException) {
      AppToast.showToast('Plugin error occured', AppColor().redColor);
    }
    if (e is PlatformException) {
      AppToast.showToast('Platform Error Occured', AppColor().redColor);
    }
  }
}

class AppToast {
  static Future<void> showToast(
    String msg,
    Color color, [
    ToastGravity gravity = ToastGravity.SNACKBAR,
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
