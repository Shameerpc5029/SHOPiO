
import 'package:ecommerce/view/widgets/shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class CarouselShimmer extends StatelessWidget {
  const CarouselShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ShimmerWidget.rectagle(
      height: 250,
      width: double.infinity,
    );
  }
}
