import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/common/constants/api_endpoints.dart';
import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/model/cart_model/cart_model.dart';
import 'package:ecommerce/utils/exceptions/dio_exceptions.dart';
import 'package:ecommerce/utils/interceptor/interceptor.dart';

class CartService {
  Future<CartModel?> getCartList(context) async {
    Dio dio = await IntercepterApi().getApiUser(context);
    try {
      final Response response =
          await dio.get(ApiUrl.apiUrl + ApiEndPoints.cart);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final CartModel cartList = CartModel.fromJson(response.data);
        return cartList;
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e, context);
    }
    return null;
  }

  Future<int?> addAndRemovecart(context, productId) async {
    Dio dio = await IntercepterApi().getApiUser(context);
    try {
      final Response response =
          await dio.post(ApiUrl.apiUrl + ApiEndPoints.wishlist, data: {
        'product': productId,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.statusCode;
      } else if (response.statusCode == 204) {
        return response.statusCode;
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e, context);
    }
    return null;
  }
}
