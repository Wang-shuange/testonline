import 'package:flutter/material.dart';

class ChinesePage extends StatefulWidget{
    static const String tag = "/chinese";
  @override
   _ChinesePageState createState() => new _ChinesePageState();
}

class _ChinesePageState extends State<ChinesePage> {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(

        body: new Center(
          child: new Text('chinese'),
        ),
      ),
    );
  }
}