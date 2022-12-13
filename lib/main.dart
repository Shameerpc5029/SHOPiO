import 'package:ecommerce/controller/providers/bottom_nav_provider.dart';
import 'package:ecommerce/controller/providers/sign_in_provider.dart';
import 'package:ecommerce/controller/providers/sign_up_provoder.dart';
import 'package:ecommerce/view/otp_screen/otp_screen.dart';
import 'package:ecommerce/view/sign_in/sign_in_screen.dart';
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
        ChangeNotifierProvider(create: (context) => SignUpProvider()),
        ChangeNotifierProvider(create: (context) => SignInProvider()),
        ChangeNotifierProvider(create: (context) => BottomNavProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            elevation: 0,
            color: Colors.blue.shade600,
          ),
        ),
        home: const SignInScreen(),
        // home: OtpScreen(),
      ),
    );
  }
}
