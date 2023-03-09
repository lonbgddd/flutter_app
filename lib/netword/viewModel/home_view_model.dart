import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:assignments_final/netword/postData/postServer.dart';
import 'package:flutter/cupertino.dart';

import '../../model/post.dart';

typedef OnABC(int index);

class HomeViewModel extends ChangeNotifier {
  List<Post> listPost = [];

  void initial() {
    listPost = [];
  }

  Future<void> fetchPostList() async {
    initial();
    try {
      final result = await PostServer().getAllPost();
      listPost = result;
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  String getName(int index) => listPost[index].nameUser ?? "";

  Object getImage(int index) => base64Decode(listPost[index].image) ?? "";

  Object getAvatar(int index) => base64Decode(listPost[index].avatar!) ?? "";

  String getIdUser(int index) => listPost[index].idUser ?? "";
  String getIdPost(int index) => listPost[index].idPost ?? "";

  String getContent(int index) => listPost[index].contents ?? "";

  List likes(int index) => listPost[index].numberLikes ?? [];
}
