import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/constants/api_endpoints.dart';
import 'package:ecommerce/constants/api_url.dart';
import 'package:ecommerce/model/sign_up_model/sign_up_model.dart';
import 'package:ecommerce/model/sign_up_model/sign_up_token.dart';
import 'package:ecommerce/utils/exceptions/dio_exceptions.dart';
import 'package:flutter/material.dart';

class SignUpService {
  final dio = Dio();
  Future<SignUpTokenModel?> signUp(
      SignUpModel model, BuildContext context) async {
    try {
      Response response = await dio.post(
        ApiUrl.apiUrl + ApiEndPoints.signUp,
        data: jsonEncode(
          model.toJson(),
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        final model = SignUpTokenModel.fromJson(response.data);
        log(response.data.toString());
        return model;
      }
    } on DioError catch (e) {
      log(e.toString());
      DioException().dioError(e, context);
    }
    return null;
  }
}
