import 'package:flutter/material.dart';

class homeScreen extends StatefulWidget{
  // String passedFname, passedLname;
  String date, fName, lName;
  homeScreen({this.fName, this.lName, this.date});
  // homeScreen({this.passedFname, this.passedLname});

  @override
  _homeScreen createState() => _homeScreen(fName, lName, date);
}

class _homeScreen extends State<homeScreen>{
  // String date;
  // _homeScreen(this.date);
  // String passedFname, passedLname;
  // _homeScreen(this.passedFname, this.passedLname);
  String date, fName, lName;
  _homeScreen(this.fName, this.lName, this.date);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('LifeMap'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
          ),

          Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                ),
                Text(fName),
                Text(lName),
                Text(date,),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              // Text(
              //   passedFname,
              // ),
              // SizedBox(
              //   height: 15.0,
              // ),
              // Text(
              //     passedLname
              // ),
            ],
          )

        ],
      ),
    );
  }
}