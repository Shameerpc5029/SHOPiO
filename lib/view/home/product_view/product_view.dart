import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/controller/cart/cart_provider.dart';
import 'package:ecommerce/controller/home/home_provider.dart';
import 'package:ecommerce/controller/wish_list/wishlist_provider.dart';
import 'package:ecommerce/view/home/product_view/widgets/bottom_nav_button.dart';
import 'package:ecommerce/view/order/order_summary_screen.dart';
import 'package:ecommerce/view/widgets/circle_button.dart';
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
            BottomNavButton(
              text: 'BUY NOW',
              backgroundColor: themeColor,
              foregroundColor: Colors.white,
              onPressed: () {
                Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) {
                    return const OrderSummaryScreen();
                  },
                ));
              },
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
              // Align(
              //   alignment: Alignment.center,
              //   child: SizedBox(
              //     height: 70,
              //     child: ListView.separated(
              //       itemCount: provider.image.length,
              //       shrinkWrap: true,
              //       scrollDirection: Axis.horizontal,
              //       itemBuilder: (context, index) {
              //         return Container(
              //           width: 50,
              //           decoration: BoxDecoration(
              //             image: DecorationImage(
              //               image: NetworkImage(
              //                 '${ApiUrl.apiUrl}/products/${provider.image[index]}',
              //               ),
              //             ),
              //             borderRadius: BorderRadius.circular(10),
              //             border: Border.all(),
              //           ),
              //         );
              //       },
              //       separatorBuilder: (context, index) {
              //         return CSizedBox().width10;
              //       },
              //     ),
              //   ),
              // ),
              CSizedBox().height10,
              Text(
                provider.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
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
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: themeColor,
                            ),
                          ),
                          CSizedBox().width10,
                          Text(
                            "₹${provider.price}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: greyColor,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          CSizedBox().width10,
                          Text(
                            "₹${(provider.price - provider.discountPrice).round()}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
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
                  fontSize: 16,
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
                trimExpandedText: '  show less',
              ),

              CSizedBox().height10,

              // Row(
              //   children: [
              //     const Icon(
              //       FontAwesomeIcons.moneyBill1Wave,
              //       color: Colors.green,
              //       size: 20,
              //     ),
              //     CSizedBox().width10,
              //     const Text("Cash on delivery available"),
              //   ],
              // ),

              const Text(
                "Highlights",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
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
    );
  }
}

class HighlightsWidget extends StatelessWidget {
  const HighlightsWidget({
    Key? key,
    required this.icon,
    required this.titleText,
    required this.subText,
  }) : super(key: key);

  final IconData icon;
  final String titleText;
  final String subText;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0,
      contentPadding: EdgeInsets.zero,
      dense: true,
      leading: Container(
        margin: const EdgeInsets.fromLTRB(0, 5, 0, 0.0),
        child: Icon(
          icon,
          size: 30,
          color: Colors.grey.shade500,
        ),
      ),
      title: Text(
        titleText,
        style: const TextStyle(
          color: greyColor,
        ),
      ),
      subtitle: Text(
        subText,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
