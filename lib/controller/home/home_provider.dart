import 'package:ecommerce/bottom_nav.dart';
import 'package:ecommerce/controller/bottom_nav/bottom_nav_provider.dart';
import 'package:ecommerce/model/home_model/carousal_model.dart';
import 'package:ecommerce/model/home_model/category_model.dart';
import 'package:ecommerce/model/home_model/product_model.dart';
import 'package:ecommerce/services/home_service/carousal_service.dart';
import 'package:ecommerce/services/home_service/category_service.dart';
import 'package:ecommerce/services/home_service/product_service.dart';
import 'package:ecommerce/utils/debouncer.dart';
import 'package:ecommerce/view/category/category_view/category_view.dart';
import 'package:ecommerce/view/product_view/product_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    allProviders();
  }

  void allProviders() {
    getCarousals();
    getCategory();
    getProducts();
    // searchProducts('', context);
  }

  final debouncer = Debouncer(milliseconds: 200);

  bool seachSelected = false;
  bool isLoading = false;
  List<CategoryModel> categoryList = [];
  List<ProductModel> productList = [];
  List<ProductModel> searchResult = [];
  List<CarousalModel> carousalList = [];
  int activeIndex = 0;
  void loadingStart() {
    isLoading = true;
    notifyListeners();
  }

  void getCategory() async {
    isLoading = true;
    notifyListeners();
    await CategoryService().getCategories().then((value) {
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

  void getCarousals() async {
    isLoading = true;
    notifyListeners();
    await CarousalService().getCarousals().then((value) {
      if (value != null) {
        carousalList = value;
        notifyListeners();
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  void getProducts() async {
    isLoading = true;
    notifyListeners();
    await ProductService().getAllProduct().then((value) {
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
    return productList.firstWhere((element) {
      return element.id == id;
    });
  }

  void goToProdutScreen(context, index) {
    Navigator.of(context).pushNamed(
      ProductView.routeName,
      arguments: productList[index].id,
    );
  }

  List<ProductModel> findByCategoryId(String categoryId) {
    return productList.where((element) {
      return element.category.contains(
        categoryId,
      );
    }).toList();
  }

  void goToPop(context) {
    Navigator.of(context).pop();
    activeIndex = 0;
    notifyListeners();
  }

  void goToCategoryProductView(context, index) {
    Navigator.of(context).pushNamed(
      CategoryView.routeName,
      arguments: categoryList[index].id,
    );
  }

  CategoryModel categoryName(String id) {
    return categoryList.firstWhere((element) => element.id == id);
  }

  void goToCategory(context) {
    Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(
        builder: (context) => const BottomNav(),
      ),
      (route) => false,
    );
    Provider.of<BottomNavProvider>(context, listen: false).currentIndex = 2;
  }

  // Future<void> searchProducts(String text, context) async {
  //   isLoading = true;
  //   notifyListeners();
  //   await ProductService().searchProducts(text, context).then((value) {
  //     if (value != null) {
  //       productList = value;
  //       notifyListeners();
  //       isLoading = false;
  //       notifyListeners();
  //     } else {
  //       isLoading = false;
  //       notifyListeners();
  //     }
  //   });
  // }

  TextEditingController searchController = TextEditingController();
  void search(String keyboard) {
    List<ProductModel> results;
    if (keyboard.isEmpty) {
      results = productList;
    } else {
      results = productList
          .where((element) => element.name.toLowerCase().contains(
                keyboard.toLowerCase(),
              ))
          .toList();
    }

    searchResult = results;
    notifyListeners();
  }
}
