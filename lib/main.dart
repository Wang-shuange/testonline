import 'package:flutter/material.dart';
import 'package:test_online/chinese.dart';
import 'package:test_online/english.dart';
import 'package:test_online/math.dart';
import 'package:test_online/other.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'screens/settings.dart';
import 'screens/account.dart';
import  'math.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final routes = <String,WidgetBuilder>{
    LoginPage.tag:(context)=>LoginPage(),
    HomePage.tag:(context)=>HomePage(),
    SettingsScreen.tag: (context) => SettingsScreen(),
    AccountScreen.tag: (context) => AccountScreen(),
    MathPage.tag:(context) =>MathPage(),
    ChinesePage.tag:(context) =>ChinesePage(),
    EnglishPage.tag:(context) =>EnglishPage(),
    OtherPage.tag:(context) =>OtherPage(),
  };
   @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Login Page',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Nunito',
      ),
      home: new LoginPage(),
      routes: routes,
    );
  }
}
