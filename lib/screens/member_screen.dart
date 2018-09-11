import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
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

  String barcode;
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
              child: new Text(
                'ยืนยัน',
                style: TextStyle(fontSize: 20.0, color: Colors.red),
              ),
              onPressed: () async {
                await databaseHelper.remove(id);
                getMembers();
                Navigator.of(context).pop();

//                                  removeMembers(members[index]['id']);
//                                  Navigator.of(context).pop();
              },
            ),
            new FlatButton(
//                color: Colors.red,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'ยกเลิก',
                  style: TextStyle(fontSize: 20.0, color: Colors.green),
                )),
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
    Future scan() async {
      try {
        String barcode = await BarcodeScanner.scan();
//        setState(() => this.barcode = barcode);
        print('-------------------');
        print(barcode);
        print('-------------------');
      } on PlatformException catch (e) {
        if (e.code == BarcodeScanner.CameraAccessDenied) {
          setState(() {
            this.barcode = 'The user did not grant the camera permission!';
          });
        } else {
          setState(() => this.barcode = 'Unknown error: $e');
        }
      } on FormatException {
        setState(() => this.barcode =
            'null (User returned using the "back"-button before scanning anything. Result)');
      } catch (e) {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Member'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.photo_camera), onPressed: () => scan())
        ],
      ),
      body: ListView.builder(
          itemBuilder: (context, int index) {
            return ListTile(
                onTap: () async {
                  var response = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddMemberScreen(members[index]['id'])));
                  if (response != null) {
                    getMembers();
                  }
                },
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
              MaterialPageRoute(builder: (context) => AddMemberScreen(null)));
          if (response != null) {
            getMembers();
          }
        },
        child: Icon(Icons.person_add),
      ),
    );
  }
}
