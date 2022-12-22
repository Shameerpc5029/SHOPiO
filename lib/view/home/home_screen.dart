import 'package:ecommerce/constants/api_url.dart';
import 'package:ecommerce/controller/home/home_provider.dart';
import 'package:ecommerce/view/core/style_const.dart';
import 'package:ecommerce/view/home/widgets/carosal_widget.dart';
import 'package:ecommerce/view/home/widgets/category_widget.dart';
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
          height10,
          Column(
            children: [
              const CategoryWidget(),
              height10,
              const CarosalWidget(),
              height10,
              Consumer<HomeProvider>(
                builder: (context, value, child) => AnimatedSmoothIndicator(
                  effect: const ExpandingDotsEffect(
                    spacing: 10,
                    dotHeight: 10,
                    dotWidth: 10,
                  ),
                  curve: Curves.ease,
                  activeIndex: value.activeIndex,
                  count: value.carousalList.length,
                ),
              ),
              height10,
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
                padding: const EdgeInsets.all(0),
                child: Consumer<HomeProvider>(
                  builder: (context, value, child) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 4.2,
                      ),
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      // itemCount: 20,
                      itemCount: value.productList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                height: 130,
                                image: NetworkImage(
                                  '${ApiUrl.apiUrl}/uploads/products/${value.productList[index].image[0]}',
                                ),
                              ),
                              height10,
                              Text(
                                value.productList[index].name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              height10,
                              Text(
                                "₹${value.productList[index].price}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.red,
                                ),
                              ),
                              OutlinedButton.icon(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.add_shopping_cart_rounded,
                                ),
                                label: const Text(
                                  'Add to cart',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
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
