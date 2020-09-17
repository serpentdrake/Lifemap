import 'package:flutter/material.dart';

class homeScreen extends StatefulWidget{
  // String passedFname, passedLname;
  String date;
  homeScreen({this.date});
  // homeScreen({this.passedFname, this.passedLname});

  @override
  _homeScreen createState() => _homeScreen(date);
}

class _homeScreen extends State<homeScreen>{
  String date;
  _homeScreen(this.date);
  // String passedFname, passedLname;
  // _homeScreen(this.passedFname, this.passedLname);

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
                  height: 10.0,
                ),
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