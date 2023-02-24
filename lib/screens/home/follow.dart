import 'package:assignments_final/model/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../netword/viewModel/followModel.dart';
import 'comporment/list_post.dart';

class FollowListPost extends StatefulWidget {
  const FollowListPost({Key? key, this.user}) : super(key: key);
  final User? user;

  @override
  State<FollowListPost> createState() => _FollowListPostState();
}

class _FollowListPostState extends State<FollowListPost> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<FollowViewModel>(context, listen: false).fetchPostListIds(widget.user!.idPosts!);
  }
  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<FollowViewModel>(context);

    return Scaffold(
      body: Padding(
          padding: EdgeInsets.only(top: 60),
          child: RefreshIndicator(
              backgroundColor: Colors.black12,
              onRefresh: () async {
                setState(() {
                  Provider.of<FollowViewModel>(context, listen: false)
                      .fetchPostListIds(widget.user!.idPosts!);
                });
              },
              child: Center(
                child: listProvider.listPostById.length != 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: listProvider.listPostById.length,
                        itemBuilder: (BuildContext context, index) => listPost(
                          context,
                          post: listProvider.listPostById[index],
                          user: widget.user,
                        ),
                      )
                    : CircularProgressIndicator(),
              ))),
    );
  }
}
