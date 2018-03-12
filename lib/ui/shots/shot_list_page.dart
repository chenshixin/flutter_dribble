import 'package:flutter/material.dart';
import 'package:flutter_drib/api/shots/shotsApi.dart';
import 'package:flutter_drib/model/dribbble_shot.dart';
import 'package:flutter_drib/ui/basic/fdColors.dart';
import 'package:flutter_drib/ui/detail/shot_detail_page.dart';

class ShotListPage extends StatefulWidget {

  static const SHOT_TYPE_POPULAR = "views";
  static const SHOT_TYPE_RECENT = "recent";

  final String shotType;

  ShotListPage({Key key, this.shotType}) : super(key: key);

  @override
  State createState() {
    return new ShotListPageState(shotType);
  }

}

class ShotListPageState extends State<ShotListPage> {

  List<DribbbleShot> _shots = [];

  final String shotType;

  ShotListPageState(this.shotType) : super();

  @override
  void initState() {
    super.initState();
    fetchShots();
  }

  void fetchShots() {
    new ShotsApi()
        .getShots(shotType, 500)
        .then((shots) =>
        this.setState(() {
          _shots = shots;
        }));
  }

  @override
  Widget build(BuildContext context) {
    var child;
    if (_shots.isEmpty) {
      child = new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      child = new GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          padding: const EdgeInsets.all(12.0),
          children: _shots.map((DribbbleShot shot) {
            return new GridShotItem(shot: shot);
          }).toList()
      );
    }
    return new Container(child: child, color: FDColors.bgColor);
  }

}

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