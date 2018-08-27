import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  var params;
  AddScreen(this.params);
  @override
  _AddScreenState createState() => _AddScreenState(params);
}

class _AddScreenState extends State<AddScreen> {
  var params;
  _AddScreenState(this.params);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add data screen'),
      ),
      body: ListView(
        children: <Widget>[
          Text('Add data'),
          Text(
            'param: $params',
            style: TextStyle(fontSize: 20.0),
          ),
          RaisedButton(
            color: Colors.pink,
            onPressed: () =>
                Navigator.of(context).pop({'id': 1000, 'name': 'peeragad'}),
            child: Text('Back'),
          )
        ],
      ),
    );
  }
}
