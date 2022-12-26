import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/controller/home/home_provider.dart';
import 'package:ecommerce/view/home/product_view/widgets/bottom_nav_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductView extends StatelessWidget {
  const ProductView({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.id,
    this.discountPrice,
    required this.offer,
    required this.size,
    required this.category,
    required this.rating,
  });
  final String id;
  final String name;
  final int price;
  final dynamic discountPrice;
  final int offer;
  final List<String> size;
  final List<String> image;
  final String category;
  final String rating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          BottomNavButton(
            text: 'Add to cart',
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          BottomNavButton(
            text: 'BUY NOW',
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
        ],
      ),
      appBar: AppBar(
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<HomeProvider>(
          builder: (context, value, child) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CSizedBox().height10,
                  Center(
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        CarouselSlider.builder(
                          itemBuilder: (context, index, realIndex) {
                            return SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.55,
                              child: Image(
                                image: NetworkImage(
                                  '${ApiUrl.apiUrl}/uploads/products/${image[index]}',
                                ),
                              ),
                            );
                          },
                          itemCount: image.length,
                          options: CarouselOptions(
                            viewportFraction: 1,
                            onPageChanged: (index, reason) {
                              value.carosal(index);
                            },
                          ),
                        ),
                        Column(
                          children: [
                            Material(
                              shape: const CircleBorder(),
                              elevation: 2,
                              child: CircleAvatar(
                                backgroundColor: whiteColor,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: greyColor,
                                    )),
                              ),
                            ),
                            CSizedBox().height10,
                            Material(
                              shape: const CircleBorder(),
                              elevation: 2,
                              child: CircleAvatar(
                                backgroundColor: whiteColor,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      FontAwesomeIcons.share,
                                      color: greyColor,
                                    )),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  CSizedBox().height10,
                  Center(
                    child: AnimatedSmoothIndicator(
                      activeIndex: value.activeIndex,
                      count: image.length,
                      effect: const WormEffect(
                        dotHeight: 10,
                        dotWidth: 10,
                      ),
                    ),
                  ),
                  CSizedBox().height10,
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 70,
                      child: ListView.separated(
                        itemCount: image.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  '${ApiUrl.apiUrl}/uploads/products/${image[index]}',
                                ),
                              ),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return CSizedBox().width10;
                        },
                      ),
                    ),
                  ),
                  CSizedBox().height20,
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  CSizedBox().height5,
                  RatingBar.builder(
                    ignoreGestures: true,
                    allowHalfRating: true,
                    onRatingUpdate: (value) {},
                    itemBuilder: (context, index) {
                      return const Icon(
                        Icons.star,
                        color: Color.fromARGB(255, 24, 110, 29),
                      );
                    },
                    itemSize: 20,
                    initialRating: double.parse(rating),
                  ),
                  CSizedBox().height10,
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 222, 243, 223),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: const [
                              Text(
                                'Special price',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          CSizedBox().height5,
                          Row(
                            children: [
                              Text(
                                '$offer% off',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              // CSizedBox().width10,
                              // Text(
                              //   price.toString(),
                              //   style: TextStyle(
                              //     fontWeight: FontWeight.bold,
                              //     fontSize: 20,
                              //     color: greyColor,
                              //     decoration: TextDecoration.lineThrough,
                              //   ),
                              // ),
                              CSizedBox().width10,
                              Text(
                                "₹$price",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: priceColor,
                                  overflow: TextOverflow.clip,
                                ),
                                maxLines: 1,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  CSizedBox().height10,
                  Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.moneyBill1Wave,
                        color: Colors.green,
                        size: 20,
                      ),
                      CSizedBox().width10,
                      const Text("Cash on delivery available"),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
