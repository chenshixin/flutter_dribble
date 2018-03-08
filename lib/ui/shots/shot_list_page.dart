import 'package:flutter/material.dart';
import 'package:flutter_drib/api/shots/shotsApi.dart';
import 'package:flutter_drib/model/dribbble_shot.dart';
import 'package:flutter_drib/ui/basic/FdColors.dart';

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
    if (_shots.isEmpty) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return new GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          padding: const EdgeInsets.all(12.0),
          children: _shots.map((DribbbleShot shot) {
            return new GridShotItem(shot: shot);
          }).toList()
      );
    }
  }

}

class GridShotItem extends StatelessWidget {

  final titleTextStyle = new TextStyle(
    color: new Color(0xFF404040), fontSize: 14.0,);

  final usernameTextStyle = new TextStyle(
      fontSize: 11.0, color: new Color(0xFF404040));

  final DribbbleShot shot;

  GridShotItem({Key key, this.shot})
      :assert(shot != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Card(
      elevation: 0.0,
      child: new Column(
        children: <Widget>[
          new Flexible(
              fit: FlexFit.tight,
              child: new Image.network(shot.images.normal, fit: BoxFit.cover)
          ),
          new Container(
              margin: const EdgeInsets.only(top: 2.0),
              child: new Text(shot.title, maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: titleTextStyle,)
          ),
          new Text(shot.user.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: usernameTextStyle)
        ],
      ),
    );
  }

}