import 'package:flutter/material.dart';

Widget boderLikeShare(Widget icon, String titile) => Expanded(
    flex: 1,
    child: GestureDetector(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [icon, Text(titile)],
      ),
    ));
