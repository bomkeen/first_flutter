import 'dart:async';

import 'package:flutter/material.dart';

class AddMemberScreen extends StatefulWidget {
  @override
  _AddMemberScreenState createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  @override
  Widget build(BuildContext context) {
    Future<Null> _showDatePicker() async {
      DateTime _currentDate;
      Future<Null> _showDatePicker() async {
        final DateTime picked = await showDatePicker(
            locale: const Locale('th'),
            context: context,
            initialDate: DateTime(1920, 1, 1),
            firstDate: new DateTime(1920, 1, 1),
            lastDate: new DateTime(2018));
        if (picked != null && picked != _currentDate) {
          setState(() {});
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add new member'),
        actions: <Widget>[IconButton(icon: Icon(Icons.save), onPressed: () {})],
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
                        child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'First Name',
                                    labelStyle: TextStyle(fontSize: 20.0)),
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
                              'Birth date',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            FlatButton(
                                onPressed: () => _showDatePicker(),
                                child: Text(
                                  '27/08/2018',
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
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              labelText: 'Tel',
                              labelStyle: TextStyle(fontSize: 20.0)),
                        ),
                        SwitchListTile(
                          value: true,
                          onChanged: (bool value) {},
                          title: Text('เปิดการใช้งาน'),
                        ),
                        ListTile(
                            title: const Text(
                              'เพศ',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            trailing: new DropdownButton<String>(
                              value: 'ชาย',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.black),
                              onChanged: (String newValue) {},
                              items:
                                  <String>['ชาย', 'หญิง'].map((String value) {
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
