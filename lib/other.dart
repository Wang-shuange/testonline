import 'package:flutter/material.dart';

class OtherPage extends StatefulWidget {
  static const String tag = "/other";
  @override
  _OtherPageState createState() => new _OtherPageState();
}

class _OtherPageState extends State<OtherPage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: new Center(
          child: Text('other'),
        ),
      ),
    );
  }
}
