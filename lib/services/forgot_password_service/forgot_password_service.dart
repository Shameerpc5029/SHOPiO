import 'package:dio/dio.dart';
import 'package:ecommerce/constants/api_endpoints.dart';
import 'package:ecommerce/constants/api_queryparameters.dart';
import 'package:ecommerce/constants/api_url.dart';
import 'package:ecommerce/model/sign_up_model/sign_up_model.dart';
import 'package:ecommerce/utils/exceptions/dio_exceptions.dart';

class ForgotPasswordService {
  final dio = Dio();
  Future<SignUpModel?> getUser(email, context) async {
    try {
      Response response = await dio.get(
        ApiUrl.apiUrl + ApiEndPoints.userCheck,
        queryParameters: {
          'email': email,
        },
      );
      if (response.statusCode == 200) {
        final SignUpModel model = SignUpModel.fromJson(response.data);
        return model;
      } else if (response.statusCode == 201) {
        return null;
      }
    } catch (e) {
      DioException().dioError(e, context);
    }
    return null;
  }

  Future<String?> changePassword(email, newPassword, context) async {
    try {
      Response response = await dio.post(
        ApiUrl.apiUrl + ApiEndPoints.forgotpassword,
        data: {
          'email': email,
          'password': newPassword,
        },
        queryParameters: ApiQueryParameter.queryParameter,
      );
      if (response.statusCode == 202) {
        return response.data['message'];
      }
    } catch (e) {
      DioException().dioError(e, context);
    }
  }
}
