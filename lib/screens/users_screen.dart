import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  bool isLoading = true;
  var users;
  Future<Null> getUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.get('token');
    // final คือ ตัวแปลที่ไม่สามารถ เปลี่ยนค่าได้
//    final response = await http.get('https://randomuser.me/api/?results=40');
    final response =
        await http.get('http://172.50.42.166:3000/users?token=$token');

    if (response.statusCode == 200) {
      var jsonRes = json.decode(response.body);
      print(jsonRes);
      //////// แปลง json จากเวป มาเข้าตัวแปรในรูปแบบที่ dart เข้าใจ ใช้ setstat

      setState(() {
        isLoading = false;
        users = jsonRes['rows'];
      });
    } else {
      // If that response was not OK, throw an error.
      print('Connection Error');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: Card(
        child: RefreshIndicator(
          onRefresh: getUsers,
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, int index) {
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              '${users[index]['picture']['medium']}'),
                        ),
                        onTap: () {},
                        title: Text(
                          '${users[index]['name']['first']} ${users[index]['name']['last']}',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        subtitle: Text('${users[index]['email']}'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                    );
                  },
                  // ถ้า users ไม่เท่ากับ null ให้ใช้ lemgth ถ้าว่าง ใส่ 0
                  itemCount: users != null
                      ? users.length
                      : 0, //เป็นตัวกำหนดว่าจะ แสดงที่ตัว
                ),
        ),
      ),
    );
  }
}
