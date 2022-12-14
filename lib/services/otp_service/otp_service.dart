import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/constants/api_endpoints.dart';
import 'package:ecommerce/constants/api_url.dart';
import 'package:ecommerce/model/otp_model/otp_model.dart';
import 'package:ecommerce/utils/exceptions/dio_exceptions.dart';
import 'package:flutter/material.dart';

class OtpService {
  final dio = Dio();
  SendOtpModel? otpModel;

  Future<SendOtpModel?> sendOtp(
      SendOtpModel model, BuildContext context) async {
    log(model.toString());
    log("message");
    try {
      final Response response =
          await dio.get(ApiUrl.apiUrl + ApiEndPoints.sendOtp, queryParameters: {
        'email': model.email,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        final sendOtp = SendOtpModel.fromJson(response.data);
        log(sendOtp.toString());
        return sendOtp;
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e, context);
    }
    return null;
  }
}
