import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/controller/address/address_provider.dart';
import 'package:ecommerce/controller/cart/cart_provider.dart';
import 'package:ecommerce/controller/order_summary/order_summary_provider.dart';
import 'package:ecommerce/controller/payment/payment_provider.dart';
import 'package:ecommerce/model/order_summery_enum/order_summery_enum.dart';
import 'package:ecommerce/view/order/widgets/address_widget.dart';
import 'package:ecommerce/view/profile/address/address_screen.dart';
import 'package:ecommerce/view/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class OrderSummaryScreen extends StatefulWidget {
  const OrderSummaryScreen(
      {super.key,
      required this.screenCheck,
      required this.cartId,
      required this.productId});

  final OrderSummaryScreenEnum screenCheck;

  final String cartId;
  final String productId;

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  PaymentProvider paymentProvider = PaymentProvider();

  @override
  void initState() {
    final paymentProvider =
        Provider.of<PaymentProvider>(context, listen: false);
    final razorpay = paymentProvider.razorpay;
    super.initState();

    razorpay.on(
        Razorpay.EVENT_PAYMENT_SUCCESS, paymentProvider.handlePaymentSuccess);
    razorpay.on(
        Razorpay.EVENT_PAYMENT_ERROR, paymentProvider.handlePaymentError);
    razorpay.on(
        Razorpay.EVENT_EXTERNAL_WALLET, paymentProvider.handleExternalWallet);
  }

  @override
  void dispose() {
    paymentProvider.razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OrderSummaryProvider>(context, listen: false)
          .getSingleCartProduct(context, widget.productId, widget.cartId);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order summary'),
      ),
      body: Consumer3<AddressProvider, OrderSummaryProvider, CartProvider>(
        builder: (context, value, order, cart, child) {
          return order.loading == true
              ? const LoadingWidget()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      CSizedBox().height10,
                      value.addressList.isEmpty
                          ? Container()
                          : AddressWidget(
                              name:
                                  value.addressList[value.selectIndex].fullName,
                              title: value.addressList[value.selectIndex].title,
                              address:
                                  '''${value.addressList[value.selectIndex].address},
${value.addressList[value.selectIndex].state} - ${value.addressList[value.selectIndex].pin}
Land Mark - ${value.addressList[value.selectIndex].landMark}
''',
                              number:
                                  value.addressList[value.selectIndex].phone,
                              onPreesed: () {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context) {
                                      return const AddressScreen();
                                    },
                                  ),
                                );
                              },
                            ),
                      CSizedBox().height10,
                      ListView.builder(
                        itemCount: widget.screenCheck ==
                                OrderSummaryScreenEnum.normalOrderSummaryScreen
                            ? cart.model!.products.length
                            : 1,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            color: whiteColor,
                            child: Row(
                              children: [
                                Container(
                                  height: 90,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    image: NetworkImage(
                                      widget.screenCheck ==
                                              OrderSummaryScreenEnum
                                                  .normalOrderSummaryScreen
                                          ? '${ApiUrl.apiUrl}/products/${cart.model!.products[index].product.image[0]}'
                                          : '${ApiUrl.apiUrl}/products/${order.product[0].product.image[0]}',
                                    ),
                                  )),
                                ),
                                CSizedBox().width10,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .7,
                                      child: Text(
                                        widget.screenCheck ==
                                                OrderSummaryScreenEnum
                                                    .normalOrderSummaryScreen
                                            ? cart.model!.products[index]
                                                .product.name
                                            : order.product[0].product.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    RatingBar.builder(
                                      ignoreGestures: true,
                                      allowHalfRating: true,
                                      onRatingUpdate: (value) {},
                                      itemBuilder: (context, hello) {
                                        return const Icon(
                                          Icons.star,
                                          color:
                                              Color.fromARGB(255, 24, 110, 29),
                                        );
                                      },
                                      itemSize: 16,
                                      initialRating: double.parse(
                                        widget.screenCheck ==
                                                OrderSummaryScreenEnum
                                                    .normalOrderSummaryScreen
                                            ? cart.model!.products[index]
                                                .product.rating
                                            : order.product[0].product.rating,
                                      ),
                                    ),
                                    CSizedBox().height5,
                                    Row(
                                      children: [
                                        Text(
                                          widget.screenCheck ==
                                                  OrderSummaryScreenEnum
                                                      .normalOrderSummaryScreen
                                              ? "${cart.model!.products[index].product.offer}%off"
                                              : "${order.product[0].product.offer}%off",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: offerColor,
                                          ),
                                        ),
                                        CSizedBox().width10,
                                        Text(
                                          widget.screenCheck ==
                                                  OrderSummaryScreenEnum
                                                      .normalOrderSummaryScreen
                                              ? "₹${cart.model!.products[index].product.price}"
                                              : "${order.product[0].product.price}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: greyColor,
                                          ),
                                        ),
                                        CSizedBox().width10,
                                        Text(
                                          widget.screenCheck ==
                                                  OrderSummaryScreenEnum
                                                      .normalOrderSummaryScreen
                                              ? "₹${(cart.model!.products[index].product.price - cart.model!.products[index].product.discountPrice).round()}"
                                              : "₹${(order.product[0].product.price - order.product[0].product.discountPrice).round()}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.clip,
                                          ),
                                        ),
                                      ],
                                    ),
                                    CSizedBox().height10,
                                    widget.screenCheck ==
                                            OrderSummaryScreenEnum
                                                .normalOrderSummaryScreen
                                        ? Text(
                                            '${cart.model!.products[index].qty} Item',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: greyColor,
                                            ),
                                          )
                                        : const SizedBox()
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      CSizedBox().height10,
                      Container(
                        color: whiteColor,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Price Details",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            CSizedBox().height20,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Price',
                                ),
                                Text(
                                  widget.screenCheck ==
                                          OrderSummaryScreenEnum
                                              .normalOrderSummaryScreen
                                      ? "₹${cart.model!.totalPrice}"
                                      : "₹${order.product[0].product.price}",
                                ),
                              ],
                            ),
                            CSizedBox().height10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Discount Price',
                                ),
                                Text(
                                  widget.screenCheck ==
                                          OrderSummaryScreenEnum
                                              .normalOrderSummaryScreen
                                      ? "₹${cart.model!.totalDiscount.toStringAsFixed(0)}"
                                      : "₹${order.product[0].product.discountPrice.toStringAsFixed(0)}",
                                ),
                              ],
                            ),
                            CSizedBox().height10,
                            const Divider(
                              thickness: .6,
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total Amout',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.screenCheck ==
                                          OrderSummaryScreenEnum
                                              .normalOrderSummaryScreen
                                      ? "₹${(cart.model!.totalPrice - cart.model!.totalDiscount).round()}"
                                      : "₹${(order.product[0].product.price - order.product[0].product.discountPrice).round()}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              height: 20,
                              thickness: .6,
                            ),
                            Text(
                              widget.screenCheck ==
                                      OrderSummaryScreenEnum
                                          .normalOrderSummaryScreen
                                  ? 'You will save ₹${cart.model!.totalDiscount.toStringAsFixed(0)} on this order'
                                  : 'You will save ₹${order.product[0].product.discountPrice.toStringAsFixed(0)} on this order',
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CSizedBox().height20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.verified_user,
                            size: 30,
                            color: Colors.grey.shade600,
                          ),
                          CSizedBox().width10,
                          const Text(
                            '''Safe and secure payment. Easy returns.
           100% Authentic products.''',
                          ),
                        ],
                      ),
                      CSizedBox().height20,
                    ],
                  ),
                );
        },
      ),
      bottomNavigationBar: Consumer2<OrderSummaryProvider, CartProvider>(
        builder: (context, value, cart, child) {
          return value.loading == true
              ? const LoadingWidget()
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
                    title: value.loading == true
                        ? const LoadingWidget()
                        : Text(
                            widget.screenCheck ==
                                    OrderSummaryScreenEnum
                                        .normalOrderSummaryScreen
                                ? "₹${cart.model!.totalPrice}"
                                : "₹${value.product[0].price}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: greyColor,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                    subtitle: Text(
                      widget.screenCheck ==
                              OrderSummaryScreenEnum.normalOrderSummaryScreen
                          ? "₹${(cart.model!.totalPrice - cart.model!.totalDiscount).round()}"
                          : "₹${(value.product[0].product.price - value.product[0].product.discountPrice).round()}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: priceColor,
                      ),
                    ),
                    trailing: SizedBox(
                      width: 200,
                      child: Consumer2<AddressProvider, PaymentProvider>(
                        builder: (context, address, payment, child) {
                          return address.addressList.isEmpty
                              ? OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: themeColor,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(CupertinoPageRoute(
                                      builder: (context) {
                                        return const AddressScreen();
                                      },
                                    ));
                                  },
                                  child: const Text(
                                    'Add address',
                                  ),
                                )
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: themeColor,
                                  ),
                                  onPressed: () {
                                    paymentProvider.openCheckout(
                                      widget.screenCheck ==
                                              OrderSummaryScreenEnum
                                                  .normalOrderSummaryScreen
                                          ? int.parse((cart.model!.totalPrice -
                                                  cart.model!.totalDiscount)
                                              .round()
                                              .toString())
                                          : int.parse((value.product[0].price -
                                                  value
                                                      .product[0].discountPrice)
                                              .round()
                                              .toString()),
                                      context,
                                    );
                                    // paymentProvider.openCheckout(
                                    // widget.screenCheck ==
                                    //         OrderSummaryScreenEnum
                                    //             .normalOrderSummaryScreen
                                    //     ? int.parse((cart
                                    //                 .model!.totalPrice -
                                    //             cart.model!.totalDiscount)
                                    //         .round()
                                    //         .toString())
                                    //     : int.parse(
                                    //         (value.product[0].price -
                                    //                 value.product[0]
                                    //                     .discountPrice)
                                    //             .round()
                                    //             .toString()),
                                    // address.addressList[address.selectIndex]
                                    //     .id,
                                    //     '',
                                    // widget.screenCheck ==
                                    //         OrderSummaryScreenEnum
                                    //             .normalOrderSummaryScreen
                                    //     ? cart.model!.products[0].id
                                    //     : value.product[0].id,
                                    //     context);
                                  },
                                  child: Text(
                                    widget.screenCheck ==
                                            OrderSummaryScreenEnum
                                                .normalOrderSummaryScreen
                                        ? 'CONTINUE (${cart.totalProductCount})'
                                        : 'CONTINUE',
                                  ),
                                );
                        },
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
