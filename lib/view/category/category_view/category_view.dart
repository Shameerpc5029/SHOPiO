import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/controller/home/home_provider.dart';
import 'package:ecommerce/view/product_view/product_view.dart';
import 'package:ecommerce/view/widgets/product_card.dart';
import 'package:ecommerce/view/widgets/shimmer/product_card_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryView extends StatelessWidget {
  static const routeName = "/category_view";
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final providerByCategory = Provider.of<HomeProvider>(context, listen: false)
        .findByCategoryId(productId);
    final categoryName = Provider.of<HomeProvider>(context, listen: false)
        .categoryName(productId);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            CupertinoIcons.back,
          ),
        ),
        title: Text(categoryName.name),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Hero(
              transitionOnUserGestures: true,
              tag: categoryName.id,
              child: CircleAvatar(
                backgroundColor: whiteColor,
                backgroundImage: NetworkImage(
                  '${ApiUrl.apiUrl}/category/${categoryName.image}',
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Consumer<HomeProvider>(
            builder: (context, value, child) {
              return value.productList.isEmpty
                  ? const ProductCardShimmer()
                  : Column(
                      children: [
                        CSizedBox().height10,
                        GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 4,
                          ),
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: providerByCategory.length,
                          itemBuilder: (context, index) {
                            return ProductCard(
                              index: index,
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  ProductView.routeName,
                                  arguments: providerByCategory[index].id,
                                );
                              },
                              offer: "${providerByCategory[index].offer}% Off",
                              image:
                                  '${ApiUrl.apiUrl}/products/${providerByCategory[index].image[0]}',
                              name: providerByCategory[index].name,
                              price: "₹${providerByCategory[index].price}",
                              discountPrice:
                                  "₹${(providerByCategory[index].price - providerByCategory[index].discountPrice).round()}",
                            );
                          },
                        ),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
