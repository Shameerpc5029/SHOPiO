import 'package:ecommerce/model/cart_model/get_single_cart_model.dart';
import 'package:ecommerce/model/order_summery_enum/order_summery_enum.dart';
import 'package:ecommerce/services/cart_service/cart_service.dart';
import 'package:ecommerce/view/order/order_summary_screen.dart';
import 'package:flutter/cupertino.dart';

class OrderSummaryProvider with ChangeNotifier {
  OrderSummaryProvider() {
    startLoading();
  }

  bool loading = false;
  List<GetSingelCartProduct> product = [];
  String? totalSave;
  List<String> productIds = [];

  void startLoading() {
    loading = true;
    notifyListeners();
  }

  void toOderScreen(context, productId, cartId) {
    getSingleCartProduct(
      context,
      productId,
      cartId,
    );
    notifyListeners();
    Navigator.of(context).push(CupertinoPageRoute(
      builder: (context) {
        return OrderSummaryScreen(
          screenCheck: OrderSummaryScreenEnum.buyOneProductOrderSummaryScreen,
          cartId: cartId,
          productId: productId,
        );
      },
    ));
    notifyListeners();
  }

  Future<void> checkScreen(OrderSummaryScreenEnum screenCheck,
      String? productId, String? cartId, context) async {
    if (screenCheck == OrderSummaryScreenEnum.normalOrderSummaryScreen) {
      return;
    } else if (screenCheck ==
        OrderSummaryScreenEnum.buyOneProductOrderSummaryScreen) {
      await getSingleCartProduct(productId!, cartId!, context).then((value) {
        loading = false;
        notifyListeners();
        return;
      });
    }
  }

  Future<void> getSingleCartProduct(
      context, String productId, String cartId) async {
    await CartService().getSingleCart(context, productId, cartId).then((value) {
      if (value != null) {
        product = value;
        notifyListeners();
        loading = false;
        notifyListeners();
      } else {
        loading = false;
        notifyListeners();
      }
    });
  }
}
