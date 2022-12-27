import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/controller/sign_in/sign_in_provider.dart';
import 'package:ecommerce/view/sign_in/forgot_password/forgot_otp_screem.dart';
import 'package:ecommerce/view/widgets/custum_textformfiled.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ForgotEmailScreen extends StatelessWidget {
  ForgotEmailScreen({super.key});
  final GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();

  final TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignInProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Center(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formGlobalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormFieldCustom(
                validator: (value) {
                  return provider.emailValidation(value);
                },
                labelText: 'Email',
                controller: email,
                keyboardType: TextInputType.text,
                prefixIcon: FontAwesomeIcons.at,
              ),
              CSizedBox().height20,
              SizedBox(
                width: 350,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    if (formGlobalKey.currentState!.validate()) {
                      formGlobalKey.currentState!.save();
                      Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) {
                          return const ForgotOtpScreen();
                        },
                      ));
                    }
                  },
                  child: const Text(
                    'Send',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
