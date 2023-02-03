import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/controller/bottom_nav/bottom_nav_provider.dart';
import 'package:ecommerce/controller/cart/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CartProvider>(context, listen: false).getCart();
    });
    return Consumer<BottomNavProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: provider.pages[provider.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: AppColor().themeColor,
            unselectedItemColor: Colors.grey,
            selectedIconTheme: const IconThemeData(
              size: 30,
            ),
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            elevation: 10,
            selectedFontSize: 14,
            unselectedFontSize: 10,
            showUnselectedLabels: true,
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
                    return Badge(
                      isLabelVisible:
                          value.totalProductCount > 0 ? true : false,
                      alignment: AlignmentDirectional.lerp(
                        AlignmentDirectional.topCenter,
                        AlignmentDirectional.topEnd,
                        15,
                      ),
                      textColor: AppColor().whiteColor,
                      label: Text(
                        value.totalProductCount.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      textStyle: TextStyle(
                        color: AppColor().whiteColor,
                        fontWeight: FontWeight.bold,
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
