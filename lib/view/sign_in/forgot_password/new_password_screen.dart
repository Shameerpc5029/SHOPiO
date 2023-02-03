import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/controller/new_password/new_password_provider.dart';
import 'package:ecommerce/controller/sign_in/sign_in_provider.dart';
import 'package:ecommerce/model/sign_up_model/sign_up_model.dart';
import 'package:ecommerce/view/widgets/custom_textformfiled.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class NewPasswordScreen extends StatelessWidget {
  NewPasswordScreen({super.key, required this.model});

  final GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();

  final SignUpModel model;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignInProvider>(context);
    final newPasswordProvider = Provider.of<NewPasswordProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formGlobalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Reset your password',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                CSizedBox().height20,
                TextFormFieldCustom(
                  validator: ((value) {
                    return provider.passwordValidation(value);
                  }),
                  labelText: 'New password',
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon: FontAwesomeIcons.lock,
                  controller: newPasswordProvider.newPasswordController,
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
                TextFormFieldCustom(
                  validator: (value) {
                    return provider.passwordValidation(value);
                  },
                  labelText: 'Confirm password',
                  controller: newPasswordProvider.confirmPasswordController,
                  obscureText: provider.obscureText,
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
                      newPasswordProvider.success(context, model.email);
                    },
                    child: const Text(
                      'Confirm',
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
      ),
    );
  }
}
