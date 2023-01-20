import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/common/constants/api_url.dart';

import 'package:ecommerce/controller/home/home_provider.dart';
import 'package:ecommerce/view/home/widgets/shimmer/carosal_shimmer.dart';
import 'package:ecommerce/view/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarousellWidget extends StatelessWidget {
  const CarousellWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, value, child) {
        return value.isLoading == true
            ? const CarouselShimmer()
            : CarouselSlider.builder(
                itemCount: value.carousalList.length,
                itemBuilder: (context, index, realIndex) {
                  return SizedBox(
                    width: double.infinity,
                    child: Container(
                      color: Colors.grey,
                      child:
                          value.isLoading == true || value.carousalList.isEmpty
                              ? const LoadingWidget()
                              : Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    '${ApiUrl.apiUrl}/carousal/${value.carousalList[index].image}',
                                  ),
                                ),
                    ),
                  );
                },
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    value.carosal(index);
                  },
                  viewportFraction: 1,
                  initialPage: value.activeIndex,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(
                    seconds: 3,
                  ),
                  aspectRatio: 18 / 9,
                  enlargeCenterPage: true,
                  pageSnapping: true,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                ),
              );
      },
    );
  }
}
