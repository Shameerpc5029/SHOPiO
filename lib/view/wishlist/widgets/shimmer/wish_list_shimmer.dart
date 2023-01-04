import 'package:ecommerce/view/widgets/shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class WishListShimmer extends StatelessWidget {
  const WishListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: ShimmerWidget.rectagle(
        height: 100,
        width: 70,
        radius: BorderRadius.circular(5),
      ),
      title: ShimmerWidget.rectagle(
        height: 10,
        radius: BorderRadius.circular(5),
        width: 20,
      ),
      subtitle: ShimmerWidget.rectagle(
        radius: BorderRadius.circular(5),
        height: 10,
        width: 20,
      ),
    );
  }
}
