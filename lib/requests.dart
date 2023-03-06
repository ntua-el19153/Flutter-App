import 'package:flutter/material.dart';
import 'main.dart';
import 'package:path/path.dart' as p;
import 'dart:core';
import 'dart:collection';
import 'friends.dart';
import 'events.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestsWidget extends StatefulWidget {
  const RequestsWidget({Key? key}) : super(key: key);

  @override
  _RequestsWidgetState createState() => _RequestsWidgetState();
  List<Friend> get friends => _Friends;
  List<Event> get events => _Events;
}

/*class Friend {
  String name;
  bool sent_request;
  bool friends;

  Friend(
      {required this.name, required this.sent_request, required this.friends});
}*/

List<Friend> _FriendsRequestList = [
  Friend(name: "karl", sent_request: true, friends: false),
  Friend(name: "max", sent_request: true, friends: false),
  Friend(name: "kim", sent_request: true, friends: false),
  Friend(name: "kendal", sent_request: true, friends: false),
  Friend(name: "alexander", sent_request: false, friends: false),
  Friend(name: "Christian", sent_request: false, friends: false),
  Friend(name: "Anna-Maria", sent_request: false, friends: false),
  Friend(name: "Matt", sent_request: false, friends: false),
  Friend(name: "Steph", sent_request: false, friends: false),
  Friend(name: "James", sent_request: false, friends: false),
  Friend(name: "Giannis", sent_request: false, friends: false),
  Friend(name: "Angela", sent_request: false, friends: false),
  Friend(name: "Deppy", sent_request: false, friends: false),
  Friend(name: "Zoe", sent_request: false, friends: false),
  Friend(name: "Joe", sent_request: false, friends: false),
  Friend(name: "Jerrard", sent_request: false, friends: false)
];
List<Friend> _Friends = [];

List<Event> _EventsRequestList = [
  Event(
    title: "Event11",
    description: "",
    location: "Handlebar, Athens",
    personal: true,
    time: TimeOfDay(hour: 19, minute: 00),
    date: DateTime(2023, 2, 2),
  ),
  Event(
    title: "Event12",
    description: "",
    location: "The Mob",
    personal: true,
    time: TimeOfDay(hour: 20, minute: 00),
    date: DateTime(2023, 3, 3),
  ),
  Event(
    title: "Event13",
    description: "",
    location: "Intriga",
    personal: true,
    time: TimeOfDay(hour: 21, minute: 00),
    date: DateTime(2023, 4, 4),
  ),
  Event(
    title: "Event14",
    description: "",
    location: "Spirto",
    personal: true,
    time: TimeOfDay(hour: 22, minute: 00),
    date: DateTime(2023, 5, 5),
  ),
  Event(
    title: "Event15",
    description: "",
    location: "Baba au rum",
    personal: true,
    time: TimeOfDay(hour: 23, minute: 00),
    date: DateTime(2023, 6, 6),
  ),
  Event(
    title: "Event16",
    description: "",
    location: "MoMix Bar Kerameikos",
    personal: true,
    time: TimeOfDay(hour: 22, minute: 00),
    date: DateTime(2023, 7, 7),
  ),
  Event(
    title: "Event17",
    description: "",
    location: "The Clumsies",
    personal: true,
    time: TimeOfDay(hour: 23, minute: 00),
    date: DateTime(2023, 7, 27),
  ),
  Event(
    title: "Event18",
    description: "",
    location: "CV Distiller",
    personal: true,
    time: TimeOfDay(hour: 21, minute: 00),
    date: DateTime(2023, 8, 8),
  ),
  Event(
    title: "Event19",
    description: "",
    location: "Noel",
    personal: true,
    time: TimeOfDay(hour: 19, minute: 00),
    date: DateTime(2023, 9, 9),
  )
];
List<Event> _Events = [];

class _RequestsWidgetState extends State<RequestsWidget> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) async {
    if (index == 0) {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => FriendsWidget(friends: _Friends)),
      );
      _Friends.clear();
    }

    if (index == 1) {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => EventsWidget(events: _Events)),
      );
      _Events.clear();
    }
  }
/*
  void _gotoprofile() async {
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              ParkingProfileWidget(parkingspots: widget.parkingspots)),
    );
  }
  */

  void _removeFriendCard(int index) {
    setState(() {
      _FriendsRequestList.removeAt(index);
    });
  }

  void _removeEventCard(int index) {
    setState(() {
      _EventsRequestList.removeAt(index);
    });
  }

  _launchNavigation(String location) async {
    String url = 'https://www.google.com/maps/search/?api=1&query=' + location;
    await launch(url);
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

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 230, 201, 235),
        title: Text('Hangoutomatic'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                'Friend Requests',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var index = 0;
                      index < _FriendsRequestList.length;
                      index++)
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Icon(Icons.person)),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "${_FriendsRequestList[index].name}",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title:
                                                Text('Fiend Request Accepted'),
                                            content:
                                                Text('You have a new friend!'),
                                            actions: [
                                              TextButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Color.fromARGB(255,
                                                              230, 201, 235)),
                                                ),
                                                child: Text(
                                                  'OK',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      Friend newFriend = Friend(
                                          name: _FriendsRequestList[index].name,
                                          sent_request: true,
                                          friends: true);
                                      _Friends.add(newFriend);
                                      _removeFriendCard(index);
                                    },
                                    icon: Icon(Icons.check)),
                                IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title:
                                                Text('Fiend Request Declined'),
                                            content: Text(
                                                'You erased the friend request!'),
                                            actions: [
                                              TextButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Color.fromARGB(255,
                                                              230, 201, 235)),
                                                ),
                                                child: Text(
                                                  'OK',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );

                                      _removeFriendCard(index);
                                    },
                                    icon: Icon(Icons.clear_sharp)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            //Event Requests_______________________________

            Padding(
              padding: EdgeInsets.only(top: 50, bottom: 5),
              child: Text(
                'Event Invitations',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var index = 0;
                      index < _EventsRequestList.length;
                      index++)
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              title: Text('${_EventsRequestList[index].title}'),
                              content: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "Location: ${_EventsRequestList[index].location}",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "${_EventsRequestList[index].date.day}/${_EventsRequestList[index].date.month}/${_EventsRequestList[index].date.year}, ${_EventsRequestList[index].time.hour}:${_EventsRequestList[index].time.minute}",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextButton(
                                        onPressed: () async {
                                          _launchNavigation(
                                              _EventsRequestList[index]
                                                  .location);
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 230, 201, 235),
                                              shape: BoxShape.rectangle,
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.navigation_rounded,
                                                  color: Colors.black,
                                                  size: 20,
                                                ),
                                                Text(
                                                  'Show in maps',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13.0),
                                                ),
                                              ],
                                            )),
                                      ),
                                      //delete
                                    ],
                                  )
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color.fromARGB(255, 230, 201, 235)),
                                  ),
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: Colors.grey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "${_EventsRequestList[index].title}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Location: ${_EventsRequestList[index].location}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title:
                                                  Text('Invitation Accepted'),
                                              content: Text(
                                                  'You are invited to a new event!'),
                                              actions: [
                                                TextButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Color.fromARGB(
                                                                255,
                                                                230,
                                                                201,
                                                                235)),
                                                  ),
                                                  child: Text(
                                                    'OK',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                        Event newEvent = Event(
                                            title:
                                                _EventsRequestList[index].title,
                                            description:
                                                _EventsRequestList[index]
                                                    .description,
                                            location: _EventsRequestList[index]
                                                .location,
                                            personal: _EventsRequestList[index]
                                                .personal,
                                            time:
                                                _EventsRequestList[index].time,
                                            date:
                                                _EventsRequestList[index].date);
                                        _Events.add(newEvent);
                                        _removeEventCard(index);
                                        _removeEventCard(index);
                                      },
                                      icon: Icon(Icons.check)),
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title:
                                                  Text('Invitation Declined'),
                                              content: Text(
                                                  'You erased an invitation!'),
                                              actions: [
                                                TextButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Color.fromARGB(
                                                                255,
                                                                230,
                                                                201,
                                                                235)),
                                                  ),
                                                  child: Text(
                                                    'OK',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(Icons.clear_sharp)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                ],
              ),
            )
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
