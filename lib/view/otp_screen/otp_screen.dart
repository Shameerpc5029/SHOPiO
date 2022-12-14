import 'package:ecommerce/bottom_nav.dart';
import 'package:ecommerce/controller/otp/otp_provider.dart';
import 'package:ecommerce/controller/otp/verify_otp_provider.dart';
import 'package:ecommerce/controller/sign_up/sign_up_provoder.dart';
import 'package:ecommerce/view/core/style_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: blacColor,
      ),
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
              Consumer<VerifyOtpProvider>(
                builder: (context, provider, child) {
                  return OtpTextField(
                    onSubmit: (value) {
                      provider.onSubmitCode(value);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) {
                            return const BottomNav();
                          },
                        ),
                      );
                    },
                  );
                },
              ),
              height20,
              CircleAvatar(
                radius: 30,
                child: Consumer2<VerifyOtpProvider, SignUpProvider>(
                  builder: (context, value, value2, child) {
                    return IconButton(
                      onPressed: () {
                        value.sumbitOtp(value2.email.text, value.code, context);
                      },
                      icon: const Icon(
                        FontAwesomeIcons.arrowRight,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
