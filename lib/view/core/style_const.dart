import 'package:flutter/material.dart';

LinearGradient screenGradiant = LinearGradient(
  colors: [
    Colors.blue.shade600,
    Colors.blue.shade900,
    Colors.white,
    Colors.white,
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
const Color whiteColor = Colors.white;
const Color greyColor = Colors.grey;
const Color blacColor = Colors.black;

TextStyle introductionHeadTextStyle = const TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 40,
);
TextStyle introductionContentTextStyle = const TextStyle(
  color: greyColor,
  fontWeight: FontWeight.w400,
  textBaseline: TextBaseline.alphabetic,
);

TextStyle headingTextStyle = const TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 40,
);

SizedBox height20 = const SizedBox(
  height: 20,
);

SizedBox height10 = const SizedBox(
  height: 10,
);
SizedBox height5 = const SizedBox(
  height: 5,
);

SizedBox width10 = const SizedBox(
  width: 10,
);
