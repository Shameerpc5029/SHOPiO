import 'package:ecommerce/model/home_model/product_model.dart';

class CartModel {
  CartModel({
    required this.id,
    required this.userid,
    required this.products,
    required this.totalPrice,
    required this.totalDiscount,
    required this.v,
  });

  String id;
  String userid;
  List<ProductElement> products;
  int totalPrice;
  int totalDiscount;
  int v;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["_id"],
        userid: json["userid"],
        products: List<ProductElement>.from(
            json["products"].map((x) => ProductElement.fromJson(x))),
        totalPrice: json["totalPrice"],
        totalDiscount: json["totalDiscount"],
        v: json["__v"],
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
  int discountPrice;
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