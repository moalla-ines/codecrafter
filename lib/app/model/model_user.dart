class UserEntity {
  int? id;
  String? username;
  String? password;
  String? email;

  UserEntity({this.id, this.username, this.password, this.email});

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'email': email,
    };
  }
}
