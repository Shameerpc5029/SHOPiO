import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/controller/address/address_provider.dart';
import 'package:ecommerce/controller/cart/cart_provider.dart';
import 'package:ecommerce/controller/order_summary/order_summary_provider.dart';
import 'package:ecommerce/model/order_summery_enum/order_summery_enum.dart';
import 'package:ecommerce/view/cart/widgets/shimmer/cart_shimmer.dart';
import 'package:ecommerce/view/order_summary/order_summary_screen.dart';
import 'package:ecommerce/view/profile/address/address_screen.dart';
import 'package:ecommerce/view/widgets/custom_button.dart';
import 'package:ecommerce/view/cart/widgets/count_button.dart';
import 'package:ecommerce/view/widgets/loading_widget.dart';
import 'package:ecommerce/view/widgets/show_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CartProvider>(context, listen: false).getCart();
    });
    return Consumer<CartProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Cart'),
          ),
          body: Container(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: value.model == null || value.model!.products.isEmpty
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * .7,
                      child: const Center(
                        child: Image(
                          image: AssetImage(
                            'assets/images/empty-cart-1.png',
                          ),
                        ),
                      ),
                    )
                  : value.isLoading == true
                      ? const CartShimmer()
                      : ListView.separated(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: value.model?.products.length ?? 0,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    value.cartToProductView(context, index);
                                  },
                                  child: Row(
                                    children: [
                                      value.isLoading == true ||
                                              value.cartList.isEmpty
                                          ? const LoadingWidget()
                                          : Container(
                                              height: 90,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                image: NetworkImage(
                                                  '${ApiUrl.apiUrl}/products/${value.model!.products[index].product.image[0]}',
                                                ),
                                              )),
                                            ),
                                      CSizedBox().width10,
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .7,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .73,
                                              child: Text(
                                                value.model!.products[index]
                                                    .product.name,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            RatingBar.builder(
                                              ignoreGestures: true,
                                              allowHalfRating: true,
                                              onRatingUpdate: (value) {},
                                              itemBuilder: (context, hello) {
                                                return Icon(
                                                  Icons.star,
                                                  color: Colors.green.shade700,
                                                );
                                              },
                                              itemSize: 16,
                                              initialRating: double.parse(value
                                                  .model!
                                                  .products[index]
                                                  .product
                                                  .rating),
                                            ),
                                            CSizedBox().height5,
                                            Row(
                                              children: [
                                                Text(
                                                  '₹${value.model!.products[index].price}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: AppColor().greyColor,
                                                  ),
                                                ),
                                                CSizedBox().width10,
                                                Text(
                                                  '₹${(value.model!.products[index].price - value.model!.products[index].discountPrice).round()}',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      overflow:
                                                          TextOverflow.clip),
                                                ),
                                                CSizedBox().width10,
                                                Text(
                                                  "${value.model!.products[index].product.offer}% off",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppColor().offerColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            CSizedBox().height10,
                                            CountButton(
                                              countNumber:
                                                  '${value.model!.products[index].qty}',
                                              minusPressed: () {
                                                value
                                                    .incrementOrDecrementQuantity(
                                                  -1,
                                                  value.model!.products[index]
                                                      .product.id,
                                                  value.model!.products[index]
                                                      .size,
                                                  value.model!.products[index]
                                                      .qty,
                                                  context,
                                                );
                                              },
                                              plusPressed: () {
                                                value
                                                    .incrementOrDecrementQuantity(
                                                  1,
                                                  value.model!.products[index]
                                                      .product.id,
                                                  value.model!.products[index]
                                                      .size,
                                                  value.model!.products[index]
                                                      .qty,
                                                  context,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                CSizedBox().height5,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CustomButton(
                                      text: "Remove",
                                      icon: Icons.delete_outlined,
                                      buttonColor: AppColor().alertColor,
                                      onPressed: () {
                                        showCupertinoDialog(
                                          context: context,
                                          builder: (context) {
                                            return ShowAlertWidget(
                                              yesPress: () {
                                                value.removeFromCart(
                                                  context,
                                                  value.model!.products[index]
                                                      .product.id,
                                                );
                                              },
                                              title: 'Remove Item',
                                              contant:
                                                  'Are you sure you want to remove this item?',
                                            );
                                          },
                                        );
                                      },
                                      backgroundColor: AppColor().whiteColor,
                                    ),
                                    CSizedBox().width10,
                                    Consumer2<OrderSummaryProvider,
                                        AddressProvider>(
                                      builder:
                                          (context, order, address, child) {
                                        return CustomButton(
                                          text: "BUY NOW",
                                          icon: Icons.currency_rupee_outlined,
                                          buttonColor: AppColor().whiteColor,
                                          onPressed: () {
                                            order.loading = true;
                                            address.addressList.isEmpty
                                                ? Navigator.of(context)
                                                    .push(CupertinoPageRoute(
                                                    builder: (context) =>
                                                        const AddressScreen(),
                                                  ))
                                                : order.toOderScreen(
                                                    context,
                                                    value.model!.products[index]
                                                        .product.id,
                                                    value.model!.id,
                                                  );
                                          },
                                          backgroundColor:
                                              AppColor().themeColor,
                                        );
                                      },
                                    ),
                                  ],
                                )
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                        ),
            ),
          ),
          bottomNavigationBar: value.totalSave == 0 || value.totalSave == null
              ? const SizedBox()
              : Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor().whiteColor,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      "₹${value.model?.totalPrice ?? 0}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColor().greyColor,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    subtitle: Text(
                      "₹${(value.model!.totalPrice - value.model!.totalDiscount).round()}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: AppColor().priceColor,
                      ),
                    ),
                    trailing: SizedBox(
                      width: 200,
                      child: Consumer2<OrderSummaryProvider, AddressProvider>(
                        builder: (context, order, address, child) {
                          return address.addressList.isEmpty
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor().whiteColor,
                                    foregroundColor: AppColor().themeColor,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(CupertinoPageRoute(
                                      builder: (context) {
                                        return const AddressScreen();
                                      },
                                    ));
                                    order.loading = false;
                                  },
                                  child: const Text(
                                    'Go the address',
                                  ),
                                )
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor().themeColor,
                                    foregroundColor: AppColor().whiteColor,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(CupertinoPageRoute(
                                      builder: (context) {
                                        return const OrderSummaryScreen(
                                          screenCheck: OrderSummaryScreenEnum
                                              .normalOrderSummaryScreen,
                                          cartId: '',
                                          productId: '',
                                        );
                                      },
                                    ));
                                    order.loading = false;
                                  },
                                  child: Text(
                                    'PLACE ORDER (${value.totalProductCount})',
                                  ),
                                );
                        },
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
