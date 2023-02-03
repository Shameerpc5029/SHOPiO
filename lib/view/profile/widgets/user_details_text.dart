import 'package:ecommerce/common/style/colors.dart';
import 'package:flutter/material.dart';

class UserDetialsText extends StatelessWidget {
  const UserDetialsText({
    super.key,
    required this.title,
    required this.result,
  });
  final String title;
  final String result;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$title : $result',
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        color: themeColor,
        fontSize: 16,
      ),
    );
  }
}