import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
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
          bottomNavigationBar: AnimatedBottomNavigationBar(
            gapLocation: GapLocation.none,
            elevation: 10,
            activeColor: themeColor,
            iconSize: 30,
            icons: const [
              Icons.home_outlined,
              Icons.category_outlined,
              Icons.shopping_bag_outlined,
              Icons.favorite_border_outlined,
              Icons.person_outline,
            ],
            activeIndex: provider.currentIndex,
            onTap: ((value) {
              provider.bottomNav(value);
            }),
          ),
          body: provider.pages[provider.currentIndex],
        );
      },
    );
  }
}
