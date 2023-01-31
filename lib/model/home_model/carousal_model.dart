// class CarousalModel {
//   final String image;
//   // final String offer;
//   final String id;

//   CarousalModel({
//     required this.image,
//     // required this.offer,
//     required this.id,
//   });
//   factory CarousalModel.fromJson(Map<String, dynamic> json) {
//     return CarousalModel(
//       image: json['image'],
//       // offer: json['offer'],
//       id: json['_id'],
//     );
//   }
// }

class CarousalModel {
  CarousalModel({
    required this.id,
    required this.image,
    required this.v,
  });

  String id;
  String image;
  int v;

  factory CarousalModel.fromJson(Map<String, dynamic> json) => CarousalModel(
        id: json["_id"],
        image: json["image"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "image": image,
        "__v": v,
      };
}
