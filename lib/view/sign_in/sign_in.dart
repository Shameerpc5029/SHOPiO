
import 'package:ecommerce/controller/sign_in/sign_in_provider.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/view/widgets/custum_textformfiled.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
    final provider = Provider.of<SignInProvider>(context);
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formGlobalKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  const Image(
                    image: AssetImage(
                      'assets/images/logo 3.png',
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  CSizedBox().height10,
                  TextFormFieldCustom(
                    validator: ((value) {
                      return provider.emailValidation(value);
                    }),
                    labelText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: FontAwesomeIcons.at,
                    controller: provider.email,
                  ),
                  CSizedBox().height10,
                  TextFormFieldCustom(
                    validator: ((value) {
                      return provider.passwordValidation(value);
                    }),
                    labelText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: FontAwesomeIcons.lock,
                    controller: provider.password,
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
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(
                          greyColor,
                        )),
                        onPressed: () {},
                        child: const Text(
                          'Forget Password?',
                        ),
                      ),
                    ],
                  ),
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
                          provider.singIn(context);
                        }
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  CSizedBox().height10,
                  const SizedBox(
                    height: 30,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Don’t have an account?',
                      style: const TextStyle(
                        color: blacColor,
                      ),
                      children: [
                        TextSpan(
                          text: ' Sign Up',
                          style: const TextStyle(
                            color: blueColor,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              provider.goToSignUp(context);
                            },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
