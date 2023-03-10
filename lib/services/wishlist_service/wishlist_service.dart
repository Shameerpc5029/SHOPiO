import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/common/constants/api_endpoints.dart';
import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/model/wishlist_model/wishlist_model.dart';

import 'package:ecommerce/utils/exceptions/dio_exceptions.dart';
import 'package:ecommerce/utils/interceptor/interceptor.dart';

class WishListService {
  Future<WishlistModel?> getWishList() async {
    Dio dio = await IntercepterApi().getApiUser();
    try {
      final Response response =
          await dio.get(ApiUrl.apiUrl + ApiEndPoints.wishlist);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final WishlistModel wishlists = WishlistModel.fromJson(response.data);
          return wishlists;
        }
      }
    } catch (e) {
      DioException().dioError(e);
    }
    return null;
  }

  Future<int?> addAndRemoveWishList(productId) async {
    Dio dio = await IntercepterApi().getApiUser();
    try {
      final Response response = await dio.post(
        ApiUrl.apiUrl + ApiEndPoints.wishlist,
        data: {'product': productId},
      );
      if (response.statusCode == 201) {
        return response.statusCode;
      } else if (response.statusCode == 204) {
        return response.statusCode;
      }
    } catch (e) {
      log(e.toString());
      DioException().dioError(e);
    }
    return null;
  }
}
