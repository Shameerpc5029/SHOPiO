import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/common/constants/api_endpoints.dart';
import 'package:ecommerce/common/constants/api_queryparameters.dart';
import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/model/sign_in_model/sign_in_model.dart';
import 'package:ecommerce/model/sign_in_model/sign_in_token.dart';
import 'package:ecommerce/utils/exceptions/dio_exceptions.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInService {
  Dio dio = Dio();
  SignInModel? signInModel;
  Future<SignInTokenModel?> signUser(SignInModel model) async {
    try {
      Response response = await dio.post(
        ApiUrl.apiUrl + ApiEndPoints.signIn,
        data: jsonEncode(
          model.toJson(),
        ),
        queryParameters: ApiQueryParameter.queryParameter,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final SignInTokenModel signInModel =
            SignInTokenModel.fromJson(response.data);
        log(signInModel.toString());
        return signInModel;
      }
    } catch (e) {
      log("sign in  failed ");
      // log(e.message);
      DioException().dioError(e);
    }
    return null;
  }

  Future<String?> googleSignIn(GoogleSignIn googleSignIn) async {
    final result = await googleSignIn.signIn();

    try {
      Response response = await dio.post(
        ApiUrl.apiUrl + ApiEndPoints.google,
        data: {
          'email': result?.email,
          'name': result?.displayName,
        },
      );
      if (response.statusCode == 201) {
        return response.data['message'];
      }
    } catch (e) {
      DioException().dioError(e);
    }
    return null;
  }
}
