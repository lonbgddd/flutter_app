import 'dart:convert';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  Post({
    required this.createdAt,
    required this.idUser,
    required this.image,
    required this.contents,
    this.numberLikes,
    this.numberComment,
    this.nameUser,
    this.avatar,
    this.idPost,
  });

  DateTime createdAt;
  String? idUser;
  String image;
  String contents;
  List<dynamic>? numberLikes;
  List<dynamic>? numberComment;
  String? nameUser;
  String? avatar;
  String? idPost;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        createdAt: DateTime.parse(json["createdAt"]),
        idUser: json["id_user"],
        image: json["image"],
        contents: json["contents"],
        numberLikes: List<dynamic>.from(json["number_likes"].map((x) => x)),
        numberComment: List<dynamic>.from(json["number_comment"].map((x) => x)),
        nameUser: json["nameUser"],
        avatar: json["avatar"],
        idPost: json["id_post"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "id_user": idUser,
        "image": image,
        "contents": contents,
        "number_likes": List<dynamic>.from(numberLikes!.map((x) => x)),
        "number_comment": List<dynamic>.from(numberComment!.map((x) => x)),
        "nameUser": nameUser,
        "avatar": avatar,
        "id_post": idPost,
      };
}
