import 'package:flutter/material.dart';

class EnglishPage extends StatefulWidget{
    static const String tag = "/english";
  @override
   _EnglishPageState createState() => new _EnglishPageState();
}
class _EnglishPageState extends State<EnglishPage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: new Center(
          child: new Text('english'),
        ),
      ),
    );
  }
}