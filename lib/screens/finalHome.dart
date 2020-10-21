import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifemap_v7/db/database_helper.dart';
import 'package:lifemap_v7/models/strength.dart';

import 'Edits/strengthEdit.dart';


class FinalHomeScreen extends StatefulWidget {
  @override
  _FinalHomeScreenState createState() => _FinalHomeScreenState();
}

class _FinalHomeScreenState extends State<FinalHomeScreen> {

  Future<List<Strength>> str;

  DBHelper _dbHelper = DBHelper();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Home'),
      ),
        body:Stack(
          children:<Widget>[
           ListView(
            children: <Widget>[
              //User Profiles
              Column(
                children: <Widget>[
                  Text('User Profile Here'),
                ],
              ),
              //User Profiles



              //Summary
              Column(
                children: <Widget>[
                  Text('Summary'),
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text('Body of Summary'),
                        ],
                      ),
                    ),
                  )
                ],
              ),

              //Summary



              //Strength
              Container(
                width: 280,
                height: 300,
                child: Column(
                  children: <Widget>[
                    Flexible(
                        child: _listStr()
                    ),
                  ],

                  ),
                ),

              //Strength


              //Time Allotment


              //Time Allotment



              //Monthly


              //Monthly


              //Annual


              //Annual


              //Weakness


              //Weakness


              //Motivational Quotes


              //MotivationalQuotes

            ]
          ),
    ]
        ),
    );
  }
  _listStr(){
    return FutureBuilder(
        initialData: [],
        future: _dbHelper.getStr(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return dataTableStr(snapshot.data);
          } else  if(snapshot.data == 0 || snapshot.data.length == 0){
            return Center(child: Text("Has no Data"),);
          }
          return CircularProgressIndicator();
        }
    );
  }

  Container dataTableStr(List<Strength> str){
    return Container(
      child: DataTable(
        columns: [
          DataColumn(label: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => StrengthEdit(isTrue: true,))
                );
              },
              child: Text("Strength")
          )
          ),
        ],
        rows: str
            .map((str) => DataRow(cells: [
          DataCell(
            Text(str.strDesc),
          )
        ])).toList(),
      ),
    );
  }
}
