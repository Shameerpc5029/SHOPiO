import 'package:ecommerce/model/order_summery_enum/order_summery_enum.dart';

class OrderSummaryArguementModel {
  final OrderSummaryScreenEnum screenCheck;
  final String? productId;
  final String? cartId;
  OrderSummaryArguementModel({
    required this.screenCheck,
    this.productId,
    this.cartId,
  });
}
