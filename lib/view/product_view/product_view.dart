import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/controller/cart/cart_provider.dart';
import 'package:ecommerce/controller/home/home_provider.dart';
import 'package:ecommerce/controller/wish_list/wishlist_provider.dart';
import 'package:ecommerce/view/product_view/widgets/bottom_nav_button.dart';
import 'package:ecommerce/view/product_view/widgets/highlights_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductView extends StatelessWidget {
  static const routeName = "product_view";
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final provider = Provider.of<HomeProvider>(context).findById(productId);
    return Scaffold(
      appBar: AppBar(
        leading: Consumer<HomeProvider>(
          builder: (context, value, child) {
            return IconButton(
              splashRadius: 25,
              onPressed: () {
                value.goToPop(context);
              },
              icon: const Icon(
                CupertinoIcons.back,
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
                child: Consumer<HomeProvider>(
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
              ),
              CSizedBox().height10,
              Consumer<HomeProvider>(
                builder: (context, value, child) {
                  return Center(
                    child: AnimatedSmoothIndicator(
                      activeIndex: value.activeIndex,
                      count: provider.image.length,
                      effect: WormEffect(
                        activeDotColor: AppColor().themeColor,
                        dotHeight: 10,
                        dotWidth: 10,
                      ),
                    ),
                  );
                },
              ),
              CSizedBox().height20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .8,
                        child: Text(
                          provider.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              overflow: TextOverflow.ellipsis),
                          maxLines: 1,
                        ),
                      ),
                      CSizedBox().height5,
                      RatingBar.builder(
                        ignoreGestures: true,
                        allowHalfRating: true,
                        onRatingUpdate: (value) {},
                        itemBuilder: (context, index) {
                          return Icon(
                            Icons.star,
                            color: Colors.green.shade700,
                          );
                        },
                        itemSize: 18,
                        initialRating: double.parse(provider.rating),
                      ),
                    ],
                  ),
                  // Consumer<WishListProvider>(
                  //   builder: (context, value, child) {
                  //     return SizedBox(
                  //       height: 40,
                  //       child: FloatingActionButton(
                  //         elevation: 1,
                  //         foregroundColor: value.wishlist.contains(provider.id)
                  //             ? Colors.red
                  //             : greyColor,
                  //         backgroundColor: Colors.white,
                  //         onPressed: () {
                  //           value.addAndRemoveWishList(context, productId);
                  //         },
                  //         child: const Icon(
                  //           Icons.favorite,
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
                ],
              ),
              CSizedBox().height10,
              provider.offer == 0
                  ? Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Text(
                        "₹${provider.price}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    )
                  : Container(
                      color: const Color.fromARGB(41, 33, 149, 243),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Special price',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColor().themeColor,
                                  ),
                                ),
                              ],
                            ),
                            CSizedBox().height5,
                            Row(
                              children: [
                                Text(
                                  '${provider.offer}% off',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor().themeColor,
                                  ),
                                ),
                                CSizedBox().width10,
                                Text(
                                  "₹${provider.price}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: AppColor().greyColor,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                CSizedBox().width10,
                                Text(
                                  "₹${(provider.price - provider.discountPrice).round()}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: AppColor().themeColor,
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
              const Text(
                "Product Discription",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              CSizedBox().height5,
              ReadMoreText(
                provider.description,
                moreStyle: TextStyle(
                  color: AppColor().blueColor,
                  fontWeight: FontWeight.bold,
                ),
                lessStyle: TextStyle(
                  color: AppColor().blueColor,
                  fontWeight: FontWeight.bold,
                ),
                trimLength: 150,
                trimExpandedText: '  show less',
              ),
              CSizedBox().height10,
              const Text(
                "Highlights",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              HighlightsWidget(
                icon: Icons.memory_outlined,
                titleText: 'Processor',
                subText: provider.details.processor.toString(),
              ),
              HighlightsWidget(
                icon: Icons.sd_storage,
                titleText: 'Ram',
                subText: '${provider.details.ram} GB RAM',
              ),
              HighlightsWidget(
                icon: Icons.camera_alt_outlined,
                titleText: 'Rear Camera',
                subText: '${provider.details.rearCam}',
              ),
              HighlightsWidget(
                icon: Icons.flip_camera_ios_outlined,
                titleText: 'Front Camera',
                subText: '${provider.details.frontCam}',
              ),
              HighlightsWidget(
                icon: Icons.aod_outlined,
                titleText: 'Display',
                subText: '${provider.details.display}',
              ),
              HighlightsWidget(
                icon: Icons.battery_charging_full_outlined,
                titleText: 'Battery',
                subText: '${provider.details.battery}',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Material(
        elevation: 20,
        child: Row(
          children: [
            Consumer<WishListProvider>(
              builder: (context, value, child) {
                return BottomNavButton(
                  text: 'wishList',
                  backgroundColor: value.wishlist.contains(provider.id)
                      ? Colors.green.shade600
                      : AppColor().whiteColor,
                  foregroundColor: value.wishlist.contains(provider.id)
                      ? Colors.white
                      : Colors.black,
                  onPressed: () {
                    value.addAndRemoveWishList(context, productId);
                  },
                );
              },
            ),
            Consumer2<CartProvider, HomeProvider>(
              builder: (context, value, value2, child) {
                return value.cartList.contains(productId)
                    ? BottomNavButton(
                        text: 'Go to Cart',
                        backgroundColor: AppColor().themeColor,
                        foregroundColor: Colors.white,
                        onPressed: () {
                          value2.goToCategory(context);
                        },
                      )
                    : BottomNavButton(
                        text: 'Add to cart',
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        onPressed: () {
                          value.addToCart(productId, context);
                        },
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
