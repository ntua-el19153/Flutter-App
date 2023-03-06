//import 'dart:html';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:path/path.dart' as p;
import 'dart:core';
import 'dart:collection';
import 'events.dart';
import 'requests.dart';
import 'profile.dart';

class FriendsWidget extends StatefulWidget {
  final List<Friend> friends;
  const FriendsWidget({Key? key, required this.friends}) : super(key: key);

  @override
  _FriendsWidgetState createState() => _FriendsWidgetState();
}

class Friend {
  String name;
  bool sent_request;
  bool friends;

  Friend(
      {required this.name, required this.sent_request, required this.friends});
}

List<Friend> _FriendsList = [
  Friend(name: "maria", sent_request: true, friends: true),
  Friend(name: "giannis", sent_request: true, friends: true),
  Friend(name: "katerina", sent_request: true, friends: true),
  Friend(name: "dimitra", sent_request: true, friends: true),
  Friend(name: "Antoine", sent_request: false, friends: false),
  Friend(name: "Christos", sent_request: false, friends: false),
  Friend(name: "Anna", sent_request: false, friends: false),
  Friend(name: "Sofia", sent_request: false, friends: false),
  Friend(name: "Spyros", sent_request: false, friends: false),
  Friend(name: "Victoria", sent_request: false, friends: false),
  Friend(name: "Viktor", sent_request: false, friends: false),
  Friend(name: "Alex", sent_request: false, friends: false),
  Friend(name: "Themistoclis", sent_request: false, friends: false),
  Friend(name: "Pavlos", sent_request: false, friends: false),
  Friend(name: "Joseph", sent_request: false, friends: false),
  Friend(name: "Anastasia", sent_request: false, friends: false),
  Friend(name: "Anastasis", sent_request: false, friends: false),
  Friend(name: "Mike", sent_request: false, friends: false),
  Friend(name: "Markos", sent_request: false, friends: false),
];
List<Friend> _filteredFriendsList = _FriendsList;

class _FriendsWidgetState extends State<FriendsWidget> {
  int _selectedIndex = 0;

  final TextEditingController _searchController = TextEditingController();

  void _onItemTapped(int index) async {
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

  void _gotoprofile() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileWidget()),
    );
  }

  void _filterFriends() {
    setState(() {
      //_filteredFriendsList = _filteredFriendsList + widget.friends;
      _filteredFriendsList = _FriendsList.where((friend) => friend.name
          .toLowerCase()
          .contains(_searchController.text.toLowerCase())).toList();
    });
  }

  void _sendrequest(int index) {
    setState(() {
      _filteredFriendsList[index].sent_request = true;
    });
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
    // Create a map of user to total points
    _filteredFriendsList = widget.friends + _filteredFriendsList;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 230, 201, 235),
        title: Text('Hangoutomatic'),
        actions: [
          IconButton(
              onPressed: () {
                _gotoprofile();
              },
              icon: Icon(Icons.person))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 70),
        child: Column(
          children: <Widget>[
            Container(
              width: 325,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 83, 78, 78),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 30,
                  ),
                  SizedBox(
                    width: 275,
                    height: 50,
                    child: InkWell(
                      focusColor: Colors.grey,
                      highlightColor: Colors.grey,
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          _filterFriends();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredFriendsList.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Icon(Icons.person)),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "${_filteredFriendsList[index].name}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),

                          Visibility(
                            visible: (!_filteredFriendsList[index].friends &&
                                !_filteredFriendsList[index].sent_request),
                            child: TextButton(
                              onPressed: () {
                                _sendrequest(index);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 230, 201, 235),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Send Request',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13.0),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                          //you will erase these!
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
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
