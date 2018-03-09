import 'package:flutter/material.dart';
import 'package:flutter_drib/model/dribbble_comment.dart';
import 'package:flutter_drib/ui/basic/fdColors.dart';

class CommentItem extends StatelessWidget {

  final DribbbleComment comment;

  CommentItem({key, this.comment}) : super(key: key);

  final usernameTextStyle = const TextStyle(color: FDColors.fontTitleColor,
      fontSize: 11.0,
      fontWeight: FontWeight.w600);
  final dateTextStyle = const TextStyle(
      color: FDColors.fontDateColor, fontSize: 11.0);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.only(
          top: 12.0, right: 16.0, left: 16.0, bottom: 8.0),
      child: new Row(
        children: <Widget>[
          new CircleAvatar(
              radius: 20.0,
              backgroundImage: new NetworkImage(comment.user.avatarUrl)
          ),
          new Flexible(child:
          new Container(
            margin: const EdgeInsets.only(left: 16.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(comment.user.name, style: usernameTextStyle),
                new Container(
                  margin: const EdgeInsets.only(top: 3.0),
                  child: new Column(
                    children: comment.convertBodyToTexts(),
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: new Text(comment.createAt, style: dateTextStyle),
                ),
              ],
            ),
          )
          )
        ],
      ),
    );
  }


}