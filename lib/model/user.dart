import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    required this.id,
    required this.name,
    required this.job,
    required this.avate,
    required this.phoneNumber,
    required this.password,
    required this.token,
    this.idPosts
  });

  String? id;
  String name;
  String job;
  String avate;
  String phoneNumber;
  String password;
  String? token;
  List<String>? idPosts;
  factory User.fromJson(DocumentSnapshot<Map<String, dynamic>> json) => User(
    id: json.data()!["id"],
    name: json.data()!["name"],
    job: json.data()!["job"],
    avate: json.data()!["avate"],
    phoneNumber: json.data()!["phoneNumber"],
    password: json.data()!["password"],
    token:  json.data()!['token'],
    idPosts: List<String>.from(json["idPosts"].map((x) => x))
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "job": job,
    "avate": avate,
    "phoneNumber": phoneNumber,
    "password": password,
    "token":token,
    "idPosts": List<String>.from(idPosts!.map((x) => x)),
  };
}