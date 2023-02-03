import 'package:flutter/material.dart';

class ProfileTextWidget extends StatelessWidget {
  const ProfileTextWidget({
    Key? key,
    required this.title,
    required this.iconData,
    required this.onTap,
    this.color = const Color.fromARGB(255, 10, 59, 132),
    this.trailing = const Icon(
      Icons.arrow_forward_ios_rounded,
    ),
  }) : super(key: key);
  final Widget trailing;
  final String title;
  final IconData iconData;
  final Color color;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        iconData,
        color: color,
        size: 20,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: trailing,
    );
  }
}
