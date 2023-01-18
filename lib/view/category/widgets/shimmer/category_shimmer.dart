import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/view/widgets/shimmer/shimmer.dart';

import 'package:flutter/material.dart';

class CategoryListShimmer extends StatelessWidget {
  const CategoryListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CSizedBox().height10,
        GridView.builder(
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            childAspectRatio: 4 / 4,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ShimmerWidget.circle(
                  height: 60,
                  width: 60,
                  radius: BorderRadius.circular(30),
                ),
                CSizedBox().height10,
                ShimmerWidget.rectagle(
                  height: 10,
                  width: 50,
                  radius: BorderRadius.circular(3),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
