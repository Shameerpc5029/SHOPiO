import 'package:ecommerce/model/home_model/product_model.dart';

class WishlistModel {
  WishlistModel({
    required this.id,
    required this.userId,
    required this.products,
    required this.v,
  });

  String id;
  String userId;
  List<ProductElement> products;
  int v;

  factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
        id: json["_id"],
        userId: json["userId"],
        products: List<ProductElement>.from(
            json["products"].map((x) => ProductElement.fromJson(x))),
        v: json["__v"],
      );
}

class ProductElement {
  ProductElement({
    required this.product,
    required this.id,
  });

  ProductModel product;
  String id;

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
        product: ProductModel.fromJson(json["product"]),
        id: json["_id"],
      );
}
