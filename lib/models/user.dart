import 'package:flutter/painting.dart';

class User {
  int? id;
  String firstName;
  String lastName;
  String email;
  ImageProvider<Object>? image;
  String token;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
    required this.token,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      email: map['email'] ?? '',
      image: map['avatar'] != null ? NetworkImage(map['avatar']) : null,
      token: map['token'] ?? '',
    );
  }
}
