import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lifemap_v7/models/userEvents.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  calendarScreen createState() => calendarScreen();
}

class calendarScreen extends State<CalendarScreen> {

 List<UserEvents> userEvents;


  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();
  TimeOfDay pickend;
  TimeOfDay picked;
  List <dynamic> startTime;
  List <dynamic> endTime;

  Future<Null>selectstartTime( BuildContext context) async {
    _startTime = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if(picked != null && picked != _startTime){
      setState(() {
        _startTime = picked;
      });
    }
  }

  Future<Null>selectEndTime( BuildContext context) async {
    _endTime = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if(pickend != null && picked != _endTime){
      setState(() {
        _endTime = pickend;
      });
    }
  }


  CalendarController _calendarController;
  Map< DateTime ,List<dynamic>> _events;
  List<dynamic> _selectedEvents;

  TextEditingController _eventController;
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    userEvents = [];
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> oldMap = {};
    map.forEach((key, value) {
      oldMap[key.toString()] = map[key];
    });
    return oldMap;
  } //used to encode events to calendar

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }//used to get events from calendar
  // This widget is the root of your application.

  eventScreen(_events){

    for (UserEvents users in _selectedEvents){
      setState(() {
        ListTile(
          title: Text(users.eventName),
          subtitle: Text('${users.startTime} - ${users.endTime}'),
        );

      });
      print(users.eventName);
      print(users.startTime);
      print(users.endTime);


    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FloatingActionButton(onPressed: (){Navigator.pop(context);})
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              events: _events,
              calendarStyle: CalendarStyle(
                  todayColor: Colors.yellow,
                  selectedColor: Theme.of(context).primaryColor),
              onDaySelected: (date, events,) {
                setState(() {
                  _selectedEvents = events;
                });
              },
              calendarController: _calendarController,
            ),
            // ..._selectedEvents[_selectedEvents.length].map((event) => ListTile(
            //   title: Text(userEvents[_selectedEvents.length].eventName),
            //   subtitle: Text('${userEvents[_selectedEvents.length].startTime} - ${userEvents[_selectedEvents.length].endTime}'),
            //
            // )
            // )
           Container(
             height: 200,
             child: ListView(
               children: <Widget>[
                eventScreen(_events),
               ],
             ),
           )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showDialog,
      ),

    );
  }

  _showDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            content: TextField(
              controller: _eventController,
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text('Start Time'),
                  onPressed: (){

                    selectstartTime(context);

                  }
              ),

              FlatButton(
                  child: Text('End Time'),
                  onPressed: (){
                    selectEndTime(context);
                  }
              ),

              FlatButton(
                  child: Text('Save'),
                  onPressed: () {
                    if (_eventController.text.isEmpty) return;//if textfield is empty returns empty
                    setState(() {
                      if (_events[_calendarController.selectedDay] !=
                          null) {

                        _events[_calendarController.selectedDay]
                            .add(userEvents[_selectedEvents.length] = UserEvents(_eventController.text, _startTime, _endTime, _calendarController.selectedDay));

                      }//checks if anything is in selected day and adds an event
                      else {
                        _events[_calendarController.selectedDay] = [
                          userEvents[_selectedEvents.length] = UserEvents(_eventController.text, _startTime, _endTime, _calendarController.selectedDay),

                        ];//add events on empty selected day

                        // UserEvents(eventName:_eventController.text);
                        // UserEvents(start: _startTime, end: _endTime);
                        _eventController.clear();
                        Navigator.pop(context);
                      }
                    });
                  })
            ]
        )
    );
  }
}

