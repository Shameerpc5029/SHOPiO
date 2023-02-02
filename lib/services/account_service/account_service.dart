import 'package:dio/dio.dart';
import 'package:ecommerce/common/constants/api_endpoints.dart';
import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/utils/exceptions/dio_exceptions.dart';
import 'package:ecommerce/utils/interceptor/interceptor.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AccountService {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  Future<String?> logOutUser(context) async {
    final dios = await IntercepterApi().getApiUser();
    try {
      final token = storage.read(key: 'token');
      final refreshToken = storage.read(key: 'refreshToken');
      dios.options.headers["authorization"] = "Bearer $token";
      dios.options.headers["refresh"] = "$refreshToken";
      final Response response =
          await dios.get(ApiUrl.apiUrl + ApiEndPoints.logOut);

      if (response.statusCode == 200) {
        return response.data['message'];
      }
    } catch (e) {
      DioException().dioError(e);
    }
    return null;
  }
}
