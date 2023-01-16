import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.buttonColor,
    required this.onPressed, required this.width,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final Color buttonColor;
  final void Function() onPressed;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:width,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          foregroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 20,
        ),
        label: Text(text),
      ),
    );
  }
}
