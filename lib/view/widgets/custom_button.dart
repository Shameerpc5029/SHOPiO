import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.buttonColor,
    required this.onPressed,
    required this.backgroundColor,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final Color buttonColor;
  final Color backgroundColor;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * .26,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: buttonColor,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(0),
            // ),
          ),
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 15,
          ),
          label: Text(
            text,
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * .025),
          ),
        )

        // OutlinedButton.icon(
        //   style: OutlinedButton.styleFrom(
        // foregroundColor: buttonColor,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(0),
        // ),
        // ),
        //   onPressed: onPressed,
        //   icon: Icon(
        //     icon,
        //     size: 20,
        //   ),
        //   label: Text(text),
        // ),
        );
  }
}
