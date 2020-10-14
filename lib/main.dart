import 'package:flutter/material.dart';
import 'package:lifemap_v7/Time/tasks.dart';
import 'package:lifemap_v7/Time/timeAlotment.dart';
import 'package:lifemap_v7/screens/edits.dart';
import 'package:lifemap_v7/screens/homescreen.dart';
import 'package:lifemap_v7/screens/setUpScreens/monthlyExpensesScreen.dart';
import 'package:lifemap_v7/screens/setUpScreens/profileScreen.dart';
import 'package:lifemap_v7/screens/setUpScreens/talentScreen.dart';
import 'package:lifemap_v7/screens/setUpScreens/workEmployment.dart';
import 'package:lifemap_v7/wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WorkEmploymentData(),
    );
  }
}



