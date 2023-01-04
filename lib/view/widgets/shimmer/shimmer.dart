import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget.rectagle({
    super.key,
    required this.height,
    required this.width,
    this.shape = BoxShape.rectangle,
    this.radius,
  });
  const ShimmerWidget.circle({
    super.key,
    required this.height,
    required this.width,
    this.shape = BoxShape.rectangle,
    this.radius,
  });

  final double height;
  final double width;
  final BoxShape shape;
  final BorderRadiusGeometry? radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.blueGrey.shade200,
      highlightColor: const Color.fromARGB(146, 144, 164, 174),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: radius,
          shape: shape,
          color: Colors.white,
        ),
        height: height,
        width: width,
      ),
    );
  }
}
