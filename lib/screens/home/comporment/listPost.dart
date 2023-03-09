import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/user.dart';
import '../../../netword/viewModel/home_view_model.dart';
import 'item.dart';

Widget homListView(BuildContext context, User user) {
  final listProvider = context.watch<HomeViewModel>();
  return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: RefreshIndicator(
          backgroundColor: Colors.black12,
          onRefresh: listProvider.fetchPostList,
          child: Center(
            child: listProvider.listPost.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: listProvider.listPost.length,
                    itemBuilder: (BuildContext context, index) => ListPost(
                      indexPost: index,
                      indexUser: user,
                    ),
                  )
                : const CircularProgressIndicator(),
          )));
}
