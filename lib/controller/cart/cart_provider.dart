import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/model/cart_model/add_to_cart.dart';
import 'package:ecommerce/model/cart_model/get_form_cart_model.dart';
import 'package:ecommerce/services/cart_service/cart_service.dart';
import 'package:ecommerce/utils/exceptions/dio_exceptions.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  CartProvider(context) {
    getCart(context);
  }
  String size = "5 inch";
  int quantity = 1;
  bool isLoading = false;
  CartModel? model;
  int? totalSave;
  List<String> cartItemsId = [];
  int totalProductCount = 1;
  List<dynamic> cartList = [];

  void getCart(context) async {
    isLoading = true;
    notifyListeners();
    await CartService().getCart(context).then(
      (value) {
        if (value != null) {
          model = value;
          notifyListeners();
          cartList = model!.products.map((e) => e.product.id).toList();
          totalSave = (model!.totalPrice - model!.totalDiscount).toInt();
          totalProductsCount();
          notifyListeners();
          isLoading = false;
          notifyListeners();
        } else {
          isLoading = false;
          notifyListeners();
        }
        return null;
      },
    );
  }

  void addToCart(String productId, context) async {
    isLoading = true;
    notifyListeners();
    final AddToCartModel model = AddToCartModel(
      size: size,
      quantity: quantity,
      productId: productId,
    );
    await CartService().addToCart(model, context).then((value) {
      if (value != null) {
        getCart(context);
      }
      if (value == "product added to cart successfully") {
        PopUpSnackBar.popUp(
            context, 'product added to cart successfully', Colors.green);
        notifyListeners();
      } else {
        null;
      }
    });
  }

  void removeFromCart(context, String productId) {
    CartService().removeFromCart(context, productId).then((value) {
      if (value != null) {
        getCart(context);
        PopUpSnackBar.popUp(
            context, 'Product removed from cart Successfully', alertColor);
        notifyListeners();
      } else {
        return;
      }
    });
  }

  void totalProductsCount() {
    int count = 0;
    for (var i = 0; i < model!.products.length; i++) {
      count = count + model!.products[i].qty;
    }
    totalProductCount = count;
    notifyListeners();
  }

  Future<void> incrementOrDecrementQuantity(int qty, String productId,
      String productSize, int productquantity, context) async {
    final AddToCartModel addToCartModel = AddToCartModel(
      productId: productId,
      quantity: qty,
      size: productSize.toString(),
    );
    if (qty == 1 && productquantity >= 1 || qty == -1 && productquantity > 1) {
      await CartService()
          .addToCart(addToCartModel, context)
          .then((value) async {
        if (value != null) {
          await CartService().getCartItems(context).then((value) {
            if (value != null) {
              model = value;
              notifyListeners();
              totalProductsCount();
              notifyListeners();
              cartItemsId = model!.products.map((e) => e.product.id).toList();
              notifyListeners();
              totalSave = (model!.totalPrice - model!.totalDiscount).toInt();
              notifyListeners();
            } else {
              null;
            }
          });
        } else {
          null;
        }
      });
    } else {
      null;
    }
  }
}
