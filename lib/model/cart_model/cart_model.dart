import 'package:ecommerce/model/home_model/product_model.dart';

class CartModel {
  CartModel({
    required this.id,
    required this.userid,
    required this.products,
  });

  String id;
  String userid;
  List<ProductElement> products;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["_id"],
        userid: json["userid"],
        products: List<ProductElement>.from(
            json["products"].map((x) => ProductElement.fromJson(x))),
      );
}

class ProductElement {
  ProductElement({
    required this.product,
    required this.size,
    required this.qty,
    required this.price,
    required this.discountPrice,
    required this.id,
  });

  ProductModel product;
  String size;
  int qty;
  int price;
  dynamic discountPrice;
  String id;

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
        product: ProductModel.fromJson(json["product"]),
        size: json["size"],
        qty: json["qty"],
        price: json["price"],
        discountPrice: json["discountPrice"],
        id: json["_id"],
      );
}
