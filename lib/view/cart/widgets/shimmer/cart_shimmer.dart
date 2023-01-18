import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/view/widgets/shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class CartShimmer extends StatelessWidget {
  const CartShimmer({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Row(
              children: [
                CSizedBox().width10,
                ShimmerWidget.rectagle(
                  height: 100,
                  width: MediaQuery.of(context).size.width * 0.18,
                  radius: BorderRadius.circular(10),
                ),
                CSizedBox().width10,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CSizedBox().height10,
                    ShimmerWidget.rectagle(
                      height: 10,
                      width: MediaQuery.of(context).size.width * 0.3,
                    ),
                    CSizedBox().height10,
                    ShimmerWidget.rectagle(
                      height: 10,
                      width: MediaQuery.of(context).size.width * 0.7,
                    ),
                    CSizedBox().height5,
                    Row(
                      children: [
                        const ShimmerWidget.rectagle(
                          height: 10,
                          width: 60,
                        ),
                        CSizedBox().width10,
                        const ShimmerWidget.rectagle(
                          height: 10,
                          width: 60,
                        ),
                        CSizedBox().width10,
                        const ShimmerWidget.rectagle(
                          height: 10,
                          width: 60,
                        ),
                      ],
                    ),
                    CSizedBox().height10,
                    ShimmerWidget.rectagle(
                      height: 20,
                      width: 40,
                      radius: BorderRadius.circular(
                        6,
                      ),
                    )
                  ],
                ),
              ],
            ),
            CSizedBox().height5,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShimmerWidget.rectagle(
                  height: 40,
                  width: MediaQuery.of(context).size.width * .47,
                ),
                ShimmerWidget.rectagle(
                  height: 40,
                  width: MediaQuery.of(context).size.width * .47,
                ),
              ],
            )
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
