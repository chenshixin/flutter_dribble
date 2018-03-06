import 'package:flutter/material.dart';
import 'package:flutter_drib/ui/FdDrawer.dart';

// Shots page. Including two tabs: 'poplar' and 'recent'
class ShotsPage extends StatelessWidget {

  final String title;

  final _tabs = [ new Tab(text: "POPULAR"), new Tab(text: "RECENT")];

  ShotsPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(length: _tabs.length, child: new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
        bottom: new TabBar(tabs: _tabs),
      ),
      body: _buildBody,
      drawer: new FDDrawer(),
    ));
  }

  Widget get _buildBody {
    return new TabBarView(
      children: <Widget>[
        new Text("Popular"),
        new Text("Recent")
      ],
    );
  }
}
