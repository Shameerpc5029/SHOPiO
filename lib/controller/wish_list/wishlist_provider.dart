import 'package:ecommerce/common/style/colors.dart';
import 'package:ecommerce/model/wishlist_model/wishlist_model.dart';
import 'package:ecommerce/services/wishlist_service/wishlist_service.dart';
import 'package:ecommerce/utils/exceptions/dio_exceptions.dart';
import 'package:ecommerce/view/product_view/product_view.dart';
import 'package:flutter/material.dart';

class WishListProvider extends ChangeNotifier {
  WishListProvider() {
    getWishList();
  }

  bool isLoading = false;
  WishListModel? model;
  List<dynamic> wishlist = [];
  void getWishList() async {
    isLoading = true;
    notifyListeners();
    await WishListService().getWishList().then(
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

  void addAndRemoveWishList(context, String productId) async {
    isLoading = true;
    notifyListeners();
    await WishListService().addAndRemoveWishList(productId).then((value) {
      if (value != null) {
        WishListService().getWishList().then((value) {
          if (value != null) {
            model = value;
            notifyListeners();
            getWishList();
            isLoading = false;
            notifyListeners();
          } else {
            isLoading = false;
            notifyListeners();
          }
        });
        if (value == 201) {
          PopUpSnackBar.popUp(context, 'Item added to Wishlist', Colors.green);
        }
        if (value == 204) {
          PopUpSnackBar.popUp(context, 'Item Remove from Wishlist', alertColor);
        }
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  void wishListToProduct(context, index) {
    Navigator.of(context).pushNamed(
      ProductView.routeName,
      arguments: model!.products[index].product.id,
    );
  }
}
