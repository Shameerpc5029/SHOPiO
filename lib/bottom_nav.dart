import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/controller/bottom_nav/bottom_nav_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
      builder: (context, provider, child) {
        return Scaffold(
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
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.category_outlined,
                ),
                label: 'Category',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_bag_outlined,
                ),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite_border_outlined,
                ),
                label: 'Wish List',
              ),
              BottomNavigationBarItem(
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
          // bottomNavigationBar: AnimatedBottomNavigationBar(
          //   gapLocation: GapLocation.none,
          //   elevation: 10,
          //   activeColor: themeColor,
          //   iconSize: 30,

          //   icons: const [
          //     Icons.home_outlined,
          //     Icons.category_outlined,
          //     Icons.shopping_bag_outlined,
          //     Icons.favorite_border_outlined,
          //     Icons.person_outline,
          //   ],
          //   activeIndex: provider.currentIndex,
          // onTap: ((value) {
          //   provider.bottomNav(value);
          // }),
          // ),
          body: provider.pages[provider.currentIndex],
        );
      },
    );
  }
}
