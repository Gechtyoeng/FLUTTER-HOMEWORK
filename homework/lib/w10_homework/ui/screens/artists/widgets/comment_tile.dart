import 'package:flutter/material.dart';
import 'package:w6_homework/w10_homework/model/artist/comment.dart';

class CommentTile extends StatelessWidget {
  final Comment comment;
  const CommentTile({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Text(comment.artistId[0].toUpperCase())),
      title: Text(comment.comment),
    );
  }
}
