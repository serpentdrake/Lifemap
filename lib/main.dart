import 'package:flutter/material.dart';
import 'package:lifemap_v7/screens/homescreen.dart';
import 'package:lifemap_v7/screens/profileScreens/profileScreen.dart';
import 'package:lifemap_v7/screens/talentScreens/strengthCreate.dart';


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
      home: profileScreen(),
    );
  }
}



