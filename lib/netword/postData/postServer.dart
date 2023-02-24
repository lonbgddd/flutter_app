import 'dart:convert';

import 'package:assignments_final/model/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import '../api.dart';

class PostServer {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Future<List<Post>?> getAllPost() async {
  //   final response = await http.get(Uri.parse(API_DATE_KEY + '/posts'));
  //   if (response.statusCode == 200) {
  //     print(response.body);
  //     return postFromJson(response.body);
  //   } else {
  //     throw Exception('Http Failed');
  //   }
  // }
  Future<List<Post>> getAllPost() async {
    final snapshot = await firestore.collection('posts').get();
    return snapshot.docs.map((e) => Post.fromJson(e.data())).toList();
  }

  Future<List<Post>> getAllPostId(List<String> list) async {
    final snapshot = await firestore
        .collection('posts')
        .where("id_post", whereIn: list)
        .get();
    return snapshot.docs.map((e) => Post.fromJson(e.data())).toList();
  }

  Future<dynamic> creatPost(Post user) async {
    final reference = firestore.collection('posts').doc();
    Post post = Post(
        createdAt: DateTime.now(),
        idUser: user.idUser,
        image: user.image,
        contents: user.contents,
        numberLikes: [],
        numberComment: [],
        idPost: reference.id,
        avatar: user.avatar,
        nameUser: user.nameUser);
    return await reference.set(post.toJson());
  }

  Future<dynamic> deleteByID(String idPost) async {
    final reference = firestore.collection('posts').doc(idPost);
    return reference.delete();
  }

  Future<dynamic> updatePost(String? idPost, Post user) async {
    final reference = firestore.collection('posts').doc(idPost);
    Post post = Post(
        createdAt: DateTime.now(),
        idUser: user.idUser,
        image: user.image,
        contents: user.contents,
        numberLikes: [],
        numberComment: [],
        idPost: reference.id,
        avatar: user.avatar,
        nameUser: user.nameUser);
    return await reference.set(post.toJson());
  }

  Future<http.Response> postData(Post post) async {
    final response = await http.post(
        Uri.parse(
            'https://63c556cbe1292e5bea20ca81.mockapi.io/api/app-flutter/posts'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(post.toJson()));
    if (response.statusCode == 201) {
      return response;
    } else if (response.statusCode == 404) {
      throw Exception('Failed to 404');
    } else {
      throw Exception('Failed to call api');
    }
  }
}
