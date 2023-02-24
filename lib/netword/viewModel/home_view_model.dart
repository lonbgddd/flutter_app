import 'dart:io';

import 'package:assignments_final/netword/postData/postServer.dart';
import 'package:flutter/cupertino.dart';

import '../../model/post.dart';

class HomeViewModel extends ChangeNotifier{
  List<Post> listPost = [];



  fetchPostList() async {
    this.listPost = (await PostServer().getAllPost())!;
    notifyListeners();
  }


}
