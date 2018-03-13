import 'package:flutter/material.dart';
import 'package:flutter_drib/api/shots/shotsApi.dart';
import 'package:flutter_drib/model/dribbble_shot.dart';
import 'package:flutter_drib/ui/basic/fdColors.dart';
import 'package:flutter_drib/ui/items/grid_shot_item.dart';

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