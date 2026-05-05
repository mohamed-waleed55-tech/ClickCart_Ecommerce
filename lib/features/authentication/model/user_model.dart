class UserModel {
  final String id;
  final String name;
  final String email;
  final String pic;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.pic,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      pic: json['pic'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'pic': pic,
    };
  }
}