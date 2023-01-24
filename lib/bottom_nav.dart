import 'package:badges/badges.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/controller/bottom_nav/bottom_nav_provider.dart';
import 'package:ecommerce/controller/cart/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: provider.pages[provider.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: themeColor,
            unselectedItemColor: Colors.grey,
            iconSize: 30,
            selectedIconTheme: const IconThemeData(
              size: 35,
            ),
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            currentIndex: provider.currentIndex,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                ),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.category_outlined,
                ),
                label: 'Category',
              ),
              BottomNavigationBarItem(
                icon: Consumer<CartProvider>(
                  builder: (context, value, child) {
                    return value.totalProductCount == 0
                        ? const Icon(
                            Icons.shopping_bag_outlined,
                          )
                        : Badge(
                            padding: const EdgeInsets.all(6),
                            badgeColor: themeColor,
                            badgeContent: Text(
                              value.totalProductCount.toString(),
                              style: const TextStyle(
                                color: whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            child: const Icon(
                              Icons.shopping_bag_outlined,
                            ),
                          );
                  },
                ),
                label: 'Cart',
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite_border_outlined,
                ),
                label: 'Wish List',
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_outline,
                ),
                label: 'Profile',
              ),
            ],
            onTap: ((value) {
              provider.bottomNav(value);
            }),
          ),
        );
      },
    );
  }
}
