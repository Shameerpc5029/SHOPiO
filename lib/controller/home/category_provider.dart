import 'package:ecommerce/model/home_model/category_model.dart';
import 'package:ecommerce/services/home_service/category_service.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  CategoryProvider(context) {
    getCategory(context);
  }
  bool isLoading = false;
  List<CategoryModel> categoryList = [];
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
}
