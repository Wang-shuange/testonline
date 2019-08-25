import 'package:flutter/material.dart';
class MathPage extends StatefulWidget{
    static const String tag = "/math";
  @override
  State<StatefulWidget> createState() => new _MathPageState();
}
class _MathPageState extends State<MathPage> {


Widget buildListTitle(BuildContext context,String item){
    return new ListTile(
      isThreeLine: true,
      dense: false,
      leading: new CircleAvatar(child: new Text(item),),
      title: new Text('子item的标题'),
      subtitle: new Text('子item的内容'),
      trailing: new Icon(Icons.arrow_right,color: Colors.green,),
    );
  }
  @override
  Widget build(BuildContext context) {
     List<String> items = <String>['A','B','C','D','E','F','G','H','I','J'];
    Iterable<Widget> listTitles = items.map((String item){
      return buildListTitle(context, item);
    });
    listTitles = ListTile.divideTiles(context: context,tiles: listTitles);
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
          body: new Scrollbar(
          child: new ListView(
            children: listTitles.toList(),
          ),
      ),
      ),
    );
  }

//   Widget _getContainer(String test, IconData icon) {
//     return new Container(
//       width: 160.0,
// //      ListTile
//       child: new ListTile(
// //       显示在title之前
//         leading: new Icon(icon),
// //        显示在title之后
//         trailing: new Icon(icon),
//         title: new Text(test),
//         subtitle:new Text("我是subtitle") ,
//       ),
//     );
//   }
}