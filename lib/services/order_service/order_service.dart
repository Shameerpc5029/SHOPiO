import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/common/constants/api_endpoints.dart';
import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/model/order_model/get_order_model.dart';
import 'package:ecommerce/model/order_model/order_model.dart';
import 'package:ecommerce/utils/exceptions/dio_exceptions.dart';
import 'package:ecommerce/utils/interceptor/interceptor.dart';

class OrderService {
  Future<String?> placeOrder(OrdersModel model) async {
    final Dio dios = await IntercepterApi().getApiUser();

    try {
      final Response response = await dios.post(
        ApiUrl.apiUrl + ApiEndPoints.orders,
        data: model.toJson(),
      );
      if (response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final GetOrderModel model =
              GetOrderModel.fromJson(response.data['order']);
          log(model.toString());
          return model.id;
        }
      }
    } catch (e) {
      log(e.toString());
      DioException().dioError(e);
    }
    return null;
  }

  Future<List<GetOrderModel>?> getAllOrders() async {
    Dio dios = await IntercepterApi().getApiUser();
    try {
      final Response response = await dios.get(
        ApiUrl.apiUrl + ApiEndPoints.orders,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final List<GetOrderModel> model = (response.data as List)
              .map((e) => GetOrderModel.fromJson(e))
              .toList();

          log(response.data.toString());
          return model;
        }
      }
    } catch (e) {
      log(e.toString());
      DioException().dioError(e);
    }
    return null;
  }

  Future<GetOrderModel?> getSingleOrders(String orderId) async {
    Dio dios = await IntercepterApi().getApiUser();
    try {
      final Response response = await dios.get(
        "${ApiUrl.apiUrl + ApiEndPoints.orders}/$orderId",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final GetOrderModel model = GetOrderModel.fromJson(response.data);

          log(response.data.toString());
          return model;
        }
      }
    } catch (e) {
      log(e.toString());
      DioException().dioError(e);
    }
    return null;
  }

  Future<String?> cancelOrder(orderId) async {
    try {
      final Dio dios = await IntercepterApi().getApiUser();
      final Response response = await dios.patch(
        "${ApiUrl.apiUrl + ApiEndPoints.orders}/$orderId",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final order = response.data['message'];
          log(order.toString());
          return order;
        }
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      DioException().dioError(e);
    }
    return null;
  }
}
