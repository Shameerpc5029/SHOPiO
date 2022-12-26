import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/controller/splash/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashProvider>(context, listen: false);
    splashProvider.checkLogin(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage(
                'assets/images/logo 3.png',
              ),
            ),
            CSizedBox().height20,
            LoadingAnimationWidget.prograssiveDots(
              color: const Color.fromARGB(255, 10, 59, 132),
              size: 50,
            ),
          ],
        ),
      ),
    );
  }
}
