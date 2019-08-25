import 'package:flutter/material.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _nameController = new TextEditingController(); //create  a texteditcontroller 
  TextEditingController _pwdController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final logo = new Image.asset(
      'assets/app.png',
      width: 150,
      height: 150,
    );

    final name = new TextFormField(
      controller: _nameController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: null,
      decoration: new InputDecoration(
          hintText: 'Name',
          contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0))),
    );

    final password = new TextFormField(
      controller: _pwdController,
      autofocus: false,
      initialValue: null,
      obscureText: true,
      decoration: new InputDecoration(
          hintText: 'Password',
          contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0))),
    );

    final loginButton = new Padding(
      padding: new EdgeInsets.symmetric(vertical: 1.0),
      child: new Material(
        borderRadius: BorderRadius.circular(32.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: new MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
          minWidth: 100.0,
          height: 45.0,
          onPressed: () {
            if (_nameController.text.isEmpty) {
              new MyDialog(
                textShow: '用户名不能为空！',
              )._show(context);
              return;
            }

            if (_pwdController.text.isEmpty) {
              new MyDialog(
                textShow: '密码不能为空！',
              )._show(context);
              return;
            }

            Navigator.of(context).pushNamed(HomePage.tag);
          },
          color: Colors.orange,
          child: new Text(
            'Login',
            style: new TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );

    final forgetLabel = new FlatButton(
      onPressed: () {},
      child: new Text(
        'Forget Password?',
        style: new TextStyle(color: Colors.black54),
      ),
    );
    final titleLabel = new Text('少儿在线考试系统',
        style: TextStyle(
            fontFamily: 'Noto Sans CJK TC DemiLight',
            color: Colors.grey,
            fontSize: 20,
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.center);
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Center(
        child: new Center(
          child: new ListView(
            shrinkWrap: true,
            padding: new EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo,
              SizedBox(height: 10.0),
              titleLabel,
              SizedBox(
                height: 50,
              ),
              name,
              SizedBox(
                height: 8.0,
              ),
              password,
              SizedBox(
                height: 24.0,
              ),
              loginButton,
              forgetLabel
            ],
          ),
        ),
      ),
    );
  }
}

class MyDialog extends Dialog {
  MyDialog({Key key, this.textShow}) : super(key: key);
  final String textShow;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; //屏幕宽度
    double screenHeight = MediaQuery.of(context).size.height; //屏幕高度
    double mHorizontalMargin = 45.0; //水平间距
    double verticalMargin =
        (screenHeight - (screenWidth - 2 * mHorizontalMargin) * 3 / 4) /
            2; //垂直间距
    return Container(
      margin: EdgeInsets.only(
          left: mHorizontalMargin,
          right: mHorizontalMargin,
          top: verticalMargin,
          bottom: verticalMargin),
      height: double.minPositive,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))), //圆角
      child: Stack(
        alignment: Alignment(0, 0), //居中对齐
        children: <Widget>[
          Positioned(
              top: 5,
              right: 5,
              child: GestureDetector(
                child: Icon(
                  Icons.close,
                  color: Colors.grey,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              )),
          Positioned(
            top: 40,
            child: Column(
              children: <Widget>[
                Text(
                  '$textShow',
                  style: TextStyle(
                      fontSize: 15,
                      decoration: TextDecoration.none,
                      color: Colors.black87,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
                Container(
                  width: 120,
                  padding: EdgeInsets.only(top: 30),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: Colors.orange,
                    child: Text(
                      '确认',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    shape: StadiumBorder(side: BorderSide.none), //按钮形状
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _show(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return MyDialog(
            textShow: textShow,
          );
        });
  }
}
