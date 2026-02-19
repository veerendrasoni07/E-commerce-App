// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String id;
  final String fullname;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String password;

  User({
    required this.id,
    required this.fullname,
    required this.email,
    required this.state,
    required this.city,
    required this.locality,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullname': fullname,
      'email': email,
      'state': state,
      'city': city,
      'locality': locality,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String ? ?? '',
      fullname: map['fullname'] as String ? ?? '',
      email: map['email'] as String ? ?? '',
      state: map['state'] as String ? ?? '',
      city: map['city'] as String ? ?? '',
      locality: map['locality'] as String ? ?? '',
      password: map['password'] as String ? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);
}
