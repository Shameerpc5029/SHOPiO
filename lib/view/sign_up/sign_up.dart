import 'package:ecommerce/controller/sign_up/sign_up_provoder.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/view/widgets/custom_textformfiled.dart';
import 'package:ecommerce/view/widgets/loading_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignUpProvider>(context);
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: formGlobalKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  const Image(
                    image: AssetImage('assets/images/logo 3.png'),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  const Text(
                    "Register",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  CSizedBox().height20,
                  TextFormFieldCustom(
                    validator: ((value) {
                      return provider.nameValidation(value);
                    }),
                    labelText: 'Full Name',
                    keyboardType: TextInputType.name,
                    prefixIcon: FontAwesomeIcons.user,
                    controller: provider.fullName,
                  ),
                  TextFormFieldCustom(
                    validator: ((value) {
                      return provider.emailValidation(value);
                    }),
                    labelText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: FontAwesomeIcons.at,
                    controller: provider.email,
                  ),
                  TextFormFieldCustom(
                    validator: ((value) {
                      return provider.phoneNumberValidation(value);
                    }),
                    labelText: 'Phone Number',
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: FontAwesomeIcons.mobile,
                    controller: provider.mobileNumber,
                  ),
                  TextFormFieldCustom(
                    validator: ((value) {
                      return provider.passwordValidation(value);
                    }),
                    labelText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: FontAwesomeIcons.lock,
                    obscureText: provider.obscureText,
                    suffix: IconButton(
                      onPressed: () {
                        provider.passwordIsVisble();
                      },
                      icon: Icon(
                        !provider.obscureText
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        size: 20,
                      ),
                    ),
                    controller: provider.password,
                  ),
                  TextFormFieldCustom(
                    validator: ((value) {
                      return provider.conformPasswordValidation(value);
                    }),
                    labelText: 'Conform Password',
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: FontAwesomeIcons.lock,
                    obscureText: provider.obscureText,
                    controller: provider.conformPassword,
                  ),
                  CSizedBox().height20,
                  Consumer<SignUpProvider>(
                    builder: (context, provideSignup, child) {
                      return SizedBox(
                        width: 350,
                        child: provideSignup.isLoading == true
                            ? const LoadingWidget()
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onPressed: () {
                                  if (formGlobalKey.currentState!.validate()) {
                                    formGlobalKey.currentState!.save();
                                    provider.signUpUser(context);
                                  }
                                },
                                child: const Text(
                                  'Sign Up',
                                ),
                              ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Don’t have an account?',
                      style: const TextStyle(
                        color: blacColor,
                      ),
                      children: [
                        TextSpan(
                          text: ' Sign In',
                          style: const TextStyle(
                            color: blueColor,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              provider.goToSignIn(context);
                            },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
