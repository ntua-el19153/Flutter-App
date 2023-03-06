//import 'dart:html';
import 'package:flutter/material.dart';
import 'main.dart';
import 'add.dart';
import 'package:path/path.dart' as p;
import 'dart:core';
import 'dart:collection';
import 'friends.dart';
import 'requests.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class EventsWidget extends StatefulWidget {
  final List<Event> events;
  const EventsWidget({Key? key, required this.events}) : super(key: key);

  @override
  _EventsWidgetState createState() => _EventsWidgetState();
}

class Event {
  String title;
  String description;
  String location;
  bool personal;
  TimeOfDay time;
  DateTime date;

  Event(
      {required this.title,
      required this.description,
      required this.location,
      required this.personal,
      required this.time,
      required this.date});
}

List<Event> _EventsList = [
  Event(
    title: "Event1",
    description: "",
    location: "The MoB",
    personal: true,
    time: TimeOfDay(hour: 19, minute: 00),
    date: DateTime(2023, 2, 2),
  ),
  Event(
    title: "Event2",
    description: "",
    location: "foo bar",
    personal: true,
    time: TimeOfDay(hour: 20, minute: 00),
    date: DateTime(2023, 3, 3),
  ),
  Event(
    title: "Event3",
    description: "",
    location: "Punto Zero",
    personal: true,
    time: TimeOfDay(hour: 21, minute: 00),
    date: DateTime(2023, 4, 4),
  ),
  Event(
    title: "Event4",
    description: "",
    location: "White Monkey",
    personal: true,
    time: TimeOfDay(hour: 22, minute: 00),
    date: DateTime(2023, 5, 5),
  ),
  Event(
    title: "Event5",
    description: "",
    location: "Baba au rum",
    personal: true,
    time: TimeOfDay(hour: 23, minute: 00),
    date: DateTime(2023, 6, 6),
  ),
  Event(
    title: "Event6",
    description: "",
    location: "MoMix Bar Kerameikos",
    personal: true,
    time: TimeOfDay(hour: 22, minute: 00),
    date: DateTime(2023, 7, 7),
  ),
  Event(
    title: "Event7",
    description: "",
    location: "The Clumsies",
    personal: true,
    time: TimeOfDay(hour: 23, minute: 00),
    date: DateTime(2023, 7, 27),
  ),
  Event(
    title: "Event8",
    description: "",
    location: "CV Distiller",
    personal: true,
    time: TimeOfDay(hour: 21, minute: 00),
    date: DateTime(2023, 8, 8),
  ),
  Event(
    title: "Event9",
    description: "",
    location: "Noel",
    personal: true,
    time: TimeOfDay(hour: 19, minute: 00),
    date: DateTime(2023, 9, 9),
  )
];

class _EventsWidgetState extends State<EventsWidget> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) async {
    if (index == 0) {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => FriendsWidget(friends: [])),
      );
    }

    if (index == 2) {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RequestsWidget()),
      );
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

  void _addEvent() async {
    Event? newEvent = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AddWidget()));
    if (newEvent != null) {
      /// Προσθήκη του νέου task στη βάση δεδομένων SQLite
      //final newId = await sqLiteService.addEvent(newEvent);

      /// Η συνάρτηση [addTask] μας επιστρέφει το πρωτεύων κλειδί της νέας
      /// εγγραφής, το οποίο το τοποθετούμε στο πεδίο id του task.
      //newEvent.id = newId;

      /// Προσθήκη του νέου task στη λίστα των tasks και επανασχεδιασμός του
      /// [Stateful] widget
      _EventsList.add(newEvent);
      //_filterEvents();
      setState(() {});
    }
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
    _EventsList = widget.events + _EventsList;
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
            Expanded(
              child: ListView.builder(
                itemCount: _EventsList.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "${_EventsList[index].title}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Location: ${_EventsList[index].location}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "${_EventsList[index].date.day}/${_EventsList[index].date.month}/${_EventsList[index].date.year}, ${_EventsList[index].time.hour}:${_EventsList[index].time.minute}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextButton(
                                onPressed: () async {
                                  _launchNavigation(
                                      _EventsList[index].location);
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
                          ),
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      launch('https://open.spotify.com/');
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
                                              Icons.library_music_outlined,
                                              color: Colors.black,
                                              size: 20,
                                            ),
                                            Text(
                                              'Make a playlist',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13.0),
                                            ),
                                          ],
                                        )),
                                  ),
                                  //delete
                                ],
                              )),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addEvent,
        backgroundColor: Color.fromARGB(255, 230, 201, 235),
        tooltip: 'Create Event',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
