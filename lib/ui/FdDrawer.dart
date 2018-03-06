import 'package:flutter/material.dart';

// Drawer for this app.
// Including header(user info) and list of feature entries
class FDDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Drawer(child: new Column(
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
    ));
  }
}