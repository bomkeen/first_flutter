import 'package:flutter/material.dart';
import 'package:my_app/screens/home_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController ctrlUsername = TextEditingController();
  TextEditingController ctrlPassword = TextEditingController();
  Future<Null> doLogin() async {
    // final คือ ตัวแปลที่ไม่สามารถ เปลี่ยนค่าได้
    final response = await http.post('http://172.50.42.166:3000/login',
        body: {'username': ctrlUsername.text, 'password': ctrlPassword.text});

    if (response.statusCode == 200) {
      var jsonRes = json.decode(response.body);
      print(jsonRes);
      if (jsonRes['ok']) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', jsonRes['token']);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        showDialog<Null>(
            context: context,
            builder: (BuildContext context) {
              return new SimpleDialog(
                title: const Text('เกิดข้อผิดพลาด'),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'เกิดข้อผิดพลาดในการ login',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  new SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'ตกลง',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                ],
              );
            });
      }
      //////// แปลง json จากเวป มาเข้าตัวแปรในรูปแบบที่ dart เข้าใจ ใช้ setstat

    } else {
      showDialog<Null>(
          context: context,
          builder: (BuildContext context) {
            return new SimpleDialog(
              title: const Text('เกิดข้อผิดพลาด'),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'จากการเชื่อมต่อ',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ),
                new SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'ตกลง',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            );
          });
    }
  }

  void _doLogin() {
    print(ctrlUsername.text);
    print(ctrlPassword.text);

    if (ctrlUsername.text == 'admin' && ctrlPassword.text == 'admin') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  Future<Null> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.get('token');
    if (token != Null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (contex) => HomeScreen()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            color: Colors.redAccent,
          ),
          ListView(
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 50.0,
                    ),
                    Image(
                      image: AssetImage('assets/images/lucky.jpg'),
                      height: 150.0,
                      width: 150.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Form(
                          child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: ctrlUsername,
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.black38),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                labelText: 'Email',
                                filled: true,
                                fillColor: Colors.white70),
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            controller: ctrlPassword,
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.black38),
                            //// บอกว่า ฟิลนี้คือ password
                            obscureText: true,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.vpn_key),
                                labelText: 'Password',
                                filled: true,
                                fillColor: Colors.white70),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Material(
                            borderRadius:
                                BorderRadius.all(const Radius.circular(30.0)),
                            shadowColor: Colors.redAccent.shade100,
                            elevation: 5.0,
                            child: MaterialButton(
                              minWidth: 290.0,
                              height: 55.0,
                              onPressed: () => doLogin(),
                              color: Colors.white70,
                              child: Text(
                                'ลงชื่อเข้าใช้งาน',
                                style: new TextStyle(
                                    color: Colors.red,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 0.3),
                              ),
                            ),
                          ),
                          FlatButton(
                              onPressed: () {},
                              child: Text(
                                'Register new user',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 20.0),
                              ))
                        ],
                      )),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
