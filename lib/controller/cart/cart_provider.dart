import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/model/cart_model/add_to_cart.dart';
import 'package:ecommerce/model/cart_model/cart_model.dart';

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

  // void addAndRemoveCart(context, String productId) async {
  //   isLoading = true;
  //   notifyListeners();
  //   await CartService().addAndRemovecart(context, productId).then((value) {
  //     if (value != null) {
  //       CartService().getCartList(context).then((value) {
  //         if (value != null) {
  //           model = value;
  //           notifyListeners();
  //           getCart(context);
  //           isLoading = false;
  //           notifyListeners();
  //         } else {
  //           isLoading = false;
  //           notifyListeners();
  //         }
  //       });
  //       if (value == 201) {
  //         PopUpSnackBar.popUp(context, 'Item added to Cart', Colors.green);
  //       }
  //       if (value == 204) {
  //         PopUpSnackBar.popUp(context, 'Item Remove from Cart', alertColor);
  //       }
  //     } else {
  //       isLoading = false;
  //       notifyListeners();
  //     }
  //   });
  // }

  // int count = 0;
  // conterplus() {
  //   count++;
  //   notifyListeners();
  // }
  // countmin(){
  //   count--;
  //   notifyListeners();
  // }
}
