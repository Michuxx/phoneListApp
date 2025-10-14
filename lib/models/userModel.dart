class UserModel {
  final int? id;
  final String email;
  final String password;

  UserModel({
     this.id,
    required this.email,
    required this.password,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "email": email,
    "password": password,
  };
}
