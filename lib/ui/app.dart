import 'package:flutter/material.dart';
import 'package:flutter_drib/ui/shots/shots_page.dart';
import 'basic/fdThemeData.dart';

//Main app
class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'FlutterDrib',
      theme: fdThemeData,
      home: new ShotsPage(),
    );
  }
}