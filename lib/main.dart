import 'package:flutter/material.dart';

void main() => runApp(new MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'FlutterDrib',
      theme: new ThemeData(primarySwatch: Colors.blue,
      ),
      home: new MyHomePage.HomePage(title: 'FlutterDrib'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage.HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
          child: new Text("Hello")
      ),
      drawer: new Drawer(child: new Column(
        children: <Widget>[
          new UserAccountsDrawerHeader(accountName: new Text("Login"),
              accountEmail: new Text("Tap to login"),
              currentAccountPicture: new CircleAvatar(
                  backgroundColor: Colors.grey)),
          new ListTile(
              leading: new Icon(Icons.camera_alt, color: Colors.orange),
              title: new Text("SHOTS")),
          new ListTile(
              leading: new Icon(Icons.favorite, color: Colors.pink),
              title: new Text("USER LIKES")),
          new ListTile(
              leading: new Icon(Icons.group, color: Colors.green),
              title: new Text("FOLLOWING")),
          new ListTile(
              leading: new Icon(Icons.help, color: Colors.blue),
              title: new Text("APPI INFO")),
          new ListTile(
              leading: new Icon(Icons.exit_to_app, color: Colors.grey),
              title: new Text("LOG OUT"))
        ],
      )),
    );
  }
}
