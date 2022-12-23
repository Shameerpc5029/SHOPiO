import 'package:ecommerce/controller/splash/splash_provider.dart';
import 'package:ecommerce/view/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
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
          children: const [
            Image(
              image: AssetImage(
                'assets/images/logo 3.png',
              ),
            ),
            SizedBox(
              height: 50,
            ),
            LoadingWidget()
          ],
        ),
      ),
    );
  }
}
