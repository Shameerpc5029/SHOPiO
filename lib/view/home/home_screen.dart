import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/controller/home/home_provider.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/view/home/widgets/carosal_widget.dart';
import 'package:ecommerce/view/home/widgets/category_widget.dart';
import 'package:ecommerce/view/widgets/loading_widget.dart';
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
          CSizedBox().height10,
          Column(
            children: [
              const CategoryWidget(),
              CSizedBox().height10,
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  const CarosalWidget(),
                  Consumer<HomeProvider>(
                    builder: (context, value, child) => Padding(
                      padding: const EdgeInsets.all(10),
                      child: AnimatedSmoothIndicator(
                        effect: ExpandingDotsEffect(
                          dotColor: Colors.grey.shade300,
                          activeDotColor: Colors.blue,
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
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      "All Products",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Consumer<HomeProvider>(
                  builder: (context, value, child) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 4.5,
                      ),
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: value.productList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            // value.goToProdutScreen(
                            //   value.productList[index].offer,
                            //   value.productList[index].id,
                            //   value.productList[index].size,
                            //   value.productList[index].category,
                            //   context,
                            //   '${ApiUrl.apiUrl}/uploads/products/${value.productList[index].image[0]}',
                            //   "₹${value.productList[index].price}",
                            //   value.productList[index].name,
                            //   value.productList[index].discountPrice,
                            // );
                            value.goToProdutScreen(
                              context,
                              value.productList[index].image,
                              value.productList[index].name,
                              value.productList[index].price,
                              value.productList[index].id,
                              value.productList[index].offer,
                              value.productList[index].size,
                              value.productList[index].category,
                              value.productList[index].rating,
                            );
                          },
                          child: Card(
                            elevation: 0,
                            child: value.isLoading == true
                                ? const LoadingWidget()
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                            splashRadius: 20,
                                            onPressed: () {},
                                            icon: const Icon(
                                              FontAwesomeIcons.heart,
                                              color: greyColor,
                                            )),
                                      ),
                                      Image(
                                        height: 120,
                                        image: NetworkImage(
                                          '${ApiUrl.apiUrl}/uploads/products/${value.productList[index].image[0]}',
                                        ),
                                      ),
                                      CSizedBox().height10,
                                      Text(
                                        value.productList[index].name,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      CSizedBox().height10,
                                      Text(
                                        "₹${value.productList[index].price}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: priceColor,
                                        ),
                                      ),
                                      CSizedBox().height5,
                                      Text(
                                        "${value.productList[index].offer}%Off",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: offerColor,
                                        ),
                                      ),
                                      // OutlinedButton(
                                      //   style: OutlinedButton.styleFrom(),
                                      //   onPressed: () {},
                                      //   child: const Text(
                                      //     'Add to cart',
                                      //     style: TextStyle(
                                      //       fontWeight: FontWeight.bold,
                                      //     ),
                                      //   ),
                                      // )
                                    ],
                                  ),
                          ),
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
  }
}
