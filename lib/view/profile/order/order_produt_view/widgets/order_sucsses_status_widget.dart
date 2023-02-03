import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/controller/order/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderSucssesStatusWidget extends StatelessWidget {
  const OrderSucssesStatusWidget({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, value, child) {
        final deliveryDate =
            value.formatDate(value.ordersList![index].deliveryDate.toString());
        final orderedDate = value
            .formatCancelDate(value.ordersList![index].orderDate.toString());
        return Row(
          children: [
            SizedBox(
              height: 250,
              width: 55,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 10,
                    child: Icon(
                      Icons.check,
                      size: 14,
                      color: AppColor().whiteColor,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Container(
                    height: 52,
                    width: 2,
                    color: AppColor().whiteColor,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  CircleAvatar(
                    backgroundColor:
                        value.singleModel!.orderStatus == 'shipped' ||
                                value.singleModel!.orderStatus == 'delivered'
                            ? Colors.green
                            : AppColor().whiteColor,
                    radius: 10,
                    child: Icon(
                      Icons.check,
                      size: 14,
                      color: AppColor().whiteColor,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Container(
                    height: 54,
                    width: 2,
                    color: AppColor().whiteColor,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  CircleAvatar(
                    backgroundColor:
                        value.singleModel!.orderStatus == 'delivered'
                            ? Colors.green
                            : AppColor().whiteColor,
                    radius: 10,
                    child: Icon(
                      Icons.check,
                      size: 14,
                      color: AppColor().whiteColor,
                    ),
                  ),
                ],
              ),
            ),
            CSizedBox().height20,
            SizedBox(
              height: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Order confirmed'),
                      Text(orderedDate.toString(),
                          style: const TextStyle(fontSize: 12))
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Shipped',
                        style: value.singleModel!.orderStatus == 'shipped' ||
                                value.singleModel!.orderStatus == 'delivered'
                            ? const TextStyle()
                            : const TextStyle(
                                color: Colors.black38,
                              ),
                      ),
                      Text(
                        value.singleModel!.orderStatus == 'shipped' ||
                                value.singleModel!.orderStatus == 'delivered'
                            ? deliveryDate.toString()
                            : '',
                        style: value.singleModel!.orderStatus == 'shipped' ||
                                value.singleModel!.orderStatus == 'delivered'
                            ? const TextStyle(fontSize: 12)
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order Delivered',
                          style: value.singleModel!.orderStatus == 'delivered'
                              ? const TextStyle()
                              : const TextStyle(color: Colors.black38)),
                      Text(
                        value.singleModel!.orderStatus == 'delivered'
                            ? deliveryDate.toString()
                            : '',
                        style: value.singleModel!.orderStatus == 'shipped' ||
                                value.singleModel!.orderStatus == 'delivered'
                            ? const TextStyle(fontSize: 12)
                            : const TextStyle(
                                fontSize: 12, color: Colors.black38),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
