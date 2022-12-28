import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/controller/home/home_provider.dart';
import 'package:ecommerce/controller/wish_list/wishlist_provider.dart';
import 'package:ecommerce/view/home/product_view/widgets/bottom_nav_button.dart';
import 'package:ecommerce/view/widgets/circle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductView extends StatelessWidget {
  static const routeName = "/product_view";
  const ProductView({super.key});
  final int offerPrice = 0;

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final provider = Provider.of<HomeProvider>(context).findById(productId);
    return Scaffold(
      bottomNavigationBar: Material(
        elevation: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const BottomNavButton(
              text: 'Add to cart',
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
            BottomNavButton(
              text: 'BUY NOW',
              backgroundColor: themeColor,
              foregroundColor: Colors.white,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: Consumer<HomeProvider>(
          builder: (context, value, child) {
            return IconButton(
              splashRadius: 25,
              onPressed: () {
                value.goToPop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
            );
          },
        ),
        title: Text(
          provider.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CSizedBox().height10,
              Center(
                child: Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Consumer<HomeProvider>(
                      builder: (context, value, child) {
                        return CarouselSlider.builder(
                          itemBuilder: (context, index, realIndex) {
                            return SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.55,
                              child: Image(
                                image: NetworkImage(
                                  '${ApiUrl.apiUrl}/products/${provider.image[index]}',
                                ),
                              ),
                            );
                          },
                          itemCount: provider.image.length,
                          options: CarouselOptions(
                            viewportFraction: 1,
                            onPageChanged: (index, reason) {
                              value.carosal(index);
                            },
                          ),
                        );
                      },
                    ),
                    Consumer<WishListProvider>(
                      builder: (context, value, child) {
                        return Column(
                          children: [
                            CircleButtonWidget(
                              onPressed: () {
                                value.addAndRemoveWishList(context, productId);
                              },
                              icon: Icon(
                                Icons.favorite,
                                color: value.wishlist.contains(provider.id)
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                            )
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
              CSizedBox().height10,
              Consumer<HomeProvider>(
                builder: (context, value, child) {
                  return Center(
                    child: AnimatedSmoothIndicator(
                      activeIndex: value.activeIndex,
                      count: provider.image.length,
                      effect: const WormEffect(
                        dotHeight: 10,
                        dotWidth: 10,
                      ),
                    ),
                  );
                },
              ),
              CSizedBox().height10,
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 70,
                  child: ListView.separated(
                    itemCount: provider.image.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              '${ApiUrl.apiUrl}/products/${provider.image[index]}',
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
                provider.name,
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
                initialRating: double.parse(provider.rating),
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
                            '${provider.offer}% off',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          CSizedBox().width10,
                          // Text(
                          //   provider.discountPrice.toString(),
                          //   style: TextStyle(
                          //     fontWeight: FontWeight.bold,
                          //     fontSize: 20,
                          //     color: greyColor,
                          //     decoration: TextDecoration.lineThrough,
                          //   ),
                          // ),
                          CSizedBox().width10,
                          Text(
                            "₹${provider.price}",
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
        ),
      ),
    );
  }
}
