
import 'package:ecommerce/model/address_model/get_adress_model.dart';
import 'package:ecommerce/services/address_service/address_service.dart';
import 'package:flutter/material.dart';

class OrderSummaryProvider extends ChangeNotifier {
  GetAddressModel? address;
  bool isLoading = false;

  void getSingleAddress(String addressId, context) async {
    await AddressService().getSingleAddress(addressId, context).then((value) {
      if (value != null) {
        address = value;
        notifyListeners();
        isLoading = false;
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }
}
