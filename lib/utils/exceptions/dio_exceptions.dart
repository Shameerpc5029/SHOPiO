import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DioException implements Exception {
  void dioError(Object e, context) {
    if (e is DioError) {
      if (e.response?.statusCode == 401) {
        PopUpSnackBar.popUp(
          context,
          'Invalid input',
          alertColor,
        );
      } else if (e.response?.statusCode == 400) {
        PopUpSnackBar.popUp(
          context,
          'Unknown field',
          alertColor,
        );
      } else if (e.response?.statusCode == 403) {
        PopUpSnackBar.popUp(
          context,
          'User credential is not working',
          alertColor,
        );
      } else if (e.toString() ==
          "[Error]: (006) Request Throttled. Over Rate limit: up to 2 per sec. See geocode.xyz/pricing") {
        PopUpSnackBar.popUp(
          context,
          'Failed, Please try again',
          alertColor,
        );
      }
    }
    if (e is SocketException) {
      PopUpSnackBar.popUp(
        context,
        'No Internet Connection',
        alertColor,
      );
      log('No Internet');
    }
    if (e is TimeoutException) {
      PopUpSnackBar.popUp(
        context,
        'Connection Timeout',
        alertColor,
      );
    }
    if (e is MissingPluginException) {
      PopUpSnackBar.popUp(
        context,
        'Plugin error occured',
        alertColor,
      );
    }
    if (e is PlatformException) {
      PopUpSnackBar.popUp(
        context,
        'Platform Error Occured',
        alertColor,
      );
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
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            color: whiteColor,
          ),
        ),
        backgroundColor: color,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
