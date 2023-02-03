import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/common/constants/api_endpoints.dart';
import 'package:ecommerce/common/constants/api_url.dart';

import 'package:ecommerce/utils/exceptions/dio_exceptions.dart';
import 'package:ecommerce/utils/interceptor/interceptor.dart';

import '../../model/user_ model/user_mode.dart';

class UserProfileService {
  Future<UserModel?> getUserDetials(String email) async {
    Dio dio = await IntercepterApi().getApiUser();
    try {
      final Response response = await dio.get(
        ApiUrl.apiUrl + ApiEndPoints.user + email,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final UserModel userDetials = UserModel.fromJson(response.data);
        log(userDetials.fullname);
        return userDetials;
      }
    } catch (e) {
      log(e.toString());
      DioException().dioError(e);
    }
    return null;
  }
}
