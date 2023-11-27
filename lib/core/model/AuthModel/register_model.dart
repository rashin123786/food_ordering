class RegisterModel {
  bool? result;
  String? message;
  String accessToken;
  String? tokenType;
  User user;

  RegisterModel({
    this.result,
    this.message,
    required this.accessToken,
    this.tokenType,
    required this.user,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      result: json['result'],
      message: json['message'],
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  String? name;
  String? email;
  String? phone;
  int? id;
  int? emailOrOtpVerified;
  String? emailVerifiedAt;

  User({
    this.name,
    this.email,
    this.phone,
    this.id,
    this.emailOrOtpVerified,
    this.emailVerifiedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      id: json['id'],
      emailOrOtpVerified: json['email_or_otp_verified'],
      emailVerifiedAt: json['email_verified_at'],
    );
  }
}
