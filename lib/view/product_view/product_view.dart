import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/controller/address/address_provider.dart';
import 'package:ecommerce/controller/cart/cart_provider.dart';
import 'package:ecommerce/controller/home/home_provider.dart';
import 'package:ecommerce/controller/wish_list/wishlist_provider.dart';
import 'package:ecommerce/view/product_view/widgets/bottom_nav_button.dart';
import 'package:ecommerce/view/order/order_summary_screen.dart';
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
  final int offerPrice = 0;

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
                        activeDotColor: themeColor,
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
                          return const Icon(
                            Icons.star,
                            color: Color.fromARGB(255, 24, 110, 29),
                          );
                        },
                        itemSize: 18,
                        initialRating: double.parse(provider.rating),
                      ),
                    ],
                  ),
                  Consumer<WishListProvider>(
                    builder: (context, value, child) {
                      return SizedBox(
                        height: 40,
                        child: FloatingActionButton(
                          elevation: 1,
                          foregroundColor: value.wishlist.contains(provider.id)
                              ? Colors.red
                              : greyColor,
                          backgroundColor: Colors.white,
                          onPressed: () {
                            value.addAndRemoveWishList(context, productId);
                          },
                          child: const Icon(
                            Icons.favorite,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              CSizedBox().height10,
              Container(
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
                              color: themeColor,
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
                              color: themeColor,
                            ),
                          ),
                          CSizedBox().width10,
                          Text(
                            "₹${provider.price}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: greyColor,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          CSizedBox().width10,
                          Text(
                            "₹${(provider.price - provider.discountPrice).round()}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: themeColor,
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
              CSizedBox().height20,
              const Text(
                "Product Discription",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              CSizedBox().height5,
              const ReadMoreText(
                "is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose",
                moreStyle: TextStyle(
                  color: blueColor,
                  fontWeight: FontWeight.bold,
                ),
                lessStyle: TextStyle(
                  color: blueColor,
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
              const HighlightsWidget(
                icon: Icons.memory_outlined,
                titleText: 'Processor',
                subText: 'A15 Bionic chip',
              ),
              const HighlightsWidget(
                icon: Icons.sd_storage,
                titleText: 'Ram',
                subText: '6 GB Ram',
              ),
              const HighlightsWidget(
                icon: Icons.camera_alt_outlined,
                titleText: 'Rear Camera',
                subText: '12MP | 12MP',
              ),
              const HighlightsWidget(
                icon: Icons.flip_camera_ios_outlined,
                titleText: 'Front Camera',
                subText: '12MP',
              ),
              const HighlightsWidget(
                icon: Icons.aod_outlined,
                titleText: 'Display',
                subText: '6.53 inch HD+IPS',
              ),
              const HighlightsWidget(
                icon: Icons.battery_charging_full_outlined,
                titleText: 'Battery',
                subText: '5000 mAh',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Material(
        elevation: 20,
        child: Row(
          children: [
            Consumer2<CartProvider, HomeProvider>(
              builder: (context, value, value2, child) {
                return value.cartList.contains(productId)
                    ? BottomNavButton(
                        text: 'Go to Cart',
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
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
            Consumer2<CartProvider, AddressProvider>(
              builder: (context, value, address, child) {
                return BottomNavButton(
                  text: 'BUY NOW',
                  backgroundColor: themeColor,
                  foregroundColor: Colors.white,
                  onPressed: () {
                    value.addToCart(productId, context);
                    Navigator.of(context).pushNamed(
                      OrderSummaryScreen.routeName,
                      arguments: productId,
                    );
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
