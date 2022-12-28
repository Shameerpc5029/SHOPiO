import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/view/cart/widgets/cart_custom_button.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
        ),
        body: SingleChildScrollView(
          child: ListView.separated(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Image(
                          fit: BoxFit.cover,
                          width: 80,
                          image: AssetImage(
                            'assets/images/iphone-14-pro-and-max-deep-purple-png-11662587434zacaxkb4sd.png',
                          ),
                        ),
                        CSizedBox().width10,
                        Column(
                          children: [
                            const Text(
                              "Iphone 14 pro Max",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            CSizedBox().height10,
                            Row(
                              children: [
                                const Text(
                                  "₹99999",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.lineThrough,
                                    color: greyColor,
                                  ),
                                ),
                                CSizedBox().width10,
                                const Text(
                                  "₹80000",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                CSizedBox().width10,
                                const Text(
                                  "29% off",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CartCustomButton(
                          text: "Remove",
                          icon: Icons.delete_outlined,
                          buttonColor: greyColor,
                          onPressed: () {},
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
            separatorBuilder: (BuildContext context, int index) {
              return CSizedBox().height10;
            },
          ),
        ));
  }
}
