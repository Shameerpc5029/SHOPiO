import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/controller/order/order_provider.dart';
import 'package:ecommerce/view/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetialsView extends StatelessWidget {
  const OrderDetialsView({
    super.key,
    required this.orderId,
    required this.index1,
  });

  final String orderId;
  final int index1;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<OrderProvider>(context, listen: false)
          .getSingleOrder(orderId);
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
      ),
      body: SingleChildScrollView(
        child: Consumer<OrderProvider>(
          builder: (context, value, child) {
            if (value.loading == true || value.singleModel == null) {
              return const LoadingWidget();
            } else {
              return Column(
                children: [
                  Card(
                    color: whiteColor,
                    shape: const OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide.none,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order ID - ${value.singleModel!.id.toUpperCase()}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: greyColor,
                              fontSize: 12,
                            ),
                          ),
                          const Divider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    value.singleModel!.products[index1].product
                                        .name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  CSizedBox().height10,
                                  Text(
                                    "${value.singleModel!.products[index1].product.details.ram} GB RAM",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: greyColor,
                                    ),
                                  ),
                                  Text(
                                    "₹${(value.singleModel!.products[index1].product.price - value.singleModel!.products[index1].product.discountPrice).round()}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Image(
                                height: 80,
                                width: 100,
                                image: NetworkImage(
                                    '${ApiUrl.apiUrl}/products/${value.singleModel!.products[index1].product.image[0]}'),
                              )
                            ],
                          ),
                          const Divider(),
                          value.singleModel!.orderStatus == 'CANCELED'
                              ? Row(
                                  children: [
                                    SizedBox(
                                      height: 250,
                                      width: 55,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const CircleAvatar(
                                            backgroundColor: Colors.green,
                                            radius: 10,
                                            child: Icon(
                                              Icons.check,
                                              size: 14,
                                              color: whiteColor,
                                            ),
                                          ),
                                          CSizedBox().height20,
                                          Container(
                                            height: 52,
                                            width: 2,
                                            color: whiteColor,
                                          ),
                                          const CircleAvatar(
                                            backgroundColor: redColor,
                                            radius: 10,
                                            child: Icon(
                                              Icons.cancel,
                                              size: 14,
                                              color: whiteColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    CSizedBox().height20,
                                    SizedBox(
                                      height: 250,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text('Order confirmed'),
                                              Text(
                                                  value.singleModel!.orderDate
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 12))
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 50,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text('Order Canceled'),
                                              Text(
                                                value.singleModel!.cancelDate ??
                                                    '12',
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              : Row(
                                  children: [
                                    SizedBox(
                                      height: 250,
                                      width: 55,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const CircleAvatar(
                                            backgroundColor: Colors.green,
                                            radius: 10,
                                            child: Icon(
                                              Icons.check,
                                              size: 14,
                                              color: whiteColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Container(
                                            height: 52,
                                            width: 2,
                                            color: whiteColor,
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          CircleAvatar(
                                            backgroundColor: value.singleModel!
                                                            .orderStatus ==
                                                        'shipped' ||
                                                    value.singleModel!
                                                            .orderStatus ==
                                                        'delivered'
                                                ? Colors.green
                                                : whiteColor,
                                            radius: 10,
                                            child: const Icon(
                                              Icons.check,
                                              size: 14,
                                              color: whiteColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Container(
                                            height: 54,
                                            width: 2,
                                            color: whiteColor,
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          CircleAvatar(
                                            backgroundColor: value.singleModel!
                                                        .orderStatus ==
                                                    'delivered'
                                                ? Colors.green
                                                : whiteColor,
                                            radius: 10,
                                            child: const Icon(
                                              Icons.check,
                                              size: 14,
                                              color: whiteColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    CSizedBox().height20,
                                    SizedBox(
                                      height: 250,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text('Order confirmed'),
                                              Text(
                                                  value.singleModel!.orderDate
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 12))
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 40,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Order Shipped',
                                                style: value.singleModel!
                                                                .orderStatus ==
                                                            'shipped' ||
                                                        value.singleModel!
                                                                .orderStatus ==
                                                            'delivered'
                                                    ? const TextStyle()
                                                    : const TextStyle(
                                                        color: Colors.black38,
                                                      ),
                                              ),
                                              Text(
                                                value.singleModel!
                                                                .orderStatus ==
                                                            'shipped' ||
                                                        value.singleModel!
                                                                .orderStatus ==
                                                            'delivered'
                                                    ? value.singleModel!
                                                        .deliveryDate
                                                        .toString()
                                                    : '',
                                                style: value.singleModel!
                                                                .orderStatus ==
                                                            'shipped' ||
                                                        value.singleModel!
                                                                .orderStatus ==
                                                            'delivered'
                                                    ? const TextStyle(
                                                        fontSize: 12)
                                                    : const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black38,
                                                      ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 50,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Order Delivered',
                                                  style: value.singleModel!
                                                              .orderStatus ==
                                                          'delivered'
                                                      ? const TextStyle()
                                                      : const TextStyle(
                                                          color:
                                                              Colors.black38)),
                                              Text(
                                                value.singleModel!
                                                            .orderStatus ==
                                                        'delivered'
                                                    ? value.singleModel!
                                                        .deliveryDate
                                                        .toString()
                                                    : '',
                                                style: value.singleModel!
                                                                .orderStatus ==
                                                            'shipped' ||
                                                        value.singleModel!
                                                                .orderStatus ==
                                                            'delivered'
                                                    ? const TextStyle(
                                                        fontSize: 12)
                                                    : const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black38),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                          const Divider(),
                          Consumer<OrderProvider>(
                            builder: (context, value, child) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  value.singleModel!.orderStatus == 'CANCELED'
                                      ? const SizedBox()
                                      : TextButton(
                                          style: TextButton.styleFrom(
                                            foregroundColor:
                                                Colors.grey.shade600,
                                          ),
                                          onPressed: () {
                                            value.cancelOrder(orderId);
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                  const VerticalDivider(endIndent: 20),
                                  TextButton.icon(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.grey.shade600,
                                    ),
                                    onPressed: () {
                                      value.sendOrderDetials(context);
                                    },
                                    icon: const Icon(
                                      Icons.share,
                                      size: 20,
                                    ),
                                    label: const Text(
                                      'Share Order Details',
                                    ),
                                  )
                                ],
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  Consumer<OrderProvider>(
                    builder: (context, value, child) {
                      return Card(
                        color: whiteColor,
                        shape: const OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide.none,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Shopping Details",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: greyColor,
                                  fontSize: 12,
                                ),
                              ),
                              const Divider(),
                              Text(
                                value.singleModel!.fullName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                              CSizedBox().height5,
                              Text(
                                  '${value.singleModel!.address}\n${value.singleModel!.place}\n${value.singleModel!.state} - ${value.singleModel!.pin}\nPhone Number: ${value.singleModel!.phone}')
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

// class OrderStatusWidget extends StatelessWidget {
//   const OrderStatusWidget({
//     super.key,
//     required this.title,
//     required this.color,
//   });
//   final String title;
//   final Color color;

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       contentPadding: EdgeInsets.zero,
//       minLeadingWidth: 10,
//       leading: CircleAvatar(
//         radius: 14,
//         backgroundColor: color,
//       ),
//       title: Text(title),
//     );
//   }
// }
