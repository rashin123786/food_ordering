class LoginUser {
  bool? result;
  String? message;
  String? accessToken;
  String? tokenType;
  UserModel? user;

  LoginUser({
    this.result,
    this.message,
    this.accessToken,
    this.tokenType,
    this.user,
  });

  factory LoginUser.fromJson(Map<String, dynamic> json) {
    return LoginUser(
      result: json['result'],
      message: json['message'],
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      user: UserModel.fromJson(json['user']),
    );
  }
}

class UserModel {
  int? id;
  String? roleId;
  String? name;
  String? email;
  String? phone;
  int? emailOrOtpVerified;
  String? verificationCode;
  String? newEmailVerificationCode;
  String? providerId;
  String? avatar;
  String? postalCode;
  int? userBalance;
  int? isBanned;
  String? shopId;
  String? emailVerifiedAt;
  String? deletedAt;

  UserModel({
    this.id,
    this.roleId,
    this.name,
    this.email,
    this.phone,
    this.emailOrOtpVerified,
    this.verificationCode,
    this.newEmailVerificationCode,
    this.providerId,
    this.avatar,
    this.postalCode,
    this.userBalance,
    this.isBanned,
    this.shopId,
    this.emailVerifiedAt,
    this.deletedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      roleId: json['role_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      emailOrOtpVerified: json['email_or_otp_verified'],
      verificationCode: json['verification_code'],
      newEmailVerificationCode: json['new_email_verification_code'],
      providerId: json['provider_id'],
      avatar: json['avatar'],
      postalCode: json['postal_code'],
      userBalance: json['user_balance'],
      isBanned: json['is_banned'],
      shopId: json['shop_id'],
      emailVerifiedAt: json['email_verified_at'],
      deletedAt: json['deleted_at'],
    );
  }
}
