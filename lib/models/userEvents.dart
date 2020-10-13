import 'package:flutter/material.dart';

class UserEvents {

  final String eventName;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final DateTime selectedDay;

  UserEvents(this.eventName, this.startTime, this.endTime, this.selectedDay);

  List <UserEvents> usersEvents = [];

}