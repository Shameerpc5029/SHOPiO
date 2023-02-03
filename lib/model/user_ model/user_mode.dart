
class UserModel {
    UserModel({
        required this.id,
        required this.fullname,
        required this.email,
        required this.password,
        required this.phone,
        required this.refreshToken,
        required this.v,
    });

    String id;
    String fullname;
    String email;
    String password;
    String phone;
    List<String> refreshToken;
    int v;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        fullname: json["fullname"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        refreshToken: List<String>.from(json["refreshToken"].map((x) => x)),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "fullname": fullname,
        "email": email,
        "password": password,
        "phone": phone,
        "refreshToken": List<dynamic>.from(refreshToken.map((x) => x)),
        "__v": v,
    };
}
