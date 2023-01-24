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
                  radius: BorderRadius.circular(5),
                ),
                CSizedBox().width10,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CSizedBox().height10,
                    ShimmerWidget.rectagle(
                      height: 10,
                      width: MediaQuery.of(context).size.width * 0.3,
                      radius: BorderRadius.circular(
                        3,
                      ),
                    ),
                    CSizedBox().height10,
                    ShimmerWidget.rectagle(
                      height: 10,
                      width: MediaQuery.of(context).size.width * 0.7,
                      radius: BorderRadius.circular(
                        3,
                      ),
                    ),
                    CSizedBox().height5,
                    Row(
                      children: [
                        ShimmerWidget.rectagle(
                          height: 10,
                          width: 60,
                          radius: BorderRadius.circular(
                            3,
                          ),
                        ),
                        CSizedBox().width10,
                        ShimmerWidget.rectagle(
                          height: 10,
                          width: 60,
                          radius: BorderRadius.circular(
                            3,
                          ),
                        ),
                        CSizedBox().width10,
                        ShimmerWidget.rectagle(
                          height: 10,
                          width: 60,
                          radius: BorderRadius.circular(
                            3,
                          ),
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
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
