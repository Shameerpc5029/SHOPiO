import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/view/widgets/shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
      ),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: GridTile(
            header: Padding(
              padding: const EdgeInsets.all(5),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ShimmerWidget.rectagle(
                      radius: BorderRadius.circular(5),
                      height: 10,
                      width: 40,
                    ),
                  )),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShimmerWidget.rectagle(
                  radius: BorderRadius.circular(5),
                  height: MediaQuery.of(context).size.height * .15,
                  width: MediaQuery.of(context).size.width * .4,
                ),
                CSizedBox().height10,
                ShimmerWidget.rectagle(
                  radius: BorderRadius.circular(5),
                  height: 10,
                  width: 120,
                ),
                CSizedBox().height10,
                ShimmerWidget.rectagle(
                  radius: BorderRadius.circular(5),
                  height: 10,
                  width: 90,
                ),
                CSizedBox().height10,
                ShimmerWidget.rectagle(
                  radius: BorderRadius.circular(5),
                  height: 10,
                  width: 80,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
