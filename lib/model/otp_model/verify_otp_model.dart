class VerifyOtpModel {
  final String email;
  final String code;

  VerifyOtpModel({
    required this.email,
    required this.code,
  });
  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) {
    return VerifyOtpModel(
      email: json['email'] ?? '',
      code: json['code'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "code": code,
    };
  }
}
