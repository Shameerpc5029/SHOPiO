import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/common/constants/api_endpoints.dart';
import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/model/address_model/address_model.dart';
import 'package:ecommerce/model/address_model/get_adress_model.dart';
import 'package:ecommerce/utils/exceptions/dio_exceptions.dart';
import 'package:ecommerce/utils/interceptor/interceptor.dart';

class AddressService {
  Future<String?> addAddress(AddressModel model, context) async {
    Dio dio = await IntercepterApi().getApiUser(context);
    try {
      final Response response = await dio.post(
        ApiUrl.apiUrl + ApiEndPoints.address,
        data: jsonEncode(
          model.toJson(),
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final addressRes = response.data['message'];
          log(response.toString());
          return addressRes;
        }
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e, context);
    }
    return null;
  }

  Future<List<GetAddressModel>?> getAddress(context) async {
    Dio dio = await IntercepterApi().getApiUser(context);
    try {
      final Response response =
          await dio.get(ApiUrl.apiUrl + ApiEndPoints.address);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final List<GetAddressModel> model = (response.data as List)
              .map((e) => GetAddressModel.fromJson(e))
              .toList();
          log(response.toString());
          return model;
        }
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e, context);
    }
    return null;
  }

  Future<String?> delectAddress(context, String addressId) async {
    Dio dio = await IntercepterApi().getApiUser(context);
    try {
      final Response response = await dio
          .delete("${ApiUrl.apiUrl + ApiEndPoints.address}/$addressId");
      if (response.statusCode == 201 || response.statusCode == 200) {
        if (response.data == null) {
          return null;
        } else {
          final String model = response.data['message'];
          return model;
        }
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e, context);
    }
    return null;
  }
}
