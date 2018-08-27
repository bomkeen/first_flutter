import 'package:flutter/material.dart';

class PageTwo extends StatefulWidget {
  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image(
                fit: BoxFit.fill, image: AssetImage('assets/images/pic1.jpg')),
            Container(
//          child: Image(image: AssetImage('assets/images/pic1.jpg')),
              height: 100.0,
              color: Colors.red,
            ),
            Container(
              height: 100.0,
              color: Colors.green,
            ),
            Container(
              height: 100.0,
              color: Colors.blueAccent,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 100.0,
                    color: Colors.pinkAccent,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 100.0,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: Image(
                        fit: BoxFit.fitWidth,
                        image: AssetImage('assets/images/pic1.jpg'))),
                Expanded(
                  child: Container(
                    height: 100.0,
                    color: Colors.purpleAccent,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 100.0,
                    color: Colors.indigoAccent,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 100.0,
                    color: Colors.brown,
                  ),
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}
