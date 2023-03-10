import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/controller/bottom_nav/bottom_nav_provider.dart';
import 'package:ecommerce/controller/cart/cart_provider.dart';
import 'package:ecommerce/controller/wish_list/wishlist_provider.dart';
import 'package:ecommerce/view/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      return Provider.of<WishListProvider>(context, listen: false)
          .getWishList();
    });
    return Consumer<WishListProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Wish List'),
          ),
          body: value.model == null || value.model!.products.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        width: 100,
                        image: AssetImage(
                          "assets/images/wishlist.png",
                        ),
                      ),
                      CSizedBox().height10,
                      const Text(
                        "Your wishlist is empty!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        'Click ❤️to save products',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor().greyColor,
                        ),
                      ),
                      CSizedBox().height20,
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor().themeColor,
                          foregroundColor: AppColor().whiteColor,
                          elevation: 0,
                        ),
                        onPressed: () {
                          Provider.of<BottomNavProvider>(context, listen: false)
                              .gotoHomescreen();
                        },
                        child: const Text('Find items to save'),
                      ),
                    ],
                  ),
                )
              : value.isLoading == true
                  ? const LoadingWidget()
                  : SingleChildScrollView(
                    padding: const EdgeInsets.all(10),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 4.5,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: value.model?.products.length ?? 0,
                        itemBuilder: (context, index) {
                          return Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              InkWell(
                                onTap: () =>
                                    value.wishListToProduct(context, index),
                                child: Container(
                                  // padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.black54,
                                      width: 0.3,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Center(
                                          child: Image(
                                            height: 130,
                                            image: NetworkImage(
                                              '${ApiUrl.apiUrl}/products/${value.model!.products[index].product.image[0]}',
                                            ),
                                          ),
                                        ),
                                        CSizedBox().height10,
                                        Text(
                                          value.model!.products[index].product
                                              .name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColor().greyColor,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "₹${value.model!.products[index].product.price}",
                                              style: const TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                            Text(
                                              "₹${(value.model!.products[index].product.price - value.model!.products[index].product.discountPrice).round()}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: AppColor().priceColor,
                                              ),
                                            ),
                                            Text(
                                              "${value.model!.products[index].product.offer}% off",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: AppColor().offerColor,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // CSizedBox().height5,
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
                                          initialRating: double.parse(
                                            value.model!.products[index].product
                                                .rating,
                                          ),
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: Consumer<CartProvider>(
                                            builder: (context, cart, child) {
                                              return cart.cartList.contains(
                                                value.model!.products[index]
                                                    .product.id,
                                              )
                                                  ? OutlinedButton.icon(
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                        foregroundColor:
                                                            AppColor()
                                                                .themeColor,
                                                      ),
                                                      onPressed: null,
                                                      label: const Text(
                                                          "Item in Cart"),
                                                      icon: const Icon(
                                                        Icons.check,
                                                        size: 20,
                                                      ),
                                                    )
                                                  : OutlinedButton(
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                        foregroundColor:
                                                            AppColor()
                                                                .themeColor,
                                                      ),
                                                      onPressed: () {
                                                        cart.addToCart(
                                                            value
                                                                .model!
                                                                .products[index]
                                                                .product
                                                                .id,
                                                            context);
                                                      },
                                                      child: const Text(
                                                          "Add To Cart"),
                                                    );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  value.addAndRemoveWishList(context,
                                      value.model!.products[index].product.id);
                                },
                                splashRadius: 20,
                                icon: Icon(
                                  Icons.favorite,
                                  color: AppColor().redColor,
                                  size: 30,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
        );
      },
    );
  }
}
