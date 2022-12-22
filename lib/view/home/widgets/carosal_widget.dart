import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/constants/api_url.dart';

import 'package:ecommerce/controller/home/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarosalWidget extends StatelessWidget {
  const CarosalWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, value, child) {
        return value.carousalList.isEmpty
            ? const CircularProgressIndicator(
                strokeWidth: 2,
              )
            : CarouselSlider.builder(
                itemCount: value.carousalList.length,
                itemBuilder: (context, index, realIndex) {
                  return SizedBox(
                    width: 500,
                    child: Card(
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(15.0),
                      // ),
                      color: Colors.grey,
                      child: value.isLoading == true
                          ? const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
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
                  height: 180,
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
