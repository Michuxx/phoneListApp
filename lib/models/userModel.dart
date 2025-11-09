class UserModel {
  final int? id;
  final String email;
  final String username;
  final String password;


  UserModel({
     this.id,
    required this.email,
    required this.username,
    required this.password,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    email: json["email"],
    username: json["username"],
    password: json["password"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "email": email,
    "password": password,
    "username": username
  };
}
