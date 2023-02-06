import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(
                20,
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       const Image(
                        image: AssetImage(
                          'assets/images/logo 3.png',
                        ),
                      ),
                      CSizedBox().height40,
                      const Text(
                        'Welcome to SHOPiO,',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CSizedBox().height10,
                      const Text(
                        "SHOPiO is a Professional eCommerce Platform. Here we will provide you only interesting content, which you will like very much. We're dedicated to providing you the best of eCommerce, with a focus on dependability and Online Mobile shopping .We hope you enjoy our eCommerce as much as we enjoy offering them to you.",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          letterSpacing: .6,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "Varsion 1.0.0",
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "Developed By Shameer PC",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColor().greyColor,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
