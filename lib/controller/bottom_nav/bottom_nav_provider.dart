import 'package:ecommerce/view/cart/cart_screen.dart';

import 'package:ecommerce/view/home/home_screen.dart';

import 'package:ecommerce/view/profile/profile_screen.dart';


import 'package:flutter/material.dart';

class BottomNavProvider extends ChangeNotifier {
  int currentIndex = 0;
  List<Widget> pages = [
    const HomeScreen(),
    const CartScreen(),
    const ProfileScreen(),
    // const SettingsScreen(),
  ];
  void bottomNav(value) {
    currentIndex = value;
    notifyListeners();
  }
}
