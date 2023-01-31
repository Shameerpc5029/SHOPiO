import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/controller/connection/connecton_provider.dart';
import 'package:ecommerce/controller/home/home_provider.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/view/home/widgets/carosal_widget.dart';
import 'package:ecommerce/view/home/widgets/category_widget.dart';
import 'package:ecommerce/view/search/search_screen.dart';
import 'package:ecommerce/view/widgets/loading_widget.dart';
import 'package:ecommerce/view/widgets/product_card.dart';
import 'package:ecommerce/view/widgets/shimmer/product_card_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<InternetCheck>(context, listen: false)
          .getConnectivity(context);
    });
    return Consumer<HomeProvider>(
      builder: (context, value, child) {
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
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const SearchScreen();
                    },
                  ));
                },
                icon: const Icon(
                  FontAwesomeIcons.magnifyingGlass,
                ),
              )
            ],
          ),
          body: ListView(
            shrinkWrap: true,
            children: [
              CSizedBox().height10,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "Top brands",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  CSizedBox().height10,
                  const CategoryWidget(),
                  CSizedBox().height10,
                  value.isLoading == true
                      ? const LoadingWidget()
                      : Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            const CarousellWidget(),
                            Consumer<HomeProvider>(
                              builder: (context, value, child) => Padding(
                                padding: const EdgeInsets.all(10),
                                child: AnimatedSmoothIndicator(
                                  effect: ExpandingDotsEffect(
                                    dotColor: Colors.grey.shade300,
                                    activeDotColor: themeColor,
                                    spacing: 10,
                                    dotHeight: 10,
                                    dotWidth: 10,
                                  ),
                                  curve: Curves.ease,
                                  activeIndex: value.activeIndex,
                                  count: value.carousalList.length,
                                ),
                              ),
                            ),
                          ],
                        ),
                  CSizedBox().height10,
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Text(
                      "All Products",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Consumer<HomeProvider>(
                      builder: (context, value, child) {
                        return value.isLoading == true ||
                                value.productList.isEmpty
                            ? const ProductCardShimmer()
                            : GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 3 / 4,
                                ),
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: value.productList.length,
                                itemBuilder: (context, index) {
                                  return ProductCard(
                                    index: index,
                                    onTap: () =>
                                        value.goToProdutScreen(context, index),
                                    offer:
                                        "${value.productList[index].offer}%Off",
                                    image:
                                        '${ApiUrl.apiUrl}/products/${value.productList[index].image[0]}',
                                    name: value.productList[index].name,
                                    price: "₹${value.productList[index].price}",
                                    discountPrice:
                                        "₹${(value.productList[index].price - value.productList[index].discountPrice).round()}",
                                  );
                                },
                              );
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
