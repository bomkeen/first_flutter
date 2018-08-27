import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String firstName = 'peeragad';
  String lastName = 'poonsawat';
  String address = '''
  line 1
  line 2
  line 3
  ''';
  int age = 20;
  double weight = 60.5;
  double hight = 160.5;
  bool isActive = true;
  bool isCacel = false;
  var description;

  Map types = {'type': 'Admin', 'code': 'ADM'};
  Map<String, int> types2 = {'age': 20, 'height': 160};
  List sex = ['male', 'female'];
  List<int> ages = [10, 20, 30];
  List<Map<String, int>> myusers = [
    {'name': 10, 'age': 20}
  ];

  void showName(String name, int age) {
    print('Name : $name, Age $age');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Application')),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            print(firstName + ' ' + lastName);
            print('$firstName $lastName');
            print(age);
            print('===========');
            double bmi = weight / ((hight / 100) * (hight / 100));
            print('BMI : $bmi');
            showName('Flutter', 30);

            Person person = Person('Hello');
            person.showName();
          },
          color: Colors.pinkAccent,
          textColor: Colors.white,
          highlightColor: Colors.amberAccent,
          child: Text(' Click Me'),
        ),
      ),
    );
  }
}

class Person {
  String name;
  Person(this.name);
  showName() {
    print('class, name :$name');
  }
}
