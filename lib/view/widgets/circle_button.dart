import 'package:ecommerce/common/style/colors.dart';
import 'package:flutter/material.dart';

class CircleButtonWidget extends StatelessWidget {
  const CircleButtonWidget({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  final void Function() onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      elevation: 0,
      child: CircleAvatar(
          backgroundColor: whiteColor,
          child:
              IconButton(splashRadius: 20, onPressed: onPressed, icon: icon)),
    );
  }
}
