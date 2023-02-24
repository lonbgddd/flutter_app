import 'dart:async';
import 'dart:convert';

import 'package:assignments_final/model/user.dart';
import 'package:assignments_final/netword/api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

class UserServer {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<dynamic> creatAccount(User user) async {
    final reference = firestore.collection('users').doc();
    User useJson = User(
        id: reference.id,
        name: user.name,
        job: user.job,
        avate: user.avate,
        phoneNumber: user.phoneNumber,
        password: user.password,
        token: user.token,
        idPosts: []
    );
    return await reference.set(useJson.toJson());
  }
  Future<dynamic> addPostID(String postId, String idUser) async {
    final ref = firestore.collection('users').doc(idUser);
    
    return ref.update({"idPosts": FieldValue.arrayUnion([postId])});
  }
  Future<dynamic> addUserToken(String idUser, String token) async {
    final ref = firestore.collection('users').doc(idUser);

    return ref.update({"token": token});
  }
  
  Future<User> getUser(String phone, String password) async {
    final snapshot = await firestore
        .collection('users')
        .where('phoneNumber', isEqualTo: phone)
        .where('password', isEqualTo: password)
        .get();
    return snapshot.docs.map((e) => User.fromJson(e)).single;
  }

  Future<User> getUserID(String idUser) async {
    final snapshot = await firestore
        .collection('users')
        .where('id', isEqualTo: idUser)
        .get();
    return snapshot.docs.map((e) => User.fromJson(e)).single;
  }
}
