import 'dart:developer';

import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/model/address_model/address_model.dart';
import 'package:ecommerce/model/address_model/get_adress_model.dart';
import 'package:ecommerce/services/address_service/address_service.dart';
import 'package:ecommerce/utils/exceptions/dio_exceptions.dart';
import 'package:flutter/material.dart';

class AddressProvider extends ChangeNotifier {
  AddressProvider(context) {
    getAllAddress(context);
  }

  final TextEditingController fullName = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController pincode = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController place = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController landMark = TextEditingController();

  bool isLoding = false;
  bool isLoding2 = false;
  String addressType = 'HOME';
  bool isSelected = true;
  List<GetAddressModel> addressList = [];

  void addAddress(context) async {
    isLoding = true;
    notifyListeners();
    final AddressModel model = AddressModel(
      fullName: fullName.text,
      phone: phone.text,
      pin: pincode.text,
      state: state.text,
      place: place.text,
      address: address.text,
      landMark: landMark.text,
      title: addressType,
    );
    await AddressService().addAddress(model, context).then((value) {
      if (value != null) {
        log("helo");
        isLoding = true;
        notifyListeners();
        Navigator.of(context).pop();
        PopUpSnackBar.popUp(
            context, 'Address added successfully', Colors.green);
        isLoding = false;
        getAllAddress(context);
        clearController();
        notifyListeners();
      } else {
        isLoding = false;
        notifyListeners();
      }
    });
    return null;
  }

  Future<String?> getAllAddress(context) async {
    isLoding2 = true;
    notifyListeners();
    await AddressService().getAddress(context).then((value) {
      if (value != null) {
        log(value.toString());
        addressList = value;
        notifyListeners();
        isLoding2 = false;
        notifyListeners();
      } else {
        isLoding2 = false;
        notifyListeners();
        return null;
      }
    });
    return null;
  }

  Future<void> deleteAdderess(context, String addressId) async {
    isLoding = true;
    notifyListeners();
    await AddressService().delectAddress(context, addressId).then((value) {
      if (value != null) {
        PopUpSnackBar.popUp(
          context,
          'Address removed successfully',
          alertColor,
        );
        notifyListeners();
        getAllAddress(context);
        notifyListeners();
      } else {
        return null;
      }
    });
    isLoding = false;
    notifyListeners();
  }

  void clearController() {
    fullName.clear();
    phone.clear();
    pincode.clear();
    state.clear();
    place.clear();
    address.clear();
    landMark.clear();
    addressType = 'HOME';
  }

  void saveAddress(context) {
    addAddress(context);
    notifyListeners();
  }

  void typeButtonSelect() {
    isSelected = !isSelected;
    notifyListeners();
    isSelected == true ? addressType = 'HOME' : addressType = 'OFFICE';
    notifyListeners();
  }

  //...................validations

  String? nameValidation(String? value) {
    if (value!.isEmpty) {
      return "Please enter your full name";
    } else {
      return null;
    }
  }

  String? phoneNumberValidation(String? value) {
    if (value!.isEmpty) {
      return "Please enter your password";
    }

    if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value)) {
      return 'Enter Valid Phone Number';
    }

    if (value.length > 10 || value.length < 10) {
      return "Mobile length must be 10 characters";
    } else {
      return null;
    }
  }

  String? pincodeValidation(String? value) {
    if (value!.isEmpty) {
      return "Please enter your pincode";
    }
    if (value.length > 6 || value.length < 6) {
      return "Pincode length must be atleast 6 characters";
    } else {
      return null;
    }
  }

  String? stateValidation(String? value) {
    if (value!.isEmpty) {
      return "Please enter your state";
    } else {
      return null;
    }
  }

  String? placeValidation(String? value) {
    if (value!.isEmpty) {
      return "Please enter your place";
    } else {
      return null;
    }
  }

  String? addressValidation(String? value) {
    if (value!.isEmpty) {
      return "Please enter your Address";
    } else {
      return null;
    }
  }

  String? landMarkValidation(String? value) {
    if (value!.isEmpty) {
      return "Please enter your land mark";
    } else {
      return null;
    }
  }
}