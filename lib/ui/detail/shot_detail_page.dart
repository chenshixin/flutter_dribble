import 'package:flutter/material.dart';
import 'package:flutter_drib/api/shots/shotsApi.dart';
import 'package:flutter_drib/model/dribbble_comment.dart';
import 'package:flutter_drib/model/dribbble_shot.dart';
import 'package:flutter_drib/ui/basic/fdColors.dart';
import 'package:flutter_drib/ui/detail/comment_item.dart';
import 'package:flutter_drib/ui/user/user_page.dart';

class ShotDetailPage extends StatefulWidget {

  final DribbbleShot shot;

  ShotDetailPage({Key key, this.shot})
      : assert (shot != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new ShotDetailPageState(shot);
  }

}

class ShotDetailPageState extends State<ShotDetailPage> {

  final DribbbleShot shot;

  List<DribbbleComment> _comments = [];

  var isLoadingComments = true;

  ShotDetailPageState(this.shot)
      : assert (shot != null),
        super();

  @override
  void initState() {
    super.initState();
    fetchShots();
  }

  void fetchShots() {
    new ShotsApi()
        .getCommentByShot(shot.id)
        .then((comments) =>
        this.setState(() {
          _comments = comments;
          isLoadingComments = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    final appBarHeight = 250.0;
    return new Scaffold(
        appBar: new AppBar(title: new Text(shot.title), actions: <Widget>[
          new IconButton(icon: new Icon(Icons.share),
              tooltip: "Share",
              onPressed: () {}),
        ],),
        body: new CustomScrollView(
            slivers: <Widget>[
              _buildImageContainer(appBarHeight),
              new SliverList(delegate: new SliverChildListDelegate(
                  _getContents(context).toList()))
            ]
        )
    );
  }

  List<Widget> _getContents(BuildContext context) {
    var result = [_getHeader(context)];
    if (isLoadingComments) {
      result.add(new Center(child: new CircularProgressIndicator(),));
    } else if (_comments.isNotEmpty) {
      //Divider line
      result.add(new Container(
        decoration: new BoxDecoration(
          border: new Border(
              bottom: new BorderSide(
                  color: FDColors.dividerColor, width: 0.5)),
        ),
      ));
      result.addAll(_comments.map((DribbbleComment comment) {
        return new CommentItem(comment: comment);
      }).toList());
    }
    return result;
  }

  Widget _getHeader(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.symmetric(
          vertical: 18.0, horizontal: 16.0),
      child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            _buildCountAndDateContainer(),
            _buildUserInfo(context),
            _buildTagContainer()
          ]
      ),
    );
  }

  Widget _buildTitle() {
    var titleTextStyle = new TextStyle(
        fontWeight: FontWeight.bold,
        color: FDColors.fontTitleColor,
        fontSize: 13.0);
    return new Text(shot.title,
        style: titleTextStyle);
  }

  Container _buildUserInfo(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.only(top: 16.0),
      child: new GestureDetector(
        child: new Row(
          children: <Widget>[
            new Hero(
                tag: shot.user.id,
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(shot.user.avatarUrl),
                  radius: 16.0,
                )),
            new Flexible(
              child: new Container(
                  margin: const EdgeInsets.only(left: 8.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(shot.user.name, style: new TextStyle(
                          fontSize: 12.0, color: FDColors.fontTitleColor),),
                      new Text(
                        shot.user.location == null ? "" : shot.user.location,
                        style: new TextStyle(
                            fontSize: 10.0,
                            color: FDColors.fontSubTitleColor),),
                    ],)),)
          ],
        ),
        onTap: () {
          _gotoUserPage(context);
        },
      ),
    );
  }

  void _gotoUserPage(BuildContext context) {
    Navigator.push(
        context,
        new MaterialPageRoute(builder: (BuildContext context) {
          return new UserPage(
              user: shot.user, bgImgUrl: this.shot.images.normal);
        }));
  }

  SliverAppBar _buildImageContainer(double appBarHeight) {
    return new SliverAppBar(
        expandedHeight: appBarHeight,
        //Set false to hide leading(back button)
        automaticallyImplyLeading: false,
        flexibleSpace: new FlexibleSpaceBar(
          background: new Stack(
            fit: StackFit.expand,
            children: <Widget>[
              new Hero(
                  tag: shot.id,
                  child: new Image.network(
                      shot.images.normal, fit: BoxFit.cover,
                      height: appBarHeight)),
            ],
          ),
        ));
  }

  Widget _buildCountAndDateContainer() {
    const fontSize = 11.0;
    final textStyle = const TextStyle(
        color: FDColors.fontTipColor, fontSize: fontSize);
    //Spacing between counts
    final spacingOuter = const EdgeInsets.only(left: 16.0);
    //Space between icon and number
    final spacingInner = const EdgeInsets.only(left: 4.0);
    return new Container(
        margin: const EdgeInsets.only(top: 15.0),
        child: new Row(
            children: <Widget>[
              new Text("2018.03.1", style: textStyle),
              new Padding(
                padding: spacingOuter,
                child: new Icon(Icons.visibility, size: 14.0,
                    color: FDColors.fontSubTitleColor),
              ),
              new Padding(
                  padding: spacingInner, child: new Text(
                  shot.viewsCount.toString(), style: textStyle)),
              new Padding(
                  padding: spacingOuter,
                  child: new Icon(
                      Icons.chat_bubble, size: fontSize,
                      color: FDColors.fontSubTitleColor)),
              new Padding(
                  padding: spacingInner, child: new Text(
                  shot.commentsCount.toString(), style: textStyle)),
              new Padding(
                  padding: spacingOuter,
                  child: new Icon(
                      Icons.favorite, size: fontSize,
                      color: FDColors.fontSubTitleColor)),
              new Padding(
                  padding: spacingInner, child: new Text(
                  shot.likesCount.toString(), style: textStyle)),
            ]
        ));
  }

  Widget _buildTagContainer() {
    if (shot.tags.isEmpty) {
      return new Text("");
    }
    final tagTextStyle = const TextStyle(
        color: FDColors.fontTipColor, fontSize: 12.0);
    var tags = shot.tags.map((String tag) {
      return new Text(tag,
          style: tagTextStyle);
    }).toList();
    //Insert label
    tags.insert(0, new Text("Tags: ", style: const TextStyle(
        color: FDColors.fontContentColor, fontSize: 13.0),));
    return new Container(
      margin: const EdgeInsets.only(top: 12.0),
      child: new Wrap(
          spacing: 8.0,
          runSpacing: 3.0,
          children: tags),
    );
  }


}