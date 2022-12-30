import 'package:flutter/material.dart';

class BottomNavButton extends StatelessWidget {
  const BottomNavButton({
    Key? key,
    required this.text,
    required this.backgroundColor,
    required this.foregroundColor,required this.onPressed,
  }) : super(key: key);
  final String text;
  final Color backgroundColor;
  final Color foregroundColor;
 final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 50,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
        ),
        onPressed:onPressed ,
        child: Text(
          text,
        ),
      ),
    );
  }
}
