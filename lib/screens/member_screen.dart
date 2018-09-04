import 'dart:async';

import 'package:flutter/material.dart';
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
    await databaseHelper.remove(id);
    getMembers();
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
                    onPressed: () => removeMembers(members[index]['id'])));
          },
          itemCount: members != null ? members.length : 0),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/add-member'),
        child: Icon(Icons.person_add),
      ),
    );
  }
}
