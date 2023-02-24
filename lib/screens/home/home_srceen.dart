import 'dart:math';

import 'package:assignments_final/model/user.dart';
import 'package:assignments_final/netword/viewModel/home_view_model.dart';
import 'package:assignments_final/screens/home/comporment/list_post.dart';
import 'package:assignments_final/screens/home/follow.dart';
import 'package:assignments_final/screens/post/post_new_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeViewModel>(context, listen: false).fetchPostList();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final List<Icon> tabs = <Icon>[
      Icon(
        Icons.home,
        size: 35,
      ),
      Icon(Icons.insert_emoticon_sharp, size: 35),
      Icon(Icons.notifications_active, size: 35)
    ];
    return DefaultTabController(
        length: tabs.length, // This is the number of tabs.
        child: Scaffold(
          backgroundColor: Colors.white,
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    backgroundColor: Colors.white,
                    floating: true,
                    title: Text(
                      'Chào mừng trở lại!',
                      style: TextStyle(color: Colors.black),
                    ),
                    actions: [
                      widget.user.job == "true"
                          ? IconButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PostNew(idUser: widget.user),
                                  )),
                              icon: Icon(
                                Icons.add,
                                color: Colors.black,
                                size: 38,
                              ))
                          : SizedBox(),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                    pinned: true,
                    expandedHeight: 100.0,
                    forceElevated: innerBoxIsScrolled,
                    bottom: TabBar(
                      labelColor: Colors.blueAccent,
                      tabs: tabs
                          .map((Icon name) => Tab(
                                icon: name,
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                homListView(context),
                FollowListPost(user: widget.user),
                Center(
                  child: Text('Màn 3'),
                )
              ],
            ),
          ),
        ));
  }

  Widget homListView(BuildContext context) {
    final listProvider = Provider.of<HomeViewModel>(context);
    return Padding(
        padding: EdgeInsets.only(top: 60),
        child: RefreshIndicator(
            backgroundColor: Colors.black12,
            onRefresh: () async {
              setState(() {
                Provider.of<HomeViewModel>(context, listen: false)
                    .fetchPostList();
              });
            },
            child: Center(
              child: listProvider.listPost.length != 0
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: listProvider.listPost.length,
                      itemBuilder: (BuildContext context, index) => listPost(
                        context,
                        post: listProvider.listPost[index],
                        user: widget.user,
                      ),
                    )
                  : CircularProgressIndicator(),
            )));
  }
}
