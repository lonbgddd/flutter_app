import 'dart:convert';
import 'dart:typed_data';

import 'package:assignments_final/model/post.dart';
import 'package:assignments_final/netword/postData/postServer.dart';
import 'package:assignments_final/netword/userData/newUser.dart';
import 'package:assignments_final/netword/viewModel/home_view_model.dart';
import 'package:assignments_final/screens/home/comporment/comment_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/user.dart';
import '../../post/updatePost.dart';
import 'like_bottom.dart';
import 'like_heath.dart';

enum SampleItem { itemUpdate, itemFollow, itemDelete }

class ListPost extends StatelessWidget {
  const ListPost({Key? key, required this.indexPost, this.indexUser})
      : super(key: key);
  final int indexPost;
  final User? indexUser;

  deletePost(String idPost) async {
    await PostServer().deleteByID(idPost);
  }

  addPostId(String idPost, String idUser) async {
    await UserServer().addPostID(idPost, idUser);
  }

  @override
  Widget build(BuildContext context) {
    SampleItem? selectedMenu;
    final viewModel = context.watch<HomeViewModel>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          child: ClipOval(
                            child: Image.memory(
                                viewModel.getAvatar(indexPost) as Uint8List,
                                fit: BoxFit.cover),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        Padding(
                            padding: EdgeInsets.only(bottom: 14, left: 8),
                            child: Text(
                              viewModel.getName(indexPost),
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        PopupMenuButton(
                          initialValue: selectedMenu,
                          // Callback that sets the selected popup menu item.
                          onSelected: (SampleItem item) {
                            selectedMenu = item;
                            switch (item) {
                              case SampleItem.itemUpdate:
                                indexUser!.id != viewModel.getIdUser(indexPost)
                                    ? _showCupertinoDialog(
                                        context,
                                        "Bạn không phải chủ bài đăng",
                                        "Không có quyền chỉnh sửa")
                                    : Center(
                                        child: Text("Rỗng"),
                                      );

                                // Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //           builder: (context) => UpdatePost(
                                //               idUser: indexUser,
                                //               post: viewModel.getIdUser(indexPost)),
                                //         ));
                                break;
                              case SampleItem.itemDelete:
                                indexUser!.id != viewModel.getIdUser(indexPost)
                                    ? _showCupertinoDialog(
                                        context,
                                        "Bạn không phải chủ bài đăng",
                                        "Không có quyền xoá")
                                    : deletePost(viewModel.getIdPost(indexPost));

                                break;
                              case SampleItem.itemFollow:
                                // addPostId(
                                //     widget.post!.idPost!, widget.user!.id!);
                                // _showCupertinoDialog(context, "Chúc mừng bạn",
                                //     "Theo dõi thành công");
                                break;
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<SampleItem>>[
                            const PopupMenuItem<SampleItem>(
                              value: SampleItem.itemFollow,
                              child: Text('Follow'),
                            ),
                            const PopupMenuItem<SampleItem>(
                              value: SampleItem.itemUpdate,
                              child: Text('Update'),
                            ),
                            const PopupMenuItem<SampleItem>(
                              value: SampleItem.itemDelete,
                              child: Text('Delete'),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.clear_rounded,
                          size: 30,
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(viewModel.getContent(indexPost),
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal)),
                ),
                Container(
                    height: 200,
                    child: Image.memory(
                      viewModel.getImage(indexPost) as Uint8List,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitWidth,
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.favorite_border),
                          Text("${viewModel.likes(indexPost).length}")
                        ],
                      ),
                      Text("${viewModel.likes(indexPost).length}"),
                    ],
                  ),
                ),
                SizedBox(
                    height: 1,
                    child: Container(
                      height: 0.1,
                      color: Colors.black12,
                    )),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    LikeHeath(
                      indexPost: indexPost,
                    ),
                    commentButton(context, indexPost),
                    boderLikeShare(Icon(Icons.share), 'Chia sẻ')
                  ],
                ),
                SizedBox(
                  height: 10,
                )
              ],
            )),
      ),
    );
  }

  void _showCupertinoDialog(
      BuildContext context, String title, String content) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok')),
            ],
          );
        });
  }
}
