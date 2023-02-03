import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/controller/address/address_provider.dart';
import 'package:ecommerce/controller/bottom_nav/bottom_nav_provider.dart';
import 'package:ecommerce/controller/cart/cart_provider.dart';
import 'package:ecommerce/controller/connection/connecton_provider.dart';
import 'package:ecommerce/controller/forgot_password/forgot_password.dart';
import 'package:ecommerce/controller/home/home_provider.dart';
import 'package:ecommerce/controller/new_password/new_password_provider.dart';
import 'package:ecommerce/controller/order/order_provider.dart';
import 'package:ecommerce/controller/order_summary/order_summary_provider.dart';
import 'package:ecommerce/controller/otp/otp_provider.dart';
import 'package:ecommerce/controller/payment/payment_provider.dart';
import 'package:ecommerce/controller/profile/profile_provider.dart';
import 'package:ecommerce/controller/sign_in/sign_in_provider.dart';
import 'package:ecommerce/controller/sign_up/sign_up_provoder.dart';
import 'package:ecommerce/controller/splash/splash_provider.dart';
import 'package:ecommerce/controller/wish_list/wishlist_provider.dart';
import 'package:ecommerce/view/category/category_view/category_view.dart';
import 'package:ecommerce/view/product_view/product_view.dart';
import 'package:ecommerce/view/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
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
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => WishListProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => AddressProvider()),
        ChangeNotifierProvider(create: (context) => OrderSummaryProvider()),
        ChangeNotifierProvider(create: (context) => PaymentProvider()),
        ChangeNotifierProvider(create: (context) => InternetCheck()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
        ChangeNotifierProvider(create: (context) => ForgotPasswordProvider()),
        ChangeNotifierProvider(create: (context) => NewPasswordProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // fontFamily: 'Manrope',
          useMaterial3: true,
          // primarySwatch: Colors.blueGrey,
          // primaryColor: themeColor,
          colorSchemeSeed: AppColor().themeColor,
          appBarTheme: AppBarTheme(
            centerTitle: true,
            elevation: 0,
            foregroundColor: Colors.black,
            color: AppColor().whiteColor,
          ),
        ),
        routes: {
          ProductView.routeName: (context) => const ProductView(),
          CategoryView.routeName: (context) => const CategoryView(),
        },
        home: const SplashScreen(),
      ),
    );
  }
}
