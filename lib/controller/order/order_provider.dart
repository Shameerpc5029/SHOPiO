import 'package:ecommerce/model/order_model/get_order_model.dart';
import 'package:ecommerce/services/order_service/order_service.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class OrderProvider extends ChangeNotifier {
  OrderProvider() {
    getAllOrders();
  }
  List<GetOrderModel>? ordersList = [];
  bool loading = false;
  GetOrderModel? singleModel;
  String? deliveryDate;

  void getAllOrders() async {
    await OrderService().getAllOrders().then((value) {
      if (value != null) {
        ordersList = value;
        notifyListeners();
        loading = false;
        notifyListeners();
      } else {
        loading = false;
        notifyListeners();
      }
    });
  }

  Future<void> cancelOrder(String orderId) async {
    loading = true;
    notifyListeners();

    await OrderService().cancelOrder(orderId).then((value) {
      if (value != null) {
        loading = false;
        notifyListeners();
      } else {
        loading = false;
        notifyListeners();
      }
    });
  }

  void getSingleOrder(String orderId) async {
    await OrderService().getSingleOrders(orderId).then((value) {
      if (value != null) {
        singleModel = value;
        notifyListeners();
        deliveryDate = formatDate(singleModel!.deliveryDate.toString());
        notifyListeners();
        loading = false;
        notifyListeners();
      } else {
        loading = false;
        notifyListeners();
      }
    });
  }

  void sendOrderDetials(context) {
    Share.share(
      'SHOPiO MOBILES\nOrder Id:${singleModel!.id}\nTotal Products:${singleModel!.products.length}\nTotal Price:${singleModel!.totalPrice}\nDelivery Date:$deliveryDate',
    );
  }

  String? formatDate(String date) {
    final a = date.split(' ');
    return a[0];
  }

  String? formatCancelDate(String? date) {
    if (date != null) {
      final a = date.split('T');
      return a[0];
    } else {
      return null;
    }
  }
}
