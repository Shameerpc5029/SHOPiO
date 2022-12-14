import 'package:dio/dio.dart';
import 'package:ecommerce/view/core/style_const.dart';
import 'package:flutter/material.dart';

class DioException {
  void dioError(Object e, BuildContext context) {
    if (e is DioError) {
      if (e.response?.statusCode == 401) {
        PopUpSnackBar.popUp(
          context,
          'Unauthorized Error',
          Colors.red,
        );
      } else if (e.response?.statusCode == 400) {
        PopUpSnackBar.popUp(
          context,
          'Unknown field',
          Colors.red,
        );
      } else if (e.response?.statusCode == 403) {
        PopUpSnackBar.popUp(
          context,
          'User credential is not working',
          Colors.red,
        );
      } else if (e.toString() ==
          "[Error]: (006) Request Throttled. Over Rate limit: up to 2 per sec. See geocode.xyz/pricing") {
        PopUpSnackBar.popUp(
          context,
          'Failed, Please try again',
          Colors.red,
        );
      }
    }
  }
}

class PopUpSnackBar {
  static Future<void> popUp(
      BuildContext context, String text, Color color) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: const TextStyle(color: whiteColor),
        ),
        backgroundColor: color,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
