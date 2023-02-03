import 'package:ecommerce/common/constants/api_url.dart';
import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/controller/order/order_provider.dart';
import 'package:ecommerce/view/profile/order/order_produt_view/widgets/order_canceld_status_widget.dart';
import 'package:ecommerce/view/profile/order/order_produt_view/widgets/order_sucsses_status_widget.dart';
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
            return value.loading == true || value.singleModel == null
                ? const LoadingWidget()
                : Column(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        value.singleModel!.products[index1]
                                            .product.name,
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
                                  ?  OrderCanceldStatusWidget(index: index1)
                                  :  OrderSucssesStatusWidget(index: index1),
                              const Divider(),
                              Consumer<OrderProvider>(
                                builder: (context, value, child) {
                                  return value.singleModel!.orderStatus ==
                                          'CANCELED'
                                      ? Center(
                                          child: TextButton.icon(
                                            style: TextButton.styleFrom(
                                              foregroundColor:
                                                  Colors.grey.shade600,
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
                                          ),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextButton(
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
                                            const VerticalDivider(
                                                endIndent: 20),
                                            TextButton.icon(
                                              style: TextButton.styleFrom(
                                                foregroundColor:
                                                    Colors.grey.shade600,
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
          },
        ),
      ),
    );
  }
}
