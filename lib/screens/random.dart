import 'package:flutter/material.dart';
import 'dart:math' as math;

class Random extends StatefulWidget {
  @override
  _RandomState createState() => _RandomState();
}

class _RandomState extends State<Random> {
  List colors = [Colors.red, Colors.green, Colors.yellow, Colors.brown];
  Random random = new Random();

  int index = 0;
  void changeIndex() {
    setState(() => index = math.Random().nextInt(4));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: RaisedButton(
      onPressed: () => changeIndex(),
      child: Text('Click'),
      color: colors[index],
    ));
  }
}
