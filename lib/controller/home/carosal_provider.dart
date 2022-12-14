import 'package:flutter/material.dart';

class CarosalProvider extends ChangeNotifier {
  int activeIndex = 0;
  void carosal(index) {
    activeIndex = index;
    notifyListeners();
  }
}
