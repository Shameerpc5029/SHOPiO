import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/constants/api_endpoints.dart';
import 'package:ecommerce/constants/api_url.dart';
import 'package:ecommerce/model/otp_model/verify_otp_model.dart';
import 'package:ecommerce/utils/exceptions/dio_exceptions.dart';
import 'package:flutter/material.dart';

class VerifyOtpService {
  VerifyOtpModel? verifyOtpModel;
  Dio dio = Dio();
  Future<VerifyOtpModel?> verifyOtp(
      VerifyOtpModel model, String otpCode, BuildContext context) async {
    try {
      final Response response =
          await dio.post(ApiUrl.apiUrl + ApiEndPoints.sendOtp, data: {
        model.toJson(),
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        final verifyUserOtp = VerifyOtpModel.fromJson(response.data);
        return verifyUserOtp;
      }
    } on DioError catch (e) {
      log('otp not veri');
      log(e.message);
      DioException().dioError(e, context);
    }
    return null;
  }
}
