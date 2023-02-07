import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/common/constants/api_endpoints.dart';
import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/model/cart_model/add_to_cart.dart';
import 'package:ecommerce/model/cart_model/get_form_cart_model.dart';
import 'package:ecommerce/model/cart_model/get_single_cart_model.dart';
import 'package:ecommerce/utils/exceptions/dio_exceptions.dart';
import 'package:ecommerce/utils/interceptor/interceptor.dart';

class CartService {
  Future<String?> addToCart(
    AddToCartModel model,
  ) async {
    Dio dios = await IntercepterApi().getApiUser();
    try {
      final Response response = await dios.post(
        ApiUrl.apiUrl + ApiEndPoints.cart,
        data: jsonEncode(model.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final cartResponse = response.data['message'];
        return cartResponse;
      }
    } catch (e) {
      // log(e.message);
      DioException().dioError(
        e,
      );
    }
    return null;
  }

  Future<CartModel?> getCartItems() async {
    Dio dios = await IntercepterApi().getApiUser();
    try {
      final Response response =
          await dios.get(ApiUrl.apiUrl + ApiEndPoints.cart);

      if (response.statusCode == 200) {
        final CartModel model = CartModel.fromJson(response.data);
        return model;
      }
    } catch (e) {
      DioException().dioError(
        e,
      );
    }
    return null;
  }

  Future<CartModel?> getCart() async {
    Dio dio = await IntercepterApi().getApiUser();
    try {
      final Response response =
          await dio.get(ApiUrl.apiUrl + ApiEndPoints.cart);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final CartModel model = CartModel.fromJson(response.data);
          log(response.data.toString());
          return model;
        }
      }
    } catch (e) {
      // log(e.message);
      DioException().dioError(
        e,
      );
    }
    return null;
  }

  Future<String?> removeFromCart(id) async {
    Dio dio = await IntercepterApi().getApiUser();
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
    } catch (e) {
      // log(e.message);
      DioException().dioError(
        e,
      );
    }
    return null;
  }

  Future<List<GetSingelCartProduct>?> getSingleCart(
      String productId, String cartId) async {
    Dio dios = await IntercepterApi().getApiUser();
    try {
      final Response response = await dios.get(
        "${ApiUrl.apiUrl + ApiEndPoints.cart}/$cartId/product/$productId",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final List<GetSingelCartProduct> model = (response.data as List)
              .map((e) => GetSingelCartProduct.fromJson(e))
              .toList();

          log(response.data.toString());
          return model;
        }
      }
    } catch (e) {
      // log(e.message);
      DioException().dioError(
        e,
      );
    }
    return null;
  }
}
