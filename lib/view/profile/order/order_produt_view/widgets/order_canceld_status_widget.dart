import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/common/style/sized_box.dart';
import 'package:ecommerce/controller/order/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderCanceldStatusWidget extends StatelessWidget {
  const OrderCanceldStatusWidget({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, value, child) {
        final canceledDate =
            value.formatDate(value.ordersList![index].cancelDate.toString());
        final orderedDate = value
            .formatCancelDate(value.ordersList![index].orderDate.toString());
        return Row(
          children: [
            SizedBox(
              height: 240,
              width: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                  Container(
                    height: 65,
                    width: 3,
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
                    height: 45,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Order Canceled'),
                      Text(
                        canceledDate ?? '12',
                        style: const TextStyle(fontSize: 12),
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
