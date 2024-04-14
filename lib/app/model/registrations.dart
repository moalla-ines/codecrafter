class RegistrationData {
  int? id;
  String? username;
  String? password;
  String? email;

  RegistrationData({this.id ,this.username, this.password, this.email});
  factory RegistrationData.fromJson(Map<String, dynamic> json) {
    return RegistrationData(
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

