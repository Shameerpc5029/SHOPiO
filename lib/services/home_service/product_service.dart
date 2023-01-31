import 'package:dio/dio.dart';
import 'package:ecommerce/common/constants/api_endpoints.dart';
import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/model/home_model/product_model.dart';
import 'package:ecommerce/utils/exceptions/dio_exceptions.dart';
import 'package:ecommerce/utils/interceptor/interceptor.dart';

class ProductService {
  Future<List<ProductModel>?> getAllProduct(context) async {
    Dio dio = await IntercepterApi().getApiUser(context);
    try {
      final Response response =
          await dio.get(ApiUrl.apiUrl + ApiEndPoints.product);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final List<ProductModel> product = (response.data as List)
              .map((e) => ProductModel.fromJson(e))
              .toList();
          return product;
        }
      }
    } catch (e) {
      // log(e.message);
      DioException().dioError(e, context);
    }
    return null;
  }

  Future<List<ProductModel>?> searchProducts(
      String searchValue, context) async {
    Dio dios = await IntercepterApi().getApiUser(context);
    try {
      final Response response = await dios.get(
          ApiUrl.apiUrl + ApiEndPoints.product,
          queryParameters: {"search": searchValue});
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        final List<ProductModel> products = (response.data as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();

        return products;
      }
    } catch (e) {
      DioException().dioError(e, context);
    }
    return null;
  }
}
