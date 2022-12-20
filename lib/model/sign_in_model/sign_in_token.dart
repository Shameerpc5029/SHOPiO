class SignInTokenModel {
  final String accessToken;
  final String refreshToken;

  SignInTokenModel({
    required this.accessToken,
    required this.refreshToken,
  });
  factory SignInTokenModel.fromJson(Map<String, dynamic> json) {
    return SignInTokenModel(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}
