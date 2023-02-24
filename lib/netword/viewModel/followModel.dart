
import 'package:flutter/cupertino.dart';

import '../../model/post.dart';
import '../postData/postServer.dart';

class FollowViewModel extends ChangeNotifier{
  List<Post> listPostById = [];
  fetchPostListIds(List<String> listPostId) async {
    this.listPostById = await PostServer().getAllPostId(listPostId);
    notifyListeners();
  }
}