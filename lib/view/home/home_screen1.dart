import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/controller/home/carosal_provider.dart';
import 'package:ecommerce/view/core/style_const.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        title: const Image(
          height: 25,
          image: AssetImage(
            'assets/images/logo 3.png',
          ),
        ),
        actions: [
          IconButton(
            splashRadius: 25,
            color: Colors.black,
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.magnifyingGlass,
            ),
          )
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Column(
            children: [
              Consumer<CarosalProvider>(
                builder: (context, value, child) {
                  return CarouselSlider.builder(
                    itemCount: 5,
                    itemBuilder: (context, index, realIndex) {
                      return SizedBox(
                        height: 50,
                        width: 500,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.grey,
                        ),
                      );
                    },
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        value.carosal(index);
                      },
                      height: 150,
                      viewportFraction: 0.9,
                      initialPage: value.activeIndex,
                      enableInfiniteScroll: false,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      scrollDirection: Axis.horizontal,
                    ),
                  );
                },
              ),
              height10,
              Consumer<CarosalProvider>(
                builder: (context, value, child) => AnimatedSmoothIndicator(
                  effect: const ExpandingDotsEffect(
                    spacing: 10,
                    dotHeight: 10,
                    dotWidth: 10,
                  ),
                  curve: Curves.ease,
                  activeIndex: value.activeIndex,
                  count: 5,
                ),
              ),
              height10,
              SizedBox(
                height: 100,
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: SizedBox(
                        width: 100,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),
              ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      // height: MediaQuery.of(context).size.height * .25,
                      height: 160,
                      width: double.infinity,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width * .6,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Apple IPhone 14 Pro",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      height10,
                                      const Text(
                                        "Color : Space Black",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(
                                        "Storage : 512 GB",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(
                                        "A16 Bionic Chip",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      height10,
                                      const Text(
                                        "₹1,49,900",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * .20,
                                height: 130,
                                child: const Image(
                                  fit: BoxFit.fitWidth,
                                  image: AssetImage(
                                    'assets/images/[CITYPNG.COM]iPhone 14 Pro And Max Deep Purple PNG - 2350x4070.png',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
