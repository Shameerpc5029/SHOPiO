import 'package:ecommerce/model/cart_model/get_single_cart_model.dart';
import 'package:ecommerce/model/order_summery_enum/order_summery_enum.dart';
import 'package:ecommerce/services/cart_service/cart_service.dart';
import 'package:flutter/cupertino.dart';

class OrderSummaryProvider with ChangeNotifier {
  OrderSummaryProvider() {
    startLoading();
  }

  bool loading = false;
  List<GetSingelCartProduct> product = [];
  int? totalSave;
  List<String> productIds = [];

  // void toPaymentScreen(context, String itemCount, String totalAmount,
  //     List<String> productIds, String addressId) {
  //   final args = PaymentScreenArguementModel(
  //       itemCount: itemCount,
  //       totalAmount: totalAmount,
  //       productIds: productIds,
  //       addressId: addressId);
  //   Navigator.of(context).pushNamed(RouteNames.paymentScreen, arguments: args);
  // }

  void startLoading() {
    loading = true;
    notifyListeners();
  }

  // void getSingleAddress(String addressId) async {
  //   await AddressService().getSingleAddress(context, addressId).then((value) {
  //     if (value != null) {
  //       address = value;
  //       notifyListeners();
  //       loading = false;
  //       notifyListeners();
  //     } else {
  //       loading = false;
  //       notifyListeners();
  //     }
  //   });
  // }

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
      String productId, String cartId, BuildContext context) async {
    await CartService().getSingleCart(context, productId, cartId).then((value) {
      if (value != null) {
        product = value;
        notifyListeners();
        totalSave = product[0].discountPrice.toInt() - product[0].price.toInt();
        notifyListeners();
      } else {
        loading = false;
        notifyListeners();
      }
    });
  }
}
