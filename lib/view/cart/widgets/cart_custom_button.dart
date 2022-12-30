import 'package:flutter/material.dart';

class CartCustomButton extends StatelessWidget {
  const CartCustomButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.buttonColor,
    required this.onPressed,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final Color buttonColor;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .48,
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
