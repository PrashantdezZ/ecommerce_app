import 'dart:convert';

class User{
  int? id;
  String? name;
  String? email;
  num? phone;
  String? password;
  String? token;
  bool? emailVerified;



User({this.name, this.id,this.email, this.password,this.token,this.phone,this.emailVerified});


factory User.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    return User(
      id: json['user'],
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      token: json['access'],
      emailVerified: json['email_verified']
    );

  }
}