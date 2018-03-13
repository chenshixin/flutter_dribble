import 'package:flutter/material.dart';
import 'package:flutter_drib/api/shots/user_api.dart';
import 'package:flutter_drib/model/dribbble_shot.dart';
import 'package:flutter_drib/model/dribbble_user.dart';
import 'package:flutter_drib/ui/basic/fdColors.dart';
import 'package:flutter_drib/ui/items/grid_shot_item.dart';
import 'package:flutter_drib/ui/shots/shot_list_page.dart';

class UserPage extends StatefulWidget {

  final DribbbleUser user;

  final String bgImgUrl;

  UserPage({Key key, this.user, this.bgImgUrl}) : super(key: key);

  final userShots = new ShotListPage(
      shotType: ShotListPage.SHOT_TYPE_POPULAR);


  @override
  State createState() {
    return new UserPageState(user, bgImgUrl);
  }

}

class UserPageState extends State<UserPage> {

  List<DribbbleShot> _shots = [];

  final DribbbleUser user;
  final String bgImgUrl;


  UserPageState(this.user, this.bgImgUrl) : super();

  @override
  void initState() {
    super.initState();
    fetchShots();
  }

  void fetchShots() {
    new UserApi()
        .getShotsByUser(user, 20)
        .then((shots) =>
        this.setState(() {
          _shots = shots;
        }));
  }

  @override
  Widget build(BuildContext context) {
    final appBarHeight = 250.0;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(user.name),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.mail, color: FDColors.fontSubTitleColor,),
              onPressed: () {}),
          new FlatButton(child: new Text("Follow", style: new TextStyle(
              color: FDColors.fontSubTitleColor, fontSize: 17.0),),
              onPressed: () {}),
        ],
      ),
      body: new CustomScrollView(
          slivers: <Widget>[
            _buildUserInfoContainer(appBarHeight),
            new SliverPadding(
                padding: new EdgeInsets.all(12.0),
                sliver: new SliverGrid.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                    children: _shots.map((DribbbleShot shot) {
                      return new GridShotItem(shot: shot);
                    }).toList())
            )
          ]
      ),
    );
  }

  SliverAppBar _buildUserInfoContainer(double appBarHeight) {
    return new SliverAppBar(
        expandedHeight: appBarHeight,
        //Set false to hide leading(back button)
        automaticallyImplyLeading: false,
        flexibleSpace: new FlexibleSpaceBar(
            background:
            new Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new NetworkImage(bgImgUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: new Container(
                  child: new Container(
                    padding: new EdgeInsets.only(
                        top: 40.0, left: 20.0, right: 20.0, bottom: 20.0),
                    decoration: new BoxDecoration(
                        gradient: new LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [new Color(0xCCFFFFFF), Colors.white])
                    ),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new CircleAvatar(
                            backgroundImage: new NetworkImage(user.avatarUrl),
                            radius: 40.0
                        ),
                        new Container(
                            margin: new EdgeInsets.only(top: 10.0),
                            child: new Text(user.name, maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                  fontSize: 18.0,
                                  color: FDColors.fontTitleColor,
                                  fontWeight: FontWeight.w500),)
                        ),
                        new Container(
                          margin: new EdgeInsets.only(top: 5.0),
                          child: new Text(user.location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                                fontSize: 11.0,
                                color: FDColors.fontTitleColor),),),
                        new Container(
                            margin: new EdgeInsets.only(top: 5.0),
                            child: new Text(
                              user.bio, textAlign: TextAlign.center,
                              style: new TextStyle(
                                  fontSize: 11.0,
                                  color: FDColors.fontTitleColor),)),
                      ],
                    ),
                  ),
                )
            )
        )
    );
  }


}