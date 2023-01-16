class ProductModel {
  final String id;
  final String name;
  final int price;
  final dynamic discountPrice;
  final int offer;
  final List<String> size;
  final List<String> image;
  final String category;
  final String rating;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.discountPrice,
    required this.offer,
    required this.size,
    required this.image,
    required this.category,
    required this.rating,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['_id'],
        name: json['name'],
        price: json['price'],
        discountPrice: json['discountPrice'],
        offer: json['offer'],
        size: List<String>.from(json['size'].map((x) => x)),
        image: List<String>.from(json['image'].map((x) => x)),
        category: json['category'],
        rating: json['rating']);
  }
}

// class ProductModel {
//   ProductModel({
//     required this.details,
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.discountPrice,
//     required this.offer,
//     required this.size,
//     required this.image,
//     required this.category,
//     required this.rating,
//     required this.deliveryFee,
//     required this.description,
//   });

//   Details details;
//   String id;
//   String name;
//   int price;
//   dynamic discountPrice;
//   int offer;
//   List<String> size;
//   List<String> image;
//   String category;
//   String rating;
//   String deliveryFee;
//   String description;

//   factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
//         details: Details.fromJson(json["details"]),
//         id: json["_id"],
//         name: json["name"],
//         price: json["price"],
//         discountPrice: json["discountPrice"],
//         offer: json["offer"],
//         size: List<String>.from(json["size"].map((x) => x)),
//         image: List<String>.from(json["image"].map((x) => x)),
//         category: json["category"],
//         rating: json["rating"],
//         deliveryFee: json["deliveryFee"],
//         description: json["description"],
//       );
// }

// class Details {
//   Details({
//     required this.ram,
//     required this.processor,
//     required this.frontCam,
//     required this.rearCam,
//     required this.display,
//     required this.battery,
//   });

//   String ram;
//   String processor;
//   String frontCam;
//   String rearCam;
//   String display;
//   String battery;

//   factory Details.fromJson(Map<String, dynamic> json) => Details(
//         ram: json["ram"],
//         processor: json["processor"],
//         frontCam: json["frontCam"],
//         rearCam: json["rearCam"],
//         display: json["display"],
//         battery: json["battery"],
//       );

//   Map<String, dynamic> toJson() => {
//         "ram": ram,
//         "processor": processor,
//         "frontCam": frontCam,
//         "rearCam": rearCam,
//         "display": display,
//         "battery": battery,
//       };
// }
