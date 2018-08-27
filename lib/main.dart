import 'package:flutter/material.dart';
import 'package:my_app/screens/add_member_screen.dart';
import 'package:my_app/screens/add_screen.dart';
import 'package:my_app/screens/home_screen.dart';
import 'package:my_app/screens/login_screen.dart';
import 'package:my_app/screens/main_screen.dart';
import 'package:my_app/screens/member_screen.dart';
import 'package:my_app/screens/page_one.dart';
import 'package:my_app/screens/users_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/utils/database_helper.dart';

void main() {
  DatabaseHelper databaseHelper = DatabaseHelper.internal();
  databaseHelper.initDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Lamoon',
          scaffoldBackgroundColor: Colors.white70,
          primaryColor: Colors.amber,
          accentColor: Colors.amberAccent),
      title: 'My App',
      home: LoginScreen(),
      routes: <String, WidgetBuilder>{
        '/add': (BuildContext context) => AddScreen('Hello'),
        '/detail': (BuildContext context) => PageOne(),
        '/userlist': (BuildContext context) => UsersScreen(),
        '/member': (BuildContext context) => MemberScreen(),
        '/add-member': (BuildContext context) => AddMemberScreen(),
      },
    );
  }
}
