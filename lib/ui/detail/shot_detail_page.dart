import 'package:flutter/material.dart';
import 'package:flutter_drib/model/dribbble_shot.dart';
import 'package:flutter_drib/ui/basic/fdColors.dart';

class ShotDetailPage extends StatelessWidget {

  final DribbbleShot shot;

  ShotDetailPage({Key key, this.shot})
      : assert (shot != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBarHeight = 250.0;
    return new Scaffold(
        body: new CustomScrollView(
            slivers: <Widget>[
              _buildSliverAppBar(appBarHeight),
              new SliverList(delegate: new SliverChildListDelegate([
                _buildBasicInfoContainer(),
                _buildCountContainer()
              ]))
            ]
        )
    );
  }

  Container _buildBasicInfoContainer() {
    return new Container(
      padding: const EdgeInsets.all(10.0),
      decoration: new BoxDecoration(
        border: new Border(
            top: new BorderSide(
                color: FDColors.dividerColor, width: 0.5),
            bottom: new BorderSide(
                color: FDColors.dividerColor, width: 0.5)),
      ),
      child: new Row(
        children: <Widget>[
          new CircleAvatar(
            backgroundImage: new NetworkImage(shot.user.avatarUrl),
            radius: 18.0,
          ),
          new Flexible(
            child: new Container(
                margin: const EdgeInsets.only(left: 8.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _getBasicInfoTitle,
                    _getBasicInfoSubTitle()
                  ],)),)
        ],
      ),
    );
  }

  Widget get _getBasicInfoTitle {
    return new Container(margin: const EdgeInsets.only(bottom: 3.0),
        child: new Text(shot.title,
          overflow: TextOverflow.ellipsis,
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              color: FDColors.fontTitleColor,
              fontSize: 15.0),
          maxLines: 1,));
  }

  RichText _getBasicInfoSubTitle() {
    final subTitleTextStyle = new TextStyle(
        color: FDColors.fontSubTitleColor, fontSize: 12.0);
    return new RichText(
        text: new TextSpan(text: "By ",
            style: subTitleTextStyle,
            children: [
              new TextSpan(text: shot.user.name,
                  style: new TextStyle(color: FDColors.linkBlue)),
              new TextSpan(
                  text: " On " + "2018.03.06", style: subTitleTextStyle)
            ]));
  }

  SliverAppBar _buildSliverAppBar(double appBarHeight) {
    return new SliverAppBar(
        expandedHeight: appBarHeight,
        actions: <Widget>[
          new IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'Share',
            onPressed: () {},
          )
        ],
        flexibleSpace: new FlexibleSpaceBar(
          background: new Stack(
            fit: StackFit.expand,
            children: <Widget>[
              new Hero(
                  tag: shot.id,
                  child: new Image.network(
                      shot.images.normal, fit: BoxFit.cover,
                      height: appBarHeight)),
              const DecoratedBox(
                decoration: const BoxDecoration(
                  gradient: const LinearGradient(
                    begin: const Alignment(0.0, -1.0),
                    end: const Alignment(0.0, -0.4),
                    colors: const <Color>[
                      const Color(0x60000000), const Color(0x00000000)],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildCountContainer() {
    const fontSize = 13.0;
    final textStyle = const TextStyle(
        color: FDColors.fontSubTitleColor, fontSize: fontSize);
    final padding = const EdgeInsets.only(left: 3.0);
    return new Container(
        padding: const EdgeInsets.only(
            top: 5.0, left: 10.0, right: 10.0, bottom: 5.0),
        decoration: new BoxDecoration(
          border: new Border(
              bottom: new BorderSide(
                  color: FDColors.dividerColor, width: 0.5)),
        ),
        child: new Row(
            children: <Widget>[
              new Icon(Icons.visibility, size: 14.0,
                  color: FDColors.fontSubTitleColor),
              new Expanded(child:
              new Padding(
                  padding: padding, child: new Text(
                  shot.viewsCount.toString(), style: textStyle))),
              new Icon(
                  Icons.chat_bubble, size: fontSize,
                  color: FDColors.fontSubTitleColor),
              new Expanded(child: new Padding(
                  padding: padding, child: new Text(
                  shot.commentsCount.toString(), style: textStyle))),
              new Icon(
                  Icons.favorite, size: fontSize,
                  color: FDColors.fontSubTitleColor),
              new Padding(
                  padding: padding, child: new Text(
                  shot.likesCount.toString(), style: textStyle)),
            ]
        ));
  }


}