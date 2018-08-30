import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/utils/database_helper.dart';

class AddMemberScreen extends StatefulWidget {
  @override
  _AddMemberScreenState createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper.internal();
  DateTime birthDate;
  String strBirthDate;
  final _formkey = GlobalKey<FormState>();
  TextEditingController ctrFirstName = TextEditingController();
  TextEditingController ctrLastName = TextEditingController();
  TextEditingController ctrEmailName = TextEditingController();
  TextEditingController ctrTelephone = TextEditingController();
  String sex = 'ชาย';
  bool isActive = true;
  @override
  Widget build(BuildContext context) {
    DateTime _currentDate;
    int _year = DateTime.now().year;
    int _month = DateTime.now().month;
    int _day = DateTime.now().day;

    Future<Null> _showDatePicker() async {
      final DateTime picked = await showDatePicker(
          locale: const Locale('th'),
          context: context,
          initialDate: DateTime(_year, _month, _day),
          firstDate: new DateTime(1920, 1, 1),
          lastDate: new DateTime(_year, _month, _day));
      if (picked != null && picked != _currentDate) {
        setState(() {
          var strDate = new DateFormat.MMMMd('th_TH')
              .format(new DateTime(picked.year, picked.month, picked.day));
          strBirthDate = '$strDate ${picked.year+543}';
          birthDate = picked;
        });
      }
    }

    Future<Null> saveData() async {
      print(ctrFirstName.text);
      print(ctrLastName.text);
      print(ctrEmailName.text);
      print(ctrTelephone.text);
      print(sex);
      print(birthDate);
      print(isActive);
      if (_formkey.currentState.validate() && birthDate != null) {
        Map member = {
          'firstName': ctrFirstName.text,
          'lastName': ctrLastName.text,
          'email': ctrEmailName.text,
          'telephone': ctrTelephone.text,
          'birthDate': birthDate.toString(),
        };
        await databaseHelper.saveData(member);
//        print('ok');
      } else {
        print('Faile');
      }
    }

    String _validateEmail(String value) {
      if (value.isEmpty) return 'กรุณาระบุอีเมล์';

      final RegExp nameExp = new RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
      if (!nameExp.hasMatch(value)) return 'กรุณาระบุให้ถูกรูปแบบ';
      return null;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add new member'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed: () => saveData())
        ],
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //เรียกใชช้ theme defult จาก flutter
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'รายละเอียดสมาชิก',
                    style: TextStyle(fontSize: 30.0, color: Colors.brown),
                  ),
                ),
                Divider(),
                Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Form(
                        key: _formkey,
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'First Name',
                                        labelStyle: TextStyle(fontSize: 20.0)),
                                    controller: ctrFirstName,
                                    validator: (String value) {
                                      if (value.isEmpty)
                                        return 'กรุณาระบุข้อมูล';
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Last name',
                                        labelStyle: TextStyle(fontSize: 20.0)),
                                    controller: ctrLastName,
                                    validator: (String value) {
                                      if (value.isEmpty)
                                        return 'กรุณาระบุข้อมูล';
                                    },
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'birth date',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                FlatButton(
                                    onPressed: () => _showDatePicker(),
                                    child: Text(
                                      strBirthDate ?? 'เลืกวันที่',
                                      style: TextStyle(fontSize: 20.0),
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: TextStyle(fontSize: 20.0)),
                              controller: ctrEmailName,
                              validator: _validateEmail,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  labelText: 'Tel',
                                  labelStyle: TextStyle(fontSize: 20.0)),
                              controller: ctrTelephone,
                              validator: (String value) {
                                if (value.isEmpty) return 'กรุณาระบุข้อมูล';
                              },
                            ),
                            SwitchListTile(
                              value: true,
                              onChanged: (bool value) {
                                setState(() {
                                  isActive = value;
                                });
                              },
                              title: Text('เปิดการใช้งาน'),
                            ),
                            ListTile(
                                title: const Text(
                                  'เพศ',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                trailing: new DropdownButton<String>(
                                  value: sex,
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.black),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      sex = newValue;
                                    });
                                  },
                                  items: <String>['ชาย', 'หญิง']
                                      .map((String value) {
                                    return new DropdownMenuItem<String>(
                                      child: Container(
                                        child: new Text(value),
                                        width: 120.0,
                                      ),
                                      value: value,
                                    );
                                  }).toList(),
                                ))
                          ],
                        ))),
              ],
            ),
          )
        ],
      ),
    );
  }
}
