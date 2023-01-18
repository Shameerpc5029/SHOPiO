import 'package:ecommerce/view/widgets/shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class WishListShimmer extends StatelessWidget {
  const WishListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {},
          leading: ShimmerWidget.rectagle(
            height: 60,
            width: 60,
            radius: BorderRadius.circular(5),
          ),
          title: ShimmerWidget.rectagle(
            height: 10,
            radius: BorderRadius.circular(3),
            width: 10,
          ),
          subtitle: ShimmerWidget.rectagle(
            radius: BorderRadius.circular(3),
            height: 10,
            width: 20,
          ),
          trailing: const ShimmerWidget.circle(
            height: 40,
            width: 40,
            shape: BoxShape.circle,
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }
}
