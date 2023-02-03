import 'package:ecommerce/common/style/colors.dart';
import 'package:flutter/material.dart';

class HighlightsWidget extends StatelessWidget {
  const HighlightsWidget({
    Key? key,
    required this.icon,
    required this.titleText,
    required this.subText,
  }) : super(key: key);

  final IconData icon;
  final String titleText;
  final String subText;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0,
      contentPadding: EdgeInsets.zero,
      dense: true,
      leading: Container(
        margin: const EdgeInsets.fromLTRB(0, 5, 0, 0.0),
        child: Icon(
          icon,
          size: 30,
          color: Colors.grey.shade500,
        ),
      ),
      title: Text(
        titleText,
        style:  TextStyle(
          color:AppColor(). greyColor,
        ),
      ),
      subtitle: Text(
        subText,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
