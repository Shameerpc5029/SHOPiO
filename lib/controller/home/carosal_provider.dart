import 'package:ecommerce/services/home_service/carousal_service.dart';
import 'package:flutter/material.dart';

class CarosalProvider extends ChangeNotifier {
  CarosalProvider(context) {
    getCarousals(context);
  }

  int activeIndex = 0;
  bool isLoading = false;
  List carousalList = [];
  void carosal(index) {
    activeIndex = index;
    notifyListeners();
  }

  void getCarousals(context) async {
    isLoading = true;
    notifyListeners();
    await CarousalService().getCarousals(context).then((value) {
      if (value != null) {
        carousalList = value;
        notifyListeners();
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
        return null;
      }
    });
  }
}
