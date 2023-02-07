import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/model/cart_model/add_to_cart.dart';
import 'package:ecommerce/model/cart_model/get_form_cart_model.dart';
import 'package:ecommerce/services/cart_service/cart_service.dart';
import 'package:ecommerce/utils/exceptions/dio_exceptions.dart';
import 'package:ecommerce/view/product_view/product_view.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  CartProvider() {
    getCart();
  }

  String size = "5 inch";
  int quantity = 1;
  bool isLoading = false;
  CartModel? model;
  int? totalSave;
  int totalProductCount = 1;
  List<String> cartList = [];
  List<String> cartItemsId = [];
  List<String> cartitemsPayId = [];

  void getCart() async {
    isLoading = true;
    notifyListeners();
    await CartService().getCart().then(
      (value) {
        if (value != null) {
          model = value;
          notifyListeners();
          isLoading = false;
          cartItemsId = model!.products.map((e) => e.product.id).toList();
          notifyListeners();
          cartitemsPayId = model!.products.map((e) => e.id).toList();
          notifyListeners();
          cartList = model!.products.map((e) => e.product.id).toList();
          notifyListeners();
          totalSave = (model!.totalPrice - model!.totalDiscount).toInt();
          totalProductsCount();
          notifyListeners();
        } else {
          isLoading = false;
          notifyListeners();
          return null;
        }
      },
    );
    notifyListeners();
    return null;
  }

  void addToCart(String productId, context) async {
    isLoading = true;
    notifyListeners();
    final AddToCartModel model = AddToCartModel(
      size: size,
      quantity: quantity,
      productId: productId,
    );
    await CartService().addToCart(model).then((value) {
      if (value != null) {
        getCart();
      }
      if (value == "product added to cart successfully") {
        PopUpSnackBar.popUp(
          context,
          'product added to cart successfully',
          Colors.green,
        );

        notifyListeners();
      } else {
        null;
      }
    });
  }

  void pop(context) {
    Navigator.pop(context);
    notifyListeners();
  }

  void removeFromCart(context, String productId) {
    CartService().removeFromCart(productId).then((value) {
      if (value != null) {
        getCart();
        PopUpSnackBar.popUp(context, 'Product removed from cart Successfully',
            AppColor().alertColor);
        pop(context);
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
      await CartService().addToCart(addToCartModel).then((value) async {
        if (value != null) {
          await CartService().getCartItems().then((value) {
            if (value != null) {
              model = value;
              notifyListeners();
              totalProductsCount();
              notifyListeners();
              cartList = model!.products.map((e) => e.product.id).toList();
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

  void cartToProductView(context, index) {
    Navigator.of(context).pushNamed(
      ProductView.routeName,
      arguments: model!.products[index].product.id,
    );
  }
}
