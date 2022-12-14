class SignUpToken {
  final String accessToken;
  final String refreshToken;

  SignUpToken({
    required this.accessToken,
    required this.refreshToken,
  });
  factory SignUpToken.fromJson(Map<String, dynamic> json) {
    return SignUpToken(
      refreshToken: json['refreshToken'],
      accessToken: json['accessToken'],
    );
  }
}
