import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/common/constants/api_endpoints.dart';
import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/model/home_model/carousal_model.dart';
import 'package:ecommerce/utils/exceptions/dio_exceptions.dart';
import 'package:ecommerce/utils/interceptor/interceptor.dart';

class CarousalService {
  Future<List<CarousalModel>?> getCarousals() async {
    Dio dio = await IntercepterApi().getApiUser();
    try {
      final Response response =
          await dio.get(ApiUrl.apiUrl + ApiEndPoints.carousal);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final List<CarousalModel> carousals = (response.data as List)
              .map((e) => CarousalModel.fromJson(e))
              .toList();
          return carousals;
        }
      } else {
        return null;
      }
    } catch (e) {
      log("catch working");
      // log(e.message);
      DioException().dioError(e);
    }
    return null;
  }
}
