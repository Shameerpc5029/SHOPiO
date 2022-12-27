import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/common/constants/api_url.dart';

import 'package:ecommerce/controller/home/home_provider.dart';
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
        return value.carousalList.isEmpty
            ? const LoadingWidget()
            : CarouselSlider.builder(
                itemCount: value.carousalList.length,
                itemBuilder: (context, index, realIndex) {
                  return SizedBox(
                    width: double.infinity,
                    child: Card(
                      color: Colors.grey,
                      child: value.isLoading == true
                          ? const LoadingWidget()
                          : Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                '${ApiUrl.apiUrl}/uploads/carousal/${value.carousalList[index].image}',
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
                  enableInfiniteScroll: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(
                    seconds: 3,
                  ),
                  autoPlayAnimationDuration: const Duration(
                    milliseconds: 800,
                  ),
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
