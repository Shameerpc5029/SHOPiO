import 'package:ecommerce/controller/otp/otp_provider.dart';
import 'package:ecommerce/model/sign_up_model/sign_up_model.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({
    super.key,
    required this.model,
  });
  final SignUpModel model;

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
                CSizedBox().    height20,
                const Text(
                  'Verification Code',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                 CSizedBox().   height10,
                const Text(
                  '''Please enter the verification code 
we sent to your Email''',
                  textAlign: TextAlign.center,
                ),
                  CSizedBox().  height10,
                Consumer<VerifyOtpProvider>(
                  builder: (context, provider, child) {
                    return OtpTextField(
                      numberOfFields: 4,
                      showFieldAsBox: true,
                      autoFocus: true,
                      onSubmit: (code) {
                        provider.onSubmitCode(code);
                      },
                    );
                  },
                ),
                CSizedBox().height20,
                CircleAvatar(
                  radius: 30,
                  child: Consumer<VerifyOtpProvider>(
                    builder: (context, value, child) {
                      return value.isLoading == true
                          ? const CircularProgressIndicator(
                              strokeWidth: 2,
                            )
                          : IconButton(
                              onPressed: () {
                                value.sumbitOtp(context, model);
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
      ),
    );
  }
}