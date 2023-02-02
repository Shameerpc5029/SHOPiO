import 'package:ecommerce/bottom_nav.dart';
import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/controller/bottom_nav/bottom_nav_provider.dart';
import 'package:ecommerce/controller/order/order_provider.dart';
import 'package:ecommerce/view/profile/order/order_produt_view/order_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<OrderProvider>(context, listen: false).getAllOrders();
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        actions: [
          Consumer<BottomNavProvider>(
            builder: (context, value, child) {
              return IconButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      CupertinoPageRoute(
                        builder: (context) => const BottomNav(),
                      ),
                      (route) => false);
                  value.currentIndex = 2;
                },
                icon: const Icon(
                  Icons.shopping_bag_outlined,
                ),
              );
            },
          )
        ],
      ),
      body: Consumer<OrderProvider>(
        builder: (context, value, child) {
          return value.ordersList!.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Your Orders is empty!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black54,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: themeColor,
                          foregroundColor: whiteColor,
                          elevation: 0,
                        ),
                        onPressed: () {
                          Navigator.pop(context);

                          Provider.of<BottomNavProvider>(context, listen: false)
                              .gotoHomescreen();
                        },
                        child: const Text('Order Now'),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: ListView.separated(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final deliveryDate = value.formatDate(
                          value.ordersList![index].deliveryDate.toString());
                      final canceledDate = value.formatCancelDate(
                          value.ordersList![index].cancelDate.toString());
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: value.ordersList![index].products.length,
                        itemBuilder: (context, index1) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) {
                                  return OrderDetialsView(
                                    orderId: value.ordersList![index].id,
                                    index1: index1,
                                  );
                                },
                              ));
                            },
                            child: Row(
                              children: [
                                Image(
                                  height: 70,
                                  width: 70,
                                  image: NetworkImage(
                                    "${ApiUrl.apiUrl}/products/${value.ordersList![index].products[index1].product.image[0]}",
                                  ),
                                ),
                                CSizedBox().width10,
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .7,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        value.ordersList![index]
                                            .products[index1].product.name,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                      Text(
                                        value.ordersList![index1].orderStatus ==
                                                'CANCELED'
                                            ? 'Delivery Canceled on $canceledDate'
                                            : value.ordersList![index1]
                                                        .orderStatus ==
                                                    'delivered'
                                                ? 'Delivered on $deliveryDate'
                                                : 'Delivery on $deliveryDate',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: value.ordersList?.length ?? 0,
                  ),
                );
        },
      ),
    );
  }
}
