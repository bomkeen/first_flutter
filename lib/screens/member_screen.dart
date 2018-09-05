import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_app/screens/add_member_screen.dart';
import 'package:my_app/utils/database_helper.dart';

class MemberScreen extends StatefulWidget {
  @override
  _MemberScreenState createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper.internal();
  List members = [];
  Future getMembers() async {
    var res = await databaseHelper.getList();
    print(res);
    setState(() {
      members = res;
    });
  }

  Future removeMembers(int id) async {
    showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('คุณต้องการลบข้อมูลใช่หรือไม่'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text(
                  'คุณต้องการลบข้อมมูลใช่หรือไม่',
                  style: TextStyle(fontSize: 20.0, color: Colors.red),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('ยืนยัน'),
              onPressed: () async {
                await databaseHelper.remove(id);
                getMembers();
                Navigator.of(context).pop();

//                                  removeMembers(members[index]['id']);
//                                  Navigator.of(context).pop();
              },
            ),
            new FlatButton(
                color: Colors.red,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('ยกเลิก')),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Member'),
      ),
      body: ListView.builder(
          itemBuilder: (context, int index) {
            return ListTile(
                onTap: () {},
                title: Text(
                    '${members[index]['first_name']}${members[index]['last_name']}'),
                subtitle: Text('${members[index]['email']}'),
                trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      removeMembers(members[index]['id']);
                    }));
          },
          itemCount: members != null ? members.length : 0),
      floatingActionButton: FloatingActionButton(
        //// ใช้แบบนี เพราะมีการส่งค่า กลับบมา ตอนกด save
        onPressed: () async {
          var response = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddMemberScreen()));
          if (response != null) {
            getMembers();
          }
        },
        child: Icon(Icons.person_add),
      ),
    );
  }
}
