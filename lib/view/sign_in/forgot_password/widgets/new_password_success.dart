import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/view/sign_in/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewPassSuccessBottom extends StatelessWidget {
  const NewPassSuccessBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            FontAwesomeIcons.circleCheck,
            size: 100,
            color: Colors.green,
          ),
          CSizedBox().height20,
          const Text(
            "Password Changed!",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          CSizedBox().height10,
          const Text('Your password has been changed successfully.'),
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
                Navigator.of(context).pushAndRemoveUntil(
                  CupertinoPageRoute(
                    builder: (context) {
                      return const SignInScreen();
                    },
                  ),
                  (route) => false,
                );
              },
              child: const Text(
                'Go to login',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          CSizedBox().height20,
        ],
      ),
    );
  }
}
