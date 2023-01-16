import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/common/constants/api_endpoints.dart';
import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/model/wishlist_model/wishlist_model.dart';
import 'package:ecommerce/utils/exceptions/dio_exceptions.dart';
import 'package:ecommerce/utils/interceptor/interceptor.dart';

class WishListService {
  Future<WishListModel?> getWishList(context) async {
    Dio dio = await IntercepterApi().getApiUser(context);
    try {
      final Response response =
          await dio.get(ApiUrl.apiUrl + ApiEndPoints.wishlist);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final WishListModel wishlists = WishListModel.fromJson(response.data);
          return wishlists;
        }
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e, context);
    }
    return null;
  }

  Future<int?> addAndRemoveWishList(context, productId) async {
    Dio dio = await IntercepterApi().getApiUser(context);
    try {
      final Response response = await dio.post(
        ApiUrl.apiUrl + ApiEndPoints.wishlist,
        data: {
          'product': productId,
        },
      );
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
