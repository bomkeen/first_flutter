import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_app/screens/add_screen.dart';
import 'package:my_app/screens/page_one.dart';
import 'package:my_app/screens/page_two.dart';
import 'package:my_app/screens/page_three.dart';
import 'package:my_app/screens/random.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List pages = [PageOne(), PageTwo(), PageThree(), Random()];
  bool hasimage = true;

  Future<Null> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.get('token');
    print(token);
  }

  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    Widget appBar = AppBar(
      title: Text(
        'ทอสอบโปรแกรม',
        style: TextStyle(fontSize: 30.0, color: Colors.white70),
      ),
      actions: <Widget>[
        IconButton(
            color: Colors.amberAccent,
            icon: Icon(Icons.home),
            onPressed: () => Navigator.of(context).pushNamed('/detail')),
        IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () => Navigator.of(context).pushNamed('/add'))
      ],
    );
    Widget floatingAction = FloatingActionButton(
        onPressed: () async {
          var response = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddScreen('Hllo')));
          if (response != null) {
            print(response['name']);
          }
        },
        child: Icon(Icons.add));
    Widget bottomNavBar;

    bottomNavBar = BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              backgroundColor: Colors.green,
              icon: Icon(Icons.home),
              title: Text('หน้าหลัก')),
          BottomNavigationBarItem(
              backgroundColor: Colors.green,
              icon: Icon(Icons.account_circle),
              title: Text('ข้อมูลส่วนตัว')),
          BottomNavigationBarItem(
              backgroundColor: Colors.green,
              icon: Icon(Icons.settings),
              title: Text('ตั้งค่า')),
          BottomNavigationBarItem(
              backgroundColor: Colors.green,
              icon: Icon(Icons.vpn_key),
              title: Text('ซุ่ม'))
        ]);

    Widget drawer = Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: hasimage
                ? CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://randomuser.me/api/portraits/med/men/99.jpg'),
                  )
                : CircleAvatar(
                    backgroundColor: Colors.white70,
                    child: Text(
                      'BK',
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent),
                    ),
                  ),
            accountName: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'bomkeen',
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
            ),
            accountEmail: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('bomkeen@mail.com',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.red,
                      fontWeight: FontWeight.bold)),
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/pic1.jpg'))),
          ),
          ListTile(
//            หัว

            leading: Icon(Icons.home),
            title: Text(
              'หน้าหลัก',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            subtitle: Text('ทดสอบข้อมูลประกอบ'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {},
          ),
          ListTile(
//            หัว

            leading: Icon(Icons.settings),
            title: Text(
              'ตั้งค่าการใช้งาน',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {},
          ),
          ListTile(
//            หัว

            leading: Icon(Icons.account_circle),
            title: Text(
              'ข้อมูลผู้ใช้งาน',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
//            subtitle: Text('ทดสอบข้อมูลประกอบ'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {},
          ),
          Divider(),
          ListTile(
//            leading: Icon(Icons.exit_to_app),
            title: Text(
              'ออกจากโปรแกรม',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            trailing: Icon(Icons.exit_to_app),
            onTap: () {
              exit(0);
            },
          ),
          ListTile(
            leading: Icon(Icons.group_add),
            title: Text(
              'ผู้ใช้งาน',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            subtitle: Text('ข้อมูลผู้ใช้งานในระบบ'),
            trailing: Icon(Icons.exit_to_app),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/userlist');
            },
          ),
          ListTile(
            leading: Icon(Icons.person_add),
            title: Text(
              'สมาชิก(member)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            subtitle: Text('สมาชิก'),
            trailing: Icon(Icons.exit_to_app),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/member');
            },
          ),
        ],
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: pages[currentIndex],
      drawer: drawer,
      floatingActionButton: floatingAction,
      bottomNavigationBar: bottomNavBar,
    );
  }
}
