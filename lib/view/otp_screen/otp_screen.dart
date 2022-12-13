import 'package:ecommerce/view/core/style_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                height: 200,
                image: AssetImage('assets/images/otp.png'),
              ),
              height20,
              const Text(
                'Verification Code',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              height10,
              const Text(
                '''Please enter the verification code 
we sent to your Email''',
                textAlign: TextAlign.center,
              ),
              height10,
              OtpTextField(),
              height20,
              CircleAvatar(
                radius: 30,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    FontAwesomeIcons.arrowRight,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
