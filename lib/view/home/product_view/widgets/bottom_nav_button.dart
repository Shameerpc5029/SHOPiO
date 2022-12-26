import 'package:flutter/material.dart';

class BottomNavButton extends StatelessWidget {
  const BottomNavButton({
    Key? key,
    required this.text,
    required this.backgroundColor,
    required this.foregroundColor,
  }) : super(key: key);
  final String text;
  final Color backgroundColor;
  final Color foregroundColor;
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
        onPressed: () {},
        child: Text(
          text,
        ),
      ),
    );
  }
}
