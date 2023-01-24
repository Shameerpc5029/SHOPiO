class ProductModel {
  ProductModel({
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
  String id;
  String name;
  int price;
  dynamic discountPrice;
  int offer;
  List<String> size;
  List<String> image;
  String category;
  String rating;
  Details details;
  String deliveryFee;
  String description;
  int v;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
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
}

class Details {
  Details({
    this.ram,
    this.processor,
    this.frontCam,
    this.rearCam,
    this.display,
    this.battery,
  });

  String? ram;
  String? processor;
  String? frontCam;
  String? rearCam;
  String? display;
  String? battery;

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
