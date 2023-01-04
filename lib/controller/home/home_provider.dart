import 'package:ecommerce/model/home_model/category_model.dart';
import 'package:ecommerce/model/home_model/product_model.dart';
import 'package:ecommerce/services/home_service/carousal_service.dart';
import 'package:ecommerce/services/home_service/category_service.dart';
import 'package:ecommerce/services/home_service/product_service.dart';
import 'package:ecommerce/view/home/product_view/product_view.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider(context) {
    allProviders(context);
  }

  void allProviders(context) {
    getCarousals(context);
    getCategory(context);
    getProducts(context);
  }

  bool isLoading = false;
  List<CategoryModel> categoryList = [];
  List<ProductModel> productList = [];
  List carousalList = [];
  int activeIndex = 0;
  void getCategory(context) async {
    isLoading = true;
    notifyListeners();
    await CategoryService().getCategories(context).then((value) {
      if (value != null) {
        categoryList = value;
        notifyListeners();
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
        return null;
      }
    });
  }

  void carosal(index) {
    activeIndex = index;
    notifyListeners();
  }

  void productViewSlider(index) {
    activeIndex = index;
    notifyListeners();
  }

  void getCarousals(context) async {
    isLoading = true;
    notifyListeners();
    await CarousalService().getCarousals(context).then((value) {
      if (value != null) {
        carousalList = value;
        notifyListeners();
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
        return null;
      }
    });
  }

  void getProducts(context) async {
    isLoading = true;
    notifyListeners();
    await ProductService().getAllProduct(context).then((value) {
      if (value != null) {
        productList = value;
        notifyListeners();
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  ProductModel findById(String id) {
    return productList.firstWhere((element) => element.id == id);
  }

  void goToProdutScreen(context, index) {
    Navigator.of(context).pushNamed(
      ProductView.routeName,
      arguments: productList[index].id,
    );
  }

  List<ProductModel> findByCategoryId(String categoryId) {
    return productList.where((element) {
      return element.category.contains(categoryId);
    }).toList();
  }

  void goToPop(context) {
    Navigator.of(context).pop();
    activeIndex = 0;
    notifyListeners();
  }
}
