import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/controller/address/address_provider.dart';
import 'package:ecommerce/controller/home/home_provider.dart';
import 'package:ecommerce/controller/payment/payment_provider.dart';
import 'package:ecommerce/view/cart/widgets/count_button.dart';
import 'package:ecommerce/view/order/widgets/address_widget.dart';
import 'package:ecommerce/view/profile/address/address_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class OrderSummaryScreen extends StatefulWidget {
  const OrderSummaryScreen({super.key});
  static const routeName = 'orders_page';

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
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final provider = Provider.of<HomeProvider>(context).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order summary'),
      ),
      body: Consumer<AddressProvider>(
        builder: (context, value, child) {
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
                  itemCount: 1,
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
                              image: NetworkImage(
                                '${ApiUrl.apiUrl}/products/${provider.image[0]}',
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
                                  provider.name,
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
                                initialRating: double.parse(provider.rating),
                              ),
                              CSizedBox().height5,
                              Row(
                                children: [
                                  Text(
                                    "${provider.offer}%off",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: offerColor,
                                    ),
                                  ),
                                  CSizedBox().width10,
                                  Text(
                                    "₹${provider.price}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.lineThrough,
                                      color: greyColor,
                                    ),
                                  ),
                                  CSizedBox().width10,
                                  Text(
                                    "₹${(provider.price - provider.discountPrice).round()}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.clip),
                                  ),
                                ],
                              ),
                              CSizedBox().height10,
                              CountButton(
                                countNumber: '1',
                                minusPressed: () {},
                                plusPressed: () {},
                              ),
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
                            "₹${provider.price}",
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
                            "₹${provider.discountPrice.toStringAsFixed(0)}",
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
                            "₹${(provider.price - provider.discountPrice).round()}",
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
                        'You will save ₹${provider.discountPrice.toStringAsFixed(0)} on this order',
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
            "₹${provider.price}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: greyColor,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          subtitle: Text(
            "₹${(provider.price - provider.discountPrice).round()}",
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
                          paymentProvider.openCheckout(
                            int.parse((provider.price - provider.discountPrice)
                                .round()
                                .toString()),
                          );
                        },
                        child: const Text(
                          'CONTINUE',
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
