import 'package:codecrafter/app/model/roles.dart';

class Users {
  int? id;
  String? username;
  String? password;
  String? email;
  List<Role>? roles; // Utilisez List<Role> pour stocker les rôles de l'utilisateur
  bool? enabled;
  List<String>? authorities;
  bool? accountNonLocked;
  bool? accountNonExpired;
  bool? credentialsNonExpired;

  Users({
    this.id,
    this.username,
    this.password,
    this.email,
    this.roles,
    this.enabled,
    this.authorities,
    this.accountNonLocked,
    this.accountNonExpired,
    this.credentialsNonExpired,
  });

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    email = json['email'];
    roles = json['roles'] != null ? List<Role>.from(json['roles'].map((x) => Role.fromJson(x))) : null;
    enabled = json['enabled'];
    authorities = json['authorities'] != null ? List<String>.from(json['authorities']) : null;
    accountNonLocked = json['accountNonLocked'];
    accountNonExpired = json['accountNonExpired'];
    credentialsNonExpired = json['credentialsNonExpired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['email'] = this.email;
    if (this.roles != null) {
      data['roles'] = this.roles!.map((roles) => roles.toJson()).toList();
    }
    data['enabled'] = this.enabled;
    data['authorities'] = this.authorities;
    data['accountNonLocked'] = this.accountNonLocked;
    data['accountNonExpired'] = this.accountNonExpired;
    data['credentialsNonExpired'] = this.credentialsNonExpired;
    return data;
  }
}
