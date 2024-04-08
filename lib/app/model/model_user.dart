


class Users{
  int? iduser;
  String? username;
  String? password;
  String? email;

  Users({this.iduser, this.username, this.password, this.email});

Users.fromJson(Map<String, dynamic> json) {
    iduser = json['id'];
    username = json['username'];
    password = json['password'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.iduser;
    data['username'] = this.username;
    data['password'] = this.password;
    data['email'] = this.email;
    return data;
  }
}