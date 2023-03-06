//import 'dart:html';
import 'package:flutter/material.dart';
import 'main.dart';
import 'friends.dart';
import 'events.dart';
import 'requests.dart';
import 'package:path/path.dart' as p;
import 'package:url_launcher/url_launcher.dart';

import 'dart:core';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) async {
    if (index == 0) {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => FriendsWidget(
                  friends: [],
                )),
      );
    }
    if (index == 1) {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => EventsWidget(events: [])),
      );
    }
    if (index == 2) {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RequestsWidget()),
      );
    }
  }

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Friends',
    ),
    Text(
      'Events',
    ),
    Text(
      'Requests',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 230, 201, 235),
        title: Text('Hangoutomatic'),
      ),
      body: Padding(
          padding: EdgeInsets.only(top: 50),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: Colors.grey,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          child: Text('S'),
                        )),
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Sofia Efstratiadou',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
                Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Age: 21',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
                Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'E-mail: sofia@gmail.com',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
                Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Phone Number: 6945675324',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ],
            ),
          )),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 230, 201, 235),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.face_outlined),
            label: 'Friends',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle_notifications_outlined),
            label: 'Requests',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Color.fromARGB(255, 153, 152, 152),
        selectedItemColor: Color.fromARGB(255, 0, 0, 0),
        onTap: _onItemTapped,
      ),
    );
  }
}
