import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/model/cart_model/cart_model.dart';

import 'package:ecommerce/services/cart_service/cart_service.dart';

import 'package:ecommerce/utils/exceptions/dio_exceptions.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  CartProvider(context) {
    getCart(context);
  }
  bool isLoading = false;
  CartModel? model;
  List<dynamic> wishlist = [];
  void getCart(context) async {
    isLoading = true;
    notifyListeners();
    await CartService().getCartList(context).then(
      (value) {
        if (value != null) {
          model = value;
          notifyListeners();
          isLoading = false;
          wishlist = model!.products.map((e) => e.product.id).toList();
          notifyListeners();
        } else {
          isLoading = false;
          notifyListeners();
          return null;
        }
      },
    );
  }

  void addAndRemoveCart(context, String productId) async {
    isLoading = true;
    notifyListeners();
    await CartService().addAndRemovecart(context, productId).then((value) {
      if (value != null) {
        CartService().getCartList(context).then((value) {
          if (value != null) {
            model = value;
            notifyListeners();
            getCart(context);
            isLoading = false;
            notifyListeners();
          } else {
            isLoading = false;
            notifyListeners();
          }
        });
        if (value == 201) {
          PopUpSnackBar.popUp(context, 'Item added to Cart', Colors.green);
        }
        if (value == 204) {
          PopUpSnackBar.popUp(context, 'Item Remove from Cart', alertColor);
        }
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }
}
