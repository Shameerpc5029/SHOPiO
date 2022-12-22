class CarousalModel {
  final String image;
  // final String offer;
  final String id;

  CarousalModel({
    required this.image,
    // required this.offer,
    required this.id,
  });
  factory CarousalModel.fromJson(Map<String, dynamic> json) {
    return CarousalModel(
      image: json['image'],
      // offer: json['offer'],
      id: json['_id'],
    );
  }
}
