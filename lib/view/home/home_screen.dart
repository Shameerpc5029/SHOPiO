import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/controller/home/home_provider.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
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
          CSizedBox().height10,
          Column(
            children: [
              const CategoryWidget(),
              CSizedBox().height10,
              Stack(
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
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Text(
                      "All Products",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Consumer<HomeProvider>(
                  builder: (context, value, child) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 4,
                      ),
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: value.productList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                            onTap: () {
                              value.goToProdutScreen(context, index);
                            },
                            child: GridTile(
                              header: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "${value.productList[index].offer}%Off",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: offerColor,
                                    ),
                                  ),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    height: 120,
                                    image: NetworkImage(
                                      '${ApiUrl.apiUrl}/products/${value.productList[index].image[0]}',
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
                                      fontSize: 16,
                                      color: greyColor,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  Text(
                                    "₹${value.productList[index].price - value.productList[index].discountPrice}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: priceColor,
                                    ),
                                  ),
                                ],
                              ),
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
