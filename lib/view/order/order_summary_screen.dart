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
  // static const routeName = 'orders_page';

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
    final order = Provider.of<OrderSummaryProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      order.getSingleCartProduct(context, widget.productId, widget.cartId);
    });
    final provider = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order summary'),
      ),
      body: Consumer2<AddressProvider, OrderSummaryProvider>(
        builder: (context, value, order, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                CSizedBox().height10,
                value.addressList.isEmpty
                    ? Container()
                    : AddressWidget(
                        name: value.addressList[value.selectIndex].fullName,
                        title: value.addressList[value.selectIndex].title,
                        address:
                            '''${value.addressList[value.selectIndex].address},
${value.addressList[value.selectIndex].state} - ${value.addressList[value.selectIndex].pin}
Land Mark - ${value.addressList[value.selectIndex].landMark}
''',
                        number: value.addressList[value.selectIndex].phone,
                        onPreesed: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) {
                              return const AddressScreen();
                            },
                          ));
                        },
                      ),
                CSizedBox().height10,
                ListView.separated(
                  itemCount: widget.screenCheck ==
                          OrderSummaryScreenEnum.normalOrderSummaryScreen
                      ? provider.model!.products.length
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
                            width: MediaQuery.of(context).size.width * 0.2,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              // provider.cartList.length - 1
                              image: NetworkImage(
                                widget.screenCheck ==
                                        OrderSummaryScreenEnum
                                            .normalOrderSummaryScreen
                                    ? '${ApiUrl.apiUrl}/products/${provider.model!.products[index].product.image[0]}'
                                    : '${ApiUrl.apiUrl}/products/${order.product[0].product.image[0]}',
                              ),
                            )),
                          ),
                          CSizedBox().width10,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .7,
                                child: Text(
                                  widget.screenCheck ==
                                          OrderSummaryScreenEnum
                                              .normalOrderSummaryScreen
                                      ? provider
                                          .model!.products[index].product.name
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
                                    color: Color.fromARGB(255, 24, 110, 29),
                                  );
                                },
                                itemSize: 16,
                                initialRating: double.parse(
                                  widget.screenCheck ==
                                          OrderSummaryScreenEnum
                                              .normalOrderSummaryScreen
                                      ? provider
                                          .model!.products[index].product.rating
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
                                        ? "${provider.model!.products[index].product.offer}%off"
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
                                        ? "₹${provider.model!.products[index].product.price}"
                                        : "${order.product[0].product.price}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.lineThrough,
                                      color: greyColor,
                                    ),
                                  ),
                                  CSizedBox().width10,
                                  Text(
                                    widget.screenCheck ==
                                            OrderSummaryScreenEnum
                                                .normalOrderSummaryScreen
                                        ? "₹${(provider.model!.products[index].product.price - provider.model!.products[index].product.discountPrice).round()}"
                                        : "₹${(order.product[0].product.price - order.product[0].product.discountPrice).round()}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                ],
                              ),
                              CSizedBox().height10,
                              // Text("${provider.totalProductCount}")
                              // CountButton(
                              //   countNumber: '1',
                              //   minusPressed: () {},
                              //   plusPressed: () {},
                              // ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return CSizedBox().height20;
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
                                ? "₹${provider.model!.totalPrice}"
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
                                ? "₹${provider.model!.totalDiscount.toStringAsFixed(0)}"
                                : "₹${order.product[0].product.discountPrice.toStringAsFixed(0)}",
                          ),
                        ],
                      ),
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
                                ? "₹${(provider.model!.totalPrice - provider.model!.totalDiscount).round()}"
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
                                OrderSummaryScreenEnum.normalOrderSummaryScreen
                            ? 'You will save ₹${provider.model!.totalDiscount.toStringAsFixed(0)} on this order'
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
      bottomNavigationBar: Container(
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
            widget.screenCheck ==
                    OrderSummaryScreenEnum.normalOrderSummaryScreen
                ? "₹${provider.model!.totalPrice}"
                : "₹${order.product[0].price}",
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
                ? "₹${(provider.model!.totalPrice - provider.model!.totalDiscount).round()}"
                : "₹${(order.product[0].product.price - order.product[0].product.discountPrice).round()}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: priceColor,
            ),
          ),
          trailing: SizedBox(
            width: 200,
            child: Consumer<AddressProvider>(
              builder: (context, value, child) {
                return value.addressList.isEmpty
                    ? OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: themeColor,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(CupertinoPageRoute(
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
                          paymentProvider.openCheckout(widget.screenCheck ==
                                  OrderSummaryScreenEnum
                                      .normalOrderSummaryScreen
                              ? int.parse((provider.model!.totalPrice -
                                      provider.model!.totalDiscount)
                                  .round()
                                  .toString())
                              : int.parse((order.product[0].price -
                                      order.product[0].discountPrice)
                                  .round()
                                  .toString()));
                        },
                        child: Text(
                          widget.screenCheck ==
                                  OrderSummaryScreenEnum
                                      .normalOrderSummaryScreen
                              ? 'CONTINUE (${provider.totalProductCount})'
                              : 'CONTINUE',
                        ),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
