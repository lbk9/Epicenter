import 'package:flutter/material.dart';
import 'pages/informationpage.dart';
import 'pages/summarypage.dart';
import 'pages/worldlistpage.dart';

void main() {
  runApp(MaterialApp(
      home: MyHome()));
}

class MyHome extends StatefulWidget {
  @override
  MyHomeState createState() => MyHomeState();
}

class MyHomeState extends State<MyHome> {
  int currentIndex = 0;
  final List<Widget> childPages = [
    WorldList(),
    Summary(),
    Information()
  ];

  void onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: childPages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapped,
        backgroundColor: Colors.blue,
        currentIndex: currentIndex,
        fixedColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: new Icon(Icons.list),
              title: new Text(
                  'World List'
              ),
              activeIcon: new Icon(
                Icons.list,
                color: Colors.white,
              )
          ),
          BottomNavigationBarItem(
              icon: new Icon(Icons.public),
              title: new Text('Summary'),
              activeIcon: new Icon(
                Icons.public,
                color: Colors.white,
              )
          ),
          BottomNavigationBarItem(
              icon: new Icon(Icons.info),
              title: new Text('Help'),
              activeIcon: new Icon(
                Icons.info,
                color: Colors.white,
              )
          )
        ],
      ),
    );
  }
}