import 'package:flutter/material.dart';
import 'package:flutter_drib/model/dribbble_user.dart';
import 'package:flutter_drib/ui/basic/fdColors.dart';

class DribbbleComment {

  final num id;
  final String body;
  final DribbbleUser user;
  final String createAt;
  final int likesCount;

  DribbbleComment(this.id, this.body, this.user, this.createAt,
      this.likesCount);

  static DribbbleComment fromJson(Map<String, dynamic> json) {
    var id = json['id'];
    var body = json['body'];
    var likesCount = json['likes_count'];
    var createAt = json['created_at'];
    var user = DribbbleUser.fromJson(json['user']);
    return new DribbbleComment(id, body, user, createAt, likesCount);
  }

  List<Widget> convertBodyToTexts() {
    var pRemoved = body.replaceAll("<p>", "");
    pRemoved = pRemoved.replaceAll("</p>", "");
    var lines = pRemoved.split("<br />");
    lines = pRemoved.split("\\n");
    var result = [];
    lines.forEach((String lineString) {
      result.add(new Wrap(children: _getBodyWidgetList(lineString)));
    });
    return result;
  }

  List<Widget> _getBodyWidgetList(String content) {
    final commonTextStyle = const TextStyle(
        color: FDColors.fontTitleColor, fontSize: 14.0);
    final linkTextStyle = const TextStyle(
        color: FDColors.linkBlue, fontSize: 14.0);
    var widgetList = [];
    var leftContent = content;
    while (leftContent.contains("<a")) {
      var startIndex = content.indexOf("<a");
      var endIndex = content.indexOf("</a>");
      if (startIndex != 0) {
        //content before <a> tag
        var commonText = leftContent.substring(0, startIndex);
        widgetList.add(new Text(commonText, style: commonTextStyle));
        leftContent = leftContent.substring(0, endIndex);
        continue;
      } else {
        //Parse link address and name
        var addressStartIndex = leftContent.indexOf("href=\"") + 6;
        var addressEndIndex = leftContent.indexOf("\">");
        var nameStartIndex = addressEndIndex + 2;
        var nameEndIndex = leftContent.indexOf("</a>");
        var address = leftContent.substring(addressStartIndex, addressEndIndex);
        var name = leftContent.substring(nameStartIndex, nameEndIndex);
        widgetList.add(
            new GestureDetector(child: new Text(name, style: linkTextStyle),
              onTap: () {},));
        leftContent = leftContent.substring(nameEndIndex + 4);
        continue;
      }
    }
    widgetList.add(new Text(leftContent, style: commonTextStyle));
    return widgetList;
  }

}