import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ForgotOtpScreen extends StatelessWidget {
  const ForgotOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: blacColor,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  height: 200,
                  image: AssetImage('assets/images/otp.png'),
                ),
                CSizedBox().height20,
                const Text(
                  'Verification Code',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                CSizedBox().height10,
                const Text(
                  '''Please enter the verification code 
we sent to your Email''',
                  textAlign: TextAlign.center,
                ),
                CSizedBox().height10,
                OtpTextField(
                  numberOfFields: 4,
                  showFieldAsBox: true,
                  autoFocus: true,
                  onSubmit: (code) {},
                ),
                CSizedBox().height20,
                CircleAvatar(
                  radius: 30,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      FontAwesomeIcons.arrowRight,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
