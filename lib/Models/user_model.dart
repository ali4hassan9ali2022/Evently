class UserModel {
  static UserModel? currentUser;
  final String userId;
  final String name;
  final String email;
  List<String> favoriteEvents;

  UserModel({required this.userId, required this.name, required this.email,
  this.favoriteEvents = const [],
  });
  toJson() {
    return {
      "userId": userId,
      "name": name,
      "email": email,
      "favorites" : favoriteEvents,
    };
  }
  factory UserModel.fromJson(json) {
    return UserModel(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      favoriteEvents: List<String>.from(json['favorites']),
    );
  }
}
