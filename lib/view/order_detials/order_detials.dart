import 'package:ecommerce/view/widgets/navigator_key.dart';
import 'package:flutter/material.dart';

class OrderDetials extends StatelessWidget {
  const OrderDetials({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      NavigationService.navigatorKey.currentContext;
    });
    return const Scaffold(
      body: Center(child: Text('order')),
    );
  }
}

class CancelOrder extends StatelessWidget {
  const CancelOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('cancel')),
    );
  }
}
