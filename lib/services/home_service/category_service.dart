import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/common/constants/api_endpoints.dart';
import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/model/home_model/category_model.dart';
import 'package:ecommerce/utils/exceptions/dio_exceptions.dart';
import 'package:ecommerce/utils/interceptor/interceptor.dart';

class CategoryService {
  Future<List<CategoryModel>?> getCategories() async {
    Dio dio = await IntercepterApi().getApiUser();
    try {
      final Response response =
          await dio.get(ApiUrl.apiUrl + ApiEndPoints.category);
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        final List<CategoryModel> listCategory = (response.data as List)
            .map((e) => CategoryModel.fromJson(e))
            .toList();
        return listCategory;
      }
    } catch (e) {
      // log(e.message);
      DioException().dioError(e);
    }
    return null;
  }
}
