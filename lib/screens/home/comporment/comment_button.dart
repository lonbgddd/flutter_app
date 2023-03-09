import 'package:assignments_final/model/post.dart';
import 'package:flutter/material.dart';

Widget commentButton(BuildContext context, int? post) {
  return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          builder: (context) => DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.9,
            minChildSize: 0.4,
            maxChildSize: 0.9,
            builder: (context, scrollController) => ListView(
              padding: EdgeInsets.all(10),
              shrinkWrap: true,
              controller: scrollController,
              children: [
                Text('10 bình luận', style:  TextStyle(fontSize: 16),)

              ],
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.comment), Text('Bình luận')],
        ),
      ));
}
