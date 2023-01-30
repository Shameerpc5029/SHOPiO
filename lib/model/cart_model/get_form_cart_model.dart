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
  double totalDiscount;
  int v;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["_id"],
        userid: json["userid"],
        products: List<ProductElement>.from(
            json["products"].map((x) => ProductElement.fromJson(x))),
        totalPrice: json["totalPrice"],
        totalDiscount: json["totalDiscount"]?.toDouble(),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userid": userid,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "totalPrice": totalPrice,
        "totalDiscount": totalDiscount,
        "__v": v,
      };
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

  ProductProduct product;
  String size;
  int qty;
  int price;
  double discountPrice;
  String id;

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
        product: ProductProduct.fromJson(json["product"]),
        size: json["size"],
        qty: json["qty"],
        price: json["price"],
        discountPrice: json["discountPrice"]?.toDouble(),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "product": product.toJson(),
        "size": size,
        "qty": qty,
        "price": price,
        "discountPrice": discountPrice,
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
  double discountPrice;
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
        discountPrice: json["discountPrice"]?.toDouble(),
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





// class CartModel {
//   CartModel({
//     required this.id,
//     required this.products,
//     required this.totalPrice,
//     required this.totalDiscount,
//   });

//   String id;
//   List<ProductElement> products;
//   int totalPrice;
//   dynamic totalDiscount;

//   factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
//         id: json["_id"],
//         products: List<ProductElement>.from(
//             json["products"].map((x) => ProductElement.fromJson(x))),
//         totalPrice: json["totalPrice"],
//         totalDiscount: json["totalDiscount"],
//       );
// }

// class ProductElement {
//   ProductElement({
//     required this.product,
//     required this.size,
//     required this.qty,
//     required this.price,
//     required this.discountPrice,
//     required this.id,
//   });

//   Product product;
//   String size;
//   int qty;
//   int price;
//   dynamic discountPrice;
//   String id;

//   factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
//         product: Product.fromJson(json["product"]),
//         size: json["size"],
//         qty: json["qty"],
//         price: json["price"],
//         discountPrice: json["discountPrice"],
//         id: json["_id"],
//       );
// }

// class Product {
//   Product({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.discountPrice,
//     required this.offer,
//     required this.rating,
//     required this.size,
//     required this.image,
//   });

//   String id;
//   String name;
//   int price;
//   dynamic discountPrice;
//   int offer;
//   String rating;
//   List<String> size;
//   List<String> image;

//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//         id: json["_id"],
//         name: json["name"],
//         price: json["price"],
//         discountPrice: json["discountPrice"],
//         offer: json["offer"],
//         rating: json["rating"],
//         size: List<String>.from(json["size"].map((x) => x)),
//         image: List<String>.from(json["image"].map((x) => x)),
//       );
// }
