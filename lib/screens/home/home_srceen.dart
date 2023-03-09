import 'package:assignments_final/model/user.dart';
import 'package:assignments_final/netword/viewModel/home_view_model.dart';
import 'package:assignments_final/screens/home/comporment/item.dart';
import 'package:assignments_final/screens/post/post_new_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'comporment/listPost.dart';

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
    context.read<HomeViewModel>().fetchPostList();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final List<Icon> tabs = <Icon>[
      const Icon(
        Icons.home,
        size: 35,
      ),
      const Icon(Icons.insert_emoticon_sharp, size: 35),
      const Icon(Icons.notifications_active, size: 35)
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
                    title: const Text(
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
                              icon: const Icon(
                                Icons.add,
                                color: Colors.black,
                                size: 38,
                              ))
                          : const SizedBox(),
                      const SizedBox(
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
                homListView(context, widget.user),
                const Center(
                  child: Text('Màn 3'),
                )
              ],
            ),
          ),
        ));
  }

}
