import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/controller/address/address_provider.dart';
import 'package:ecommerce/view/cart/widgets/count_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class OrderSummaryScreen extends StatelessWidget {
  const OrderSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                Container(
                  color: whiteColor,
                  padding: const EdgeInsets.all(
                    10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Deliver to:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: themeColor,
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Change',
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            value.addressList[0].fullName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          CSizedBox().width10,
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: Text(
                                value.addressList[0].title,
                                style: const TextStyle(
                                  color: Color.fromARGB(83, 0, 0, 0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      CSizedBox().height10,
                      Text(
                        '''${value.addressList[0].address},
${value.addressList[0].state} - ${value.addressList[0].pin}
Land Mark - ${value.addressList[0].landMark}
''',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        value.addressList[0].phone,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      CSizedBox().height5,
                    ],
                  ),
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
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                              image: NetworkImage(
                                'https://static.s-sfr.fr/media/catalogue/article/mobile/o058stkg/iPhone14ProMax_VioletProfond_Front-Side_400x540px.png',
                              ),
                            )),
                          ),
                          CSizedBox().width10,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'IPHONE 14 PRO MAX',
                                style: TextStyle(
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
                                initialRating: 4,
                              ),
                              CSizedBox().height5,
                              Row(
                                children: [
                                  const Text(
                                    "20%off",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: offerColor,
                                    ),
                                  ),
                                  CSizedBox().width10,
                                  const Text(
                                    '₹179999',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.lineThrough,
                                      color: greyColor,
                                    ),
                                  ),
                                  CSizedBox().width10,
                                  const Text(
                                    '₹79999',
                                    style: TextStyle(
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
                        children: const [
                          Text(
                            'Price',
                          ),
                          Text(
                            '₹179999',
                          ),
                        ],
                      ),
                      CSizedBox().height10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Discount Price',
                          ),
                          Text(
                            '₹10000',
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: .6,
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Total Amout',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '₹79999',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 20,
                        thickness: .6,
                      ),
                      const Text(
                        'You will save ₹10000 on this order',
                        style: TextStyle(
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
          title: const Text(
            "₹17999",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: greyColor,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          subtitle: Text(
            "₹79999",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: priceColor,
            ),
          ),
          trailing: SizedBox(
            width: 200,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: themeColor,
              ),
              onPressed: () {},
              child: const Text(
                'CONTINUE (4 items)',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
