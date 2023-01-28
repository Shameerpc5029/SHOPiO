import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/controller/home/home_provider.dart';
import 'package:ecommerce/view/widgets/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 25,
        title: Consumer<HomeProvider>(
          builder: (context, value, child) {
            return CupertinoSearchTextField(
              autofocus: true,
              padding: const EdgeInsets.all(10),
              placeholder: 'Search for products',
              controller: value.searchController,
              onChanged: (result) {
                value.search(result);
              },
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<HomeProvider>(
          builder: (context, value, child) {
            return value.seachResult.isEmpty
                ? const Center(
                    heightFactor: 40,
                    child: Text(
                      'No search result found',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 4,
                      ),
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: value.seachResult.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          index: index,
                          onTap: () => value.goToProdutScreen(context, index),
                          offer: "${value.seachResult[index].offer}%Off",
                          image:
                              '${ApiUrl.apiUrl}/products/${value.seachResult[index].image[0]}',
                          name: value.seachResult[index].name,
                          price: "₹${value.seachResult[index].price}",
                          discountPrice:
                              "₹${(value.seachResult[index].price - value.seachResult[index].discountPrice).round()}",
                        );
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }
}
