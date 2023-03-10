import 'package:ecommerce/controller/sign_in/sign_in_provider.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/view/sign_in/widgets/forgot_password_bottom_sheet.dart';
import 'package:ecommerce/view/widgets/custom_textformfiled.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
    final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
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
                  const Hero(
                    transitionOnUserGestures: true,
                    tag: 'assets/images/logo 3.png',
                    child: Image(
                      image: AssetImage(
                        'assets/images/logo 3.png',
                      ),
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
                          AppColor().greyColor,
                        )),
                        onPressed: () {
                          forgotPassword(context, globalKey);
                        },
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
                  // const Text("Or"),
                  // CSizedBox().height10,
                  // InkWell(
                  //   borderRadius: BorderRadius.circular(20),
                  //   onTap: () {
                  //     provider.googleSignin();
                  //   },
                  //   child: Container(
                  //     width: MediaQuery.of(context).size.width * .6,
                  //     padding: const EdgeInsets.all(
                  //       5,
                  //     ),
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(20),
                  //       border: Border.all(color: AppColor().themeColor),
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         const Image(
                  //           height: 30,
                  //           image: AssetImage('assets/images/google logo.png'),
                  //         ),
                  //         CSizedBox().width10,
                  //         const Text(
                  //           'Continue with Google',
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 30,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Don???t have an account?',
                      style: TextStyle(
                        color: AppColor().blackColor,
                      ),
                      children: [
                        TextSpan(
                          text: ' Sign Up',
                          style: TextStyle(
                            color: AppColor().blueColor,
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
