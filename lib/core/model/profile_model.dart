class ProfileModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final double balance;
  final String avatar;
  final String isBanned;

  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.balance,
    required this.avatar,
    required this.isBanned,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      balance: (json['balance'] as num).toDouble(),
      avatar: json['avatar'],
      isBanned: json['is_banned'],
    );
  }
}
