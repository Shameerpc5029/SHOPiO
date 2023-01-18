import 'package:ecommerce/view/cart/cart_screen.dart';
import 'package:ecommerce/view/category/category_screen.dart';

import 'package:ecommerce/view/home/home_screen.dart';

import 'package:ecommerce/view/profile/profile_screen.dart';
import 'package:ecommerce/view/wishlist/wish_list_screen.dart';

import 'package:flutter/material.dart';

class BottomNavProvider extends ChangeNotifier {
  int currentIndex = 0;
  List<Widget> pages = [
    const HomeScreen(),
    const CategoryScreen(),
    const CartScreen(),
    const WishListScreen(),
    const ProfileScreen(),
    // const SettingsScreen(),
  ];
  void bottomNav(value) {
    currentIndex = value;
    notifyListeners();
  }

  void gotoHomescreen() {
    currentIndex = 0;
    notifyListeners();
  }
}
