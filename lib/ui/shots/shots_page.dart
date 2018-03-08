import 'package:flutter/material.dart';
import 'package:flutter_drib/ui/fdDrawer.dart';
import 'package:flutter_drib/ui/shots/shot_list_page.dart';

// Shots page. Including two tabs: 'poplar' and 'recent'
class ShotsPage extends StatelessWidget {

  final _tabs = [ new Tab(text: "POPULAR"), new Tab(text: "RECENT")];

  final popularPage = new ShotListPage(
      shotType: ShotListPage.SHOT_TYPE_POPULAR);

  final recentPage = new ShotListPage(shotType: ShotListPage.SHOT_TYPE_RECENT);

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(length: _tabs.length, child: new Scaffold(
      appBar: new AppBar(
        title: new Text("SHOTS"),
        bottom: new TabBar(tabs: _tabs),
      ),
      body: _buildBody,
      drawer: new FDDrawer(),
    ));
  }

  Widget get _buildBody {
    return new TabBarView(
      children: <Widget>[
        popularPage,
        recentPage
      ],
    );
  }
}