import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/controller/cart/cart_provider.dart';
import 'package:ecommerce/view/cart/widgets/cart_custom_button.dart';
import 'package:ecommerce/view/cart/widgets/count_button.dart';
import 'package:ecommerce/view/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      bottomNavigationBar: provider.totalSave == 0
          ? const SizedBox()
          : Container(
              height: 70,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: ListTile(
                title: Text(
                  "₹${provider.model?.totalPrice ?? 0}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: greyColor,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                subtitle: Text(
                  "₹${provider.totalSave}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.red,
                  ),
                ),
                trailing: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeColor,
                    ),
                    onPressed: () {},
                    child: Text(
                      'PLACE ORDER (${provider.totalProductCount})',
                    ),
                  ),
                ),
              ),
            ),
      body: SingleChildScrollView(
        child: provider.model == null || provider.model!.products.isEmpty
            ? SizedBox(
                height: MediaQuery.of(context).size.height * .7,
                child: const Center(
                  child: Text(
                    'Cart is Empty',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            : ListView.separated(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: provider.model?.products.length ?? 0,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              provider.isLoading == true
                                  ? const LoadingWidget()
                                  : Container(
                                      height: 90,
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                        image: NetworkImage(
                                          '${ApiUrl.apiUrl}/products/${provider.model!.products[index].product.image[0]}',
                                        ),
                                      )),
                                    ),
                              CSizedBox().width10,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    provider
                                        .model!.products[index].product.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  RatingBar.builder(
                                    ignoreGestures: true,
                                    allowHalfRating: true,
                                    onRatingUpdate: (value) {},
                                    itemBuilder: (context, hello) {
                                      return const Icon(
                                        Icons.star,
                                        color: Color.fromARGB(255, 24, 110, 29),
                                      );
                                    },
                                    itemSize: 16,
                                    initialRating: double.parse(provider
                                        .model!.products[index].product.rating),
                                  ),
                                  CSizedBox().height5,
                                  Row(
                                    children: [
                                      Text(
                                        "${provider.model!.products[index].product.offer}%off",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                      CSizedBox().width10,
                                      Text(
                                        '₹${provider.model!.products[index].price}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: greyColor,
                                        ),
                                      ),
                                      CSizedBox().width10,
                                      Text(
                                        '₹${provider.model!.products[index].price - provider.model!.products[index].discountPrice}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  CSizedBox().height10,
                                  CountButton(
                                    countNumber:
                                        '${provider.model!.products[index].qty}',
                                    minusPressed: () {
                                      provider.incrementOrDecrementQuantity(
                                        -1,
                                        provider
                                            .model!.products[index].product.id,
                                        provider.model!.products[index].size,
                                        provider.model!.products[index].qty,
                                        context,
                                      );
                                    },
                                    plusPressed: () {
                                      provider.incrementOrDecrementQuantity(
                                        1,
                                        provider
                                            .model!.products[index].product.id,
                                        provider.model!.products[index].size,
                                        provider.model!.products[index].qty,
                                        context,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CartCustomButton(
                              text: "Remove",
                              icon: Icons.delete_outlined,
                              buttonColor: greyColor,
                              onPressed: () {
                                provider.removeFromCart(
                                  context,
                                  provider.model!.products[index].product.id,
                                );
                              },
                            ),
                            CartCustomButton(
                              text: "BUY NOW",
                              icon: Icons.currency_rupee_outlined,
                              buttonColor: Colors.red,
                              onPressed: () {},
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
      ),
    );
  }
}
