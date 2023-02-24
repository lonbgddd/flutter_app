import 'package:flutter/material.dart';

import '../../../model/post.dart';

class LikeHeath extends StatefulWidget {
  const LikeHeath({Key? key, required this.post}) : super(key: key);
  final Post? post;

  @override
  State<LikeHeath> createState() => _LikeHeathState();
}

class _LikeHeathState extends State<LikeHeath> {
  bool isStatus = true;

  void _setFailed() {
    setState(() {
      isStatus = false;
    });
  }

  void _setTrue() {
    setState(() {
      isStatus = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () => isStatus ? _setFailed() : _setTrue(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite,
                color: isStatus ? Colors.black12 : Colors.red,
                size: isStatus? 20: 26,
              ),
              Text('Thích', style: TextStyle(color: isStatus ? Colors.black : Colors.red,),)
            ],
          ),
        ));
    ;
  }
}
