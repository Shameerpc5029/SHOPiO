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
  Future<String?> addAddress(AddressModel model) async {
    Dio dio = await IntercepterApi().getApiUser();
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
    } catch (e) {
      // log(e.message);
      DioException().dioError(e);
    }
    return null;
  }

  Future<List<GetAddressModel>?> getAddress() async {
    Dio dio = await IntercepterApi().getApiUser();
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
    } catch (e) {
      // log(e.message);
      DioException().dioError(e);
    }
    return null;
  }

  Future<GetAddressModel?> getSingleAddress(context, String addressId) async {
    Dio dio = await IntercepterApi().getApiUser();
    try {
      final Response response =
          await dio.get("${ApiUrl.apiUrl + ApiEndPoints.address}/$addressId");

      if (response.statusCode == 200) {
        final GetAddressModel model = GetAddressModel.fromJson(response.data);
        return model;
      }
    } catch (e) {
      // log(e.message);
      DioException().dioError(e);
    }
    return null;
  }

  Future<String?> delectAddress(context, String addressId) async {
    Dio dio = await IntercepterApi().getApiUser();
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
    } catch (e) {
      // log(e.message);
      DioException().dioError(e);
    }
    return null;
  }

  Future<String?> updateAddress(
      context, AddressModel model, String addressId) async {
    Dio dios = await IntercepterApi().getApiUser();
    try {
      final Response response = await dios.patch(
        "${ApiUrl.apiUrl + ApiEndPoints.address}/$addressId",
        data: model.toJson(),
      );

      if (response.statusCode == 202) {
        final String result = response.data['message'];
        return result;
      }
    } catch (e) {
      // log(e.message);
      DioException().dioError(e);
    }
    return null;
  }
}
