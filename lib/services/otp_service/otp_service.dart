import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/common/constants/api_endpoints.dart';
import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/utils/exceptions/dio_exceptions.dart';

class OtpService {
  Dio dio = Dio();
  Future<String?> sendOtp(email) async {
    try {
      final Response response = await dio.get(
          ApiUrl.apiUrl + ApiEndPoints.verifyOrSendOtp,
          queryParameters: {'email': email});
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('otp send');
        return response.data['message'];
      }
    } catch (e) {
      // log(e.message);
      DioException().dioError(
        e,
      );
    }
    return null;
  }

  Future<String?> verifyOtp(email, otpCode) async {
    try {
      final Response response = await dio.post(
        ApiUrl.apiUrl + ApiEndPoints.verifyOrSendOtp,
        data: {'email': email, 'otp': otpCode},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log("otp verifyed");
        return response.data['message'];
      }
    } catch (e) {
      // log(e.message);
      DioException().dioError(e);
    }
    return null;
  }
}
