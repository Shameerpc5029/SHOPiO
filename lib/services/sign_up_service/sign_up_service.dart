import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/common/constants/api_endpoints.dart';
import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/model/sign_up_model/sign_up_model.dart';
import 'package:ecommerce/model/sign_up_model/sign_up_token.dart';
import 'package:ecommerce/utils/exceptions/dio_exceptions.dart';
import 'package:flutter/material.dart';

class SignUpService {
  final dio = Dio();
  Future<SignUpTokenModel?> signUp(
      SignUpModel model, BuildContext context) async {
    log(model.toString());
    try {
      Response response = await dio.post(
        ApiUrl.apiUrl + ApiEndPoints.signUp,
        data: json.encode(
          model.toJson(),
        ),
        queryParameters: {
          'Content-type': 'application/json',
          'accept': 'application/json',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        final SignUpTokenModel model = SignUpTokenModel.fromJson(response.data);
        log(response.data.toString());
        return model;
      }
    } catch (e) {
      // log(e.toString());
      DioException().dioError(e, context);
    }
    return null;
  }
}
