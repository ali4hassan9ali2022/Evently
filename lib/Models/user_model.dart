class UserModel {
  static UserModel? currentUser;
  final String userId;
  final String name;
  final String email;
  final String? photoUrl;
  List<String> favoriteEvents;

  UserModel({required this.userId, required this.name, required this.email,
  this.photoUrl,
  this.favoriteEvents = const [],
  });
  toJson() {
    return {
      "userId": userId,
      "name": name,
      "email": email,
      "favorites" : favoriteEvents,
      "photoUrl" : photoUrl,
    };
  }
  factory UserModel.fromJson(json) {
    return UserModel(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      favoriteEvents: List<String>.from(json['favorites']),
      photoUrl: json['photoUrl'],
    );
  }
}
