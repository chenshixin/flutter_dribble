import 'package:flutter/material.dart';
import 'package:flutter_drib/model/dribbble_shot.dart';
import 'package:flutter_drib/ui/basic/fdColors.dart';
import 'package:flutter_drib/ui/detail/shot_detail_page.dart';

class GridShotItem extends StatelessWidget {

  final titleTextStyle = new TextStyle(
    color: FDColors.fontTitleColor, fontSize: 13.0,);

  final usernameTextStyle = new TextStyle(
      fontSize: 11.0, color: FDColors.fontTitleColor);

  final DribbbleShot shot;

  GridShotItem({Key key, this.shot})
      :assert(shot != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        onTap: () {
          _gotoShotPage(context);
        },
        child: _buildGridItem()
    );
  }

  void _gotoShotPage(BuildContext context) {
    Navigator.push(
        context,
        new MaterialPageRoute(builder: (BuildContext context) {
          return new ShotDetailPage(shot: shot);
        }));
  }

  Widget _buildGridItem() {
    var itemContent = <Widget>[new Hero(
        tag: shot.id,
        child: new DecoratedBox(
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(5.0),
            image: new DecorationImage(
              image: new NetworkImage(
                  shot.images.normal),
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
        )),
    ];
    if (shot.animated) {
      itemContent.add(new Container(
        alignment: AlignmentDirectional.topEnd,
        margin: const EdgeInsets.only(top: 8.0, right: 8.0),
        child: new Image.asset("assets/images/ic_gif.png",
            width: 24.0,
            height: 16.0),
      ));
    }
    return new Stack(
      fit: StackFit.expand,
      children: itemContent,
      alignment: AlignmentDirectional.topEnd,
    );
  }

}