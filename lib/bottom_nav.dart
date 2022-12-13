import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:ecommerce/controller/providers/bottom_nav_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
            leftCornerRadius: 30,
            rightCornerRadius: 30,
            elevation: 10,
            activeColor: Colors.blue[800],
            iconSize: 25,
            icons: const [
              FontAwesomeIcons.houseChimney,
              FontAwesomeIcons.magnifyingGlass,
              FontAwesomeIcons.user,
              FontAwesomeIcons.gears,
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
