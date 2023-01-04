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
      if (response.statusCode == 200 || response.data == 201) {
        final addressRes = response.data['message'];
        return addressRes;
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
        final List<GetAddressModel> model = (response.data as List)
            .map((e) => GetAddressModel.fromJson(e))
            .toList();
        return model;
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e, context);
    }
    return null;
  }
}
