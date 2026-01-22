class UserModel {
  static UserModel? currentUser;
  final String userId;
  final String name;
  final String email;

  UserModel({required this.userId, required this.name, required this.email});
  factory UserModel.fromJson(json) {
    return UserModel(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
    );
  }
}
