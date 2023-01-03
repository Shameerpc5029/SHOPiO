import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/common/constants/api_endpoints.dart';
import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/model/cart_model/add_to_cart.dart';
import 'package:ecommerce/model/cart_model/get_form_cart_model.dart';
import 'package:ecommerce/utils/exceptions/dio_exceptions.dart';
import 'package:ecommerce/utils/interceptor/interceptor.dart';

class CartService {
  Future<String?> addToCart(AddToCartModel model, context) async {
    Dio dios = await IntercepterApi().getApiUser(context);
    try {
      final Response response = await dios.post(
        ApiUrl.apiUrl + ApiEndPoints.cart,
        data: jsonEncode(model.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final cartResponse = response.data['message'];
        return cartResponse;
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e, context);
    }
    return null;
  }

  Future<CartModel?> getCartItems(context) async {
    Dio dios = await IntercepterApi().getApiUser(context);
    try {
      final Response response =
          await dios.get(ApiUrl.apiUrl + ApiEndPoints.cart);

      if (response.statusCode == 200) {
        final CartModel model = CartModel.fromJson(response.data);
        return model;
      }
    } catch (e) {
      DioException().dioError(e, context);
    }
    return null;
  }

  Future<CartModel?> getCart(context) async {
    Dio dio = await IntercepterApi().getApiUser(context);
    try {
      final Response response =
          await dio.get(ApiUrl.apiUrl + ApiEndPoints.cart);
      if (response.data == null) {
        return null;
      } else if (response.statusCode == 200 || response.statusCode == 201) {
        final CartModel model = CartModel.fromJson(response.data);
        log(response.data.toString());
        return model;
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e, context);
    }
    return null;
  }

  Future<String?> removeFromCart(context, id) async {
    Dio dio = await IntercepterApi().getApiUser(context);
    try {
      final Response response = await dio.patch(
        ApiUrl.apiUrl + ApiEndPoints.cart,
        data: {
          "product": id,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final remove = response.data['message'];
        return remove;
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e, context);
    }
    return null;
  }
}
