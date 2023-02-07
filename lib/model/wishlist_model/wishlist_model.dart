// import 'package:ecommerce/model/home_model/product_model.dart';

// class WishListModel {
//   WishListModel({
//     required this.id,
//     required this.userId,
//     required this.products,
//     required this.v,
//   });

//   String id;
//   String userId;
//   List<ProductElement> products;
//   int v;

//   factory WishListModel.fromJson(Map<String, dynamic> json) => WishListModel(
//         id: json["_id"],
//         userId: json["userId"],
//         products: List<ProductElement>.from(
//             json["products"].map((x) => ProductElement.fromJson(x))),
//         v: json["__v"],
//       );
// }

// class ProductElement {
//   ProductElement({
//     required this.product,
//     required this.id,
//   });

//   ProductModel product;
//   String id;

//   factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
//         product: ProductModel.fromJson(json["product"]),
//         id: json["_id"],
//       );
// }
// To parse this JSON data, do
//
//     final wishlistModel = wishlistModelFromJson(jsonString);

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

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "__v": v,
      };
}

class ProductElement {
  ProductElement({
    required this.product,
    required this.id,
  });

  ProductProduct product;
  String id;

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
        product: ProductProduct.fromJson(json["product"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "product": product.toJson(),
        "_id": id,
      };
}

class ProductProduct {
  ProductProduct({
    required this.details,
    required this.id,
    required this.name,
    required this.price,
    required this.discountPrice,
    required this.offer,
    required this.size,
    required this.image,
    required this.category,
    required this.rating,
    required this.deliveryFee,
    required this.description,
    required this.v,
  });

  Details details;
  String id;
  String name;
  int price;
  int discountPrice;
  int offer;
  List<String> size;
  List<String> image;
  String category;
  String rating;
  String deliveryFee;
  String description;
  int v;

  factory ProductProduct.fromJson(Map<String, dynamic> json) => ProductProduct(
        details: Details.fromJson(json["details"]),
        id: json["_id"],
        name: json["name"],
        price: json["price"],
        discountPrice: json["discountPrice"],
        offer: json["offer"],
        size: List<String>.from(json["size"].map((x) => x)),
        image: List<String>.from(json["image"].map((x) => x)),
        category: json["category"],
        rating: json["rating"],
        deliveryFee: json["deliveryFee"],
        description: json["description"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "details": details.toJson(),
        "_id": id,
        "name": name,
        "price": price,
        "discountPrice": discountPrice,
        "offer": offer,
        "size": List<dynamic>.from(size.map((x) => x)),
        "image": List<dynamic>.from(image.map((x) => x)),
        "category": category,
        "rating": rating,
        "deliveryFee": deliveryFee,
        "description": description,
        "__v": v,
      };
}

class Details {
  Details({
    required this.ram,
    required this.processor,
    required this.frontCam,
    required this.rearCam,
    required this.display,
    required this.battery,
  });

  String ram;
  String processor;
  String frontCam;
  String rearCam;
  String display;
  String battery;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        ram: json["ram"],
        processor: json["processor"],
        frontCam: json["frontCam"],
        rearCam: json["rearCam"],
        display: json["display"],
        battery: json["battery"],
      );

  Map<String, dynamic> toJson() => {
        "ram": ram,
        "processor": processor,
        "frontCam": frontCam,
        "rearCam": rearCam,
        "display": display,
        "battery": battery,
      };
}
