import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/controller/forgot_password/forgot_password.dart';
import 'package:ecommerce/view/widgets/custom_textformfiled.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

Future<dynamic> forgotPassword(
      BuildContext context, GlobalKey<FormState> globalKey) {
    return showModalBottomSheet(
      useRootNavigator: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Forgot password',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CSizedBox().height20,
                const Text(
                  "Enter your email for the verification proccess we will sent 4 digts code to your email.",
                ),
                CSizedBox().height40,
                Form(
                  key: globalKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Consumer<ForgotPasswordProvider>(
                    builder: (context, value, child) {
                      return TextFormFieldCustom(
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: FontAwesomeIcons.at,
                        controller: value.forgotPasswordEmailcontroller,
                        validator: (p0) {
                          return value.emailValidation(p0);
                        },
                      );
                    },
                  ),
                ),
                CSizedBox().height20,
                Center(
                  child: SizedBox(
                    width: 350,
                    child: Consumer<ForgotPasswordProvider>(
                      builder: (context, value, child) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            if (globalKey.currentState!.validate()) {
                              globalKey.currentState!.save();
                              value.toOtpScreen(context);
                            }
                          },
                          child: const Text(
                            'Sent OTP',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                CSizedBox().height20,
              ],
            ),
          ),
        );
      },
    );
  }