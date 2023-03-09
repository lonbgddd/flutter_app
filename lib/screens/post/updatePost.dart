// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:assignments_final/netword/postData/postServer.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../../model/post.dart';
// import '../../model/user.dart';
//
// class UpdatePost extends StatefulWidget {
//   const UpdatePost({Key? key, required this.idUser, this.post})
//       : super(key: key);
//   final User? idUser;
//   final int? post;
//
//   @override
//   State<UpdatePost> createState() => _PostNewState();
// }
//
// class _PostNewState extends State<UpdatePost> {
//   final content = TextEditingController();
//   File? imageGallery;
//   final imagePick = ImagePicker();
//   bool isUpdate = false;
//   Uint8List? listImage;
//   updatePost(String idPost, Post post) async {
//     await PostServer().updatePost(idPost, post);
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     listImage  = base64Decode(widget.post!.image);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     User? user = widget.idUser;
//     Uint8List list = base64Decode(user!.avate);
//     content.text = widget.post!.contents;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Cập nhật bài đăng của bạn"),
//       ),
//       body: ListView(
//         shrinkWrap: true,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(top: 20, right: 20),
//                     height: 60,
//                     width: 60,
//                     child: ClipOval(
//                       child: Image.memory(list, fit: BoxFit.cover),
//                     ),
//                   ),
//                   Padding(
//                       padding: EdgeInsets.only(bottom: 15),
//                       child: Text(
//                         user.name,
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 22),
//                       )),
//                 ],
//               ),
//               ElevatedButton(
//                   onPressed: () async {
//                     Uint8List postImage = await imageGallery!.readAsBytes();
//                     await Future.delayed(
//                       Duration(seconds: 2),
//                       () {
//                         updatePost(
//                             widget.post!.idPost!,
//                             Post(
//                                 createdAt: DateTime.now(),
//                                 idUser: user.id,
//                                 image: base64.encode(postImage),
//                                 contents: content.text,
//                                 numberLikes: [],
//                                 numberComment: [],
//                                 idPost: 'null',
//                                 avatar: user.avate,
//                                 nameUser: user.name));
//                         Navigator.of(context).pop();
//                       },
//                     );
//                   },
//                   child: Text("Cập nhật"))
//             ],
//           ),
//           Padding(
//             padding: EdgeInsets.only(left: 20, right: 20, top: 20),
//             child: TextField(
//               controller: content,
//               autofocus: true,
//               decoration: InputDecoration(
//                 hintText: "Viết một điều gì đó ?",
//                 border: InputBorder.none,
//                 icon: IconButton(
//                     onPressed: () => getImageGallery(),
//                     icon: Icon(Icons.image_outlined)),
//                 enabled: true,
//               ),
//             ),
//           ),
//           widget.post != null
//               ? Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   child: Image.memory(
//                     listImage!,
//                     height: 300,
//                     width: MediaQuery.of(context).size.width,
//                     fit: BoxFit.cover,
//                   ),
//                 )
//               : SizedBox()
//         ],
//       ),
//     );
//   }
//
//   getImageGallery() async {
//     final XFile? image = await imagePick.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(()async {
//         listImage = await File(image.path).readAsBytes();
//         imageGallery = File(image.path);
//       });
//     }
//   }
// }
