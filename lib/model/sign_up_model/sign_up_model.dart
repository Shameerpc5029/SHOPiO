class SignUpModel {
  final String fullName;
  final String email;
  final String mobileNumber;
  final String password;

  SignUpModel({
    required this.fullName,
    required this.email,
    required this.mobileNumber,
    required this.password,
  });
  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      fullName: json["fullname"] ?? '',
      email: json["email"] ?? '',
      mobileNumber: json["phone"] ?? '',
      password: json["password"] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "fullname": fullName,
      "email": email,
      "phone": mobileNumber,
      "password": password,
    };
  }
}
