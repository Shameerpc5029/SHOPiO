import 'dart:developer';

import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/model/address_model/address_model.dart';
import 'package:ecommerce/model/address_model/address_screen_enum.dart';
import 'package:ecommerce/model/address_model/get_adress_model.dart';
import 'package:ecommerce/services/address_service/address_service.dart';
import 'package:ecommerce/utils/exceptions/dio_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AddressProvider extends ChangeNotifier {
  AddressProvider() {
    getAllAddress();
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
  bool isButtonVisbile = true;

  int selectIndex = 0;

  void addressSelect(int index) {
    selectIndex = index;
    notifyListeners();
  }

  void isVisible(notification) {
    if (notification.direction == ScrollDirection.reverse) {
      if (isButtonVisbile) {
        isButtonVisbile = false;
        notifyListeners();
      }
    } else if (notification.direction == ScrollDirection.forward) {
      if (!isButtonVisbile) {
        isButtonVisbile = true;
        notifyListeners();
      }
    }
  }

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
    await AddressService().addAddress(model).then((value) {
      if (value != null) {
        isLoding = true;
        notifyListeners();
        Navigator.of(context).pop();
        PopUpSnackBar.popUp(
            context, 'Address added successfully', Colors.green);
        isLoding = false;
        getAllAddress();
        clearController();
        notifyListeners();
      } else {
        isLoding = false;
        notifyListeners();
      }
    });
    return null;
  }

  void updateAddress(BuildContext context, String addressId) async {
    isLoding = true;
    notifyListeners();
    final AddressModel model = AddressModel(
      title: addressType,
      fullName: fullName.text,
      phone: phone.text,
      pin: pincode.text,
      state: state.text,
      place: place.text,
      address: address.text,
      landMark: landMark.text,
    );
    await AddressService()
        .updateAddress(context, model, addressId)
        .then((value) {
      if (value != null) {
        clearController();
        Navigator.pop(context);
        getAllAddress();
        isLoding = false;
        notifyListeners();
      } else {
        isLoding = false;
        notifyListeners();
      }
    });
  }

  getAllAddress() async {
    isLoding2 = true;
    notifyListeners();
    await AddressService().getAddress().then((value) {
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

  void deleteAdderess(context, String addressId) async {
    isLoding2 = true;
    notifyListeners();
    await AddressService().delectAddress(context, addressId).then((value) {
      isLoding2 = false;
      Navigator.of(context).pop();
      PopUpSnackBar.popUp(
        context,
        'Address removed successfully',
        AppColor().alertColor,
      );
      getAllAddress();
      notifyListeners();
    });
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

  void saveAddress(
      context, AddressScreenEnum addressScreenCheck, String addressId) {
    if (addressScreenCheck == AddressScreenEnum.addAddressScreen) {
      addAddress(context);
    } else {
      updateAddress(context, addressId);
    }
    notifyListeners();
  }

  void typeButtonSelect() {
    isSelected = !isSelected;
    notifyListeners();
    isSelected == true ? addressType = 'HOME' : addressType = 'OFFICE';
    notifyListeners();
  }

  void setAddressScreen(
      AddressScreenEnum addressScreenCheck, String? addressId, context) async {
    if (addressScreenCheck == AddressScreenEnum.addAddressScreen) {
      clearController();
    } else {
      await AddressService().getSingleAddress(context, addressId!).then(
        (value) {
          if (value != null) {
            fullName.text = value.fullName;
            phone.text = value.phone;
            pincode.text = value.pin;
            state.text = value.state;
            place.text = value.place;
            address.text = value.address;
            landMark.text = value.landMark;
            value.title == 'Home' ? isSelected = true : isSelected = false;
            notifyListeners();
          }
        },
      );
    }
  }

  //...................validations

  String? nameValidation(String? value) {
    if (value!.isEmpty) {
      return "Please enter your full name";
    }
    if (RegExp(r"^[\p{L} ,.'-]*$").hasMatch(value)) {
      return 'Enter Valid name';
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
    if (!RegExp(r'(^(?:[+0]9)?[0-9]{6}$)').hasMatch(value)) {
      return 'Enter Valid pincode';
    }
    if (value.length > 6 || value.length < 6) {
      return "Pincode length must be 6 characters";
    } else {
      return null;
    }
  }

  String? stateValidation(String? value) {
    if (value!.isEmpty) {
      return "Please enter your state";
    }
    if (RegExp(r"^[\p{L} ,.'-]*$").hasMatch(value)) {
      return 'Enter Valid state name';
    } else {
      return null;
    }
  }

  String? placeValidation(String? value) {
    if (value!.isEmpty) {
      return "Please enter your place";
    }
    if (RegExp(r"^[\p{L} ,.'-]*$").hasMatch(value)) {
      return 'Enter Valid place name';
    } else {
      return null;
    }
  }

  String? addressValidation(String? value) {
    if (value!.isEmpty) {
      return "Please enter your Address";
    }
    if (RegExp(r"^[\p{L} ,.'-]*$").hasMatch(value)) {
      return 'Enter Valid Address';
    } else {
      return null;
    }
  }

  String? landMarkValidation(String? value) {
    if (value!.isEmpty) {
      return "Please enter your land mark";
    }
    if (RegExp(r"^[\p{L} ,.'-]*$").hasMatch(value)) {
      return 'Enter Valid Landmark';
    } else {
      return null;
    }
  }
}
