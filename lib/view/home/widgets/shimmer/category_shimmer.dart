import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/view/widgets/shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return SizedBox(
            width: 100,
            child: Column(
              children: [
                const ShimmerWidget.circle(
                  shape: BoxShape.circle,
                  height: 60,
                  width: 80,
                ),
                CSizedBox().height10,
                ShimmerWidget.rectagle(
                  radius: BorderRadius.circular(5),
                  height: 20,
                  width: 70,
                )
              ],
            ),
          );
        },
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 10,
      ),
    );
  }
}
