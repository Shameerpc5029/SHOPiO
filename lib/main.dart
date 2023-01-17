import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/controller/address/address_provider.dart';
import 'package:ecommerce/controller/bottom_nav/bottom_nav_provider.dart';
import 'package:ecommerce/controller/cart/cart_provider.dart';
import 'package:ecommerce/controller/home/home_provider.dart';
import 'package:ecommerce/controller/order_summary/order_summary_provider.dart';
import 'package:ecommerce/controller/otp/otp_provider.dart';
import 'package:ecommerce/controller/payment/payment_provider.dart';
import 'package:ecommerce/controller/profile/profile_provider.dart';
import 'package:ecommerce/controller/sign_in/sign_in_provider.dart';
import 'package:ecommerce/controller/sign_up/sign_up_provoder.dart';
import 'package:ecommerce/controller/splash/splash_provider.dart';
import 'package:ecommerce/controller/wish_list/wishlist_provider.dart';
import 'package:ecommerce/view/category/category_view/category_view.dart';
import 'package:ecommerce/view/order/order_summary_screen.dart';
import 'package:ecommerce/view/product_view/product_view.dart';
import 'package:ecommerce/view/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashProvider()),
        ChangeNotifierProvider(create: (context) => SignUpProvider()),
        ChangeNotifierProvider(create: (context) => SignInProvider()),
        ChangeNotifierProvider(create: (context) => BottomNavProvider()),
        ChangeNotifierProvider(create: (context) => VerifyOtpProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider(context)),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => WishListProvider(context)),
        ChangeNotifierProvider(create: (context) => CartProvider(context)),
        ChangeNotifierProvider(create: (context) => AddressProvider(context)),
        ChangeNotifierProvider(create: (context) => OrderSummaryProvider(),),
        ChangeNotifierProvider(create: (context) => PaymentProvider(),),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // fontFamily: 'Manrope',
          // primarySwatch: Colors.blueGrey,
          primaryColor: themeColor,
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 0,
            foregroundColor: Colors.black,
            color: whiteColor,
          ),
        ),
        routes: {
          ProductView.routeName: (context) => const ProductView(),
          CategoryView.routeName: (context) => const CategoryView(),
          OrderSummaryScreen.routeName:(context) => const OrderSummaryScreen(),
        },
        home: const SplashScreen(),
      ),
    );
  }
}
