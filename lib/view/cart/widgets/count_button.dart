
import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:flutter/material.dart';

class CountButton extends StatelessWidget {
  const CountButton({
    Key? key,
    required this.countNumber,
    required this.minusPressed,
    required this.plusPressed,
  }) : super(key: key);
  final String countNumber;
  final void Function() minusPressed;
  final void Function() plusPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: minusPressed,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: themeColor,
            ),
            child: const Icon(
              Icons.remove,
              size: 16,
              color: whiteColor,
            ),
          ),
        ),
        CSizedBox().width10,
        Text(
          countNumber,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        CSizedBox().width10,
        InkWell(
          onTap: plusPressed,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: themeColor,
            ),
            child: const Icon(
              Icons.add,
              size: 16,
              color: whiteColor,
            ),
          ),
        ),
      ],
    );
  }
}
