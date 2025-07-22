class UserModel {
  String name;
  String email;
  static const String collectionName = "Users";
  String userId;
  String userImage;

  UserModel({
    required this.name,
    required this.email,
    this.userId = "",
    this.userImage = "",
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'user_id': userId,
      'user_image': userImage,
    };
  }

  UserModel.fromJson(Map<String, dynamic> json)
    : this(
        name: json['name'],
        email: json['email'],
        userId: json['user_id'],
        userImage: json['user_image'],
      );
}
