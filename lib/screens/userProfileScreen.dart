import 'package:flutter/material.dart';
import 'package:lifemap_v7/models/user.dart';
import 'package:lifemap_v7/db/database_helper.dart';

class userProfile extends StatefulWidget {
  @override
  _userProfileState createState() => _userProfileState();
}

class _userProfileState extends State<userProfile> {
  Future<List<User>> users;

  var dbHelper;

  void initState() {
    super.initState();
    // users = DBHelper().getUser();
    dbHelper = DBHelper();
    _refreshList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: Container(
        child: FutureBuilder(
          future: users,
          builder: (context, snapshot){
            if(snapshot.hasData){
              return Text(
                dbHelper.getUser().fName,
              );
            }
          },
        ),
      ),
      // body: ListView.builder(
      //     itemCount: users.length,
      //     itemBuilder: (BuildContext context, int index) {
      //       if (index == users.length) {
      //         return Container(
      //           child: Center(
      //             child: Text(
      //                 "[${users[index].userId}] ${users[index].fName} - ${users[index].lName} "),
      //           ),
      //         );
      //       }
      //     }),
    );
  }

  _refreshList() {
    setState(() {
      users = dbHelper.getUser();
    });
  }

  // Text helloWorld(List<User> users) {
  //   return Text(snap);
  // }


  _listCash() {
    return Expanded(
      child: FutureBuilder(
        future: users,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(
              "true"
            );

          }

          // if (null == snapshot.data || snapshot.data.length == 0) {
          //   return Container(
          //     child: Column(
          //       children: <Widget>[
          //         Center(child: Text("Click the 'Add Entry'")),
          //         Center(child: RaisedButton(elevation: 5.0, child: Text("Add Entry"), onPressed: _showDialog,),),
          //       ],
          //     ),
          //   );
          // }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}
