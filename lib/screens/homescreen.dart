import 'package:flutter/material.dart';
import 'package:lifemap_v7/db/database_helper.dart';
import 'package:lifemap_v7/models/user.dart';
import 'package:lifemap_v7/models/strength.dart';
import 'dart:async';

class homeScreen extends StatefulWidget{
  @override
  _homeScreen createState() => _homeScreen();
}

class _homeScreen extends State<homeScreen>{
  Future<List<User>> user;
  Future<List<Strength>> str;

  var dbHelper;


  
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    setState(() {
      user = dbHelper.getUser();
      str = dbHelper.getStr();
      // time = dbHelper.getTime();
    });
    print(user);

  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('LifeMap'),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[

              _listUser(),
              _listStr(),
              SizedBox(height: 20.0,),
              FlatButton(onPressed: refreshList, child: Text('Refresh')),
            ],
          ),

        ],
      ),
    );

  }

  refreshList() {
    setState(() {
      user = dbHelper.getUser();
      // time = dbHelper.getTime();
    });
  }

  SingleChildScrollView dataTableUser(List<User> user) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text('FirstName'),
          ),
          DataColumn(
            label: Text('LastName'),
          ),
          DataColumn(
            label: Text('Age'),
          ),
          DataColumn(
            label: Text('DOB'),
          )
        ],
        rows: user
            .map(
              (user) => DataRow(cells: [
            DataCell(
              Text(user.fName),
            ),
            DataCell(
              Text(user.lName),
            ),
            DataCell(
              Text(user.age.toString()),
            ),
            DataCell(
              Text(user.birthDate.toString()),
            )

          ]),
        )
            .toList(),
      ),
    );
  }

  _listUser() {
    return Expanded(
      child: FutureBuilder(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return dataTableUser(snapshot.data);
//            if(_test == 'yes!') {
//              refreshList();
//            }
          }

          if (null == snapshot.data || snapshot.data.length == 0) {
            return Text("No User Found");
          }
//          refreshList();
          return CircularProgressIndicator();
        },
      ),
    );
  }

  SingleChildScrollView dataTableStr(List<Strength> str) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text('FirstName'),
          ),
          DataColumn(
            label: Text('LastName'),
          ),
          DataColumn(
            label: Text('Age'),
          ),
          DataColumn(
            label: Text('DOB'),
          )
        ],
        rows: str
            .map(
              (str) => DataRow(cells: [
            DataCell(
              Text(str.str1),
            ),
            DataCell(
              Text(str.str2),
            ),
            DataCell(
              Text(str.str3),
            ),
            DataCell(
              Text(str.str4),
            )

          ]),
        )
            .toList(),
      ),
    );
  }

  _listStr() {
    return Expanded(
      child: FutureBuilder(
        future: str,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return dataTableStr(snapshot.data);
//            if(_test == 'yes!') {
//              refreshList();
//            }
          }

          if (null == snapshot.data || snapshot.data.length == 0) {
            return Text("No User Found");
          }
//          refreshList();
          return CircularProgressIndicator();
        },
      ),
    );
  }




  }
