import 'package:flutter/material.dart';
import 'package:lifemap_v7/screens/homescreen.dart';
import 'package:lifemap_v7/screens/setUpScreens/profileScreen.dart';
import 'package:lifemap_v7/models/user.dart';

class wrapper extends StatefulWidget {
  @override
  _wrapperState createState() => _wrapperState();
}

class _wrapperState extends State<wrapper> {
  Future<List<User>> user;

  bool _isEmpty = true;

  void initState() {
    // TODO: implement initState
    super.initState();
    _auth();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'Assets/background2.png',
            fit: BoxFit.cover,
          ),
          Center(
            child: RaisedButton(
              child: Text(
                  "next"
              ),
              onPressed: () {
                if(_isEmpty == true) {
                  return _hasNoData();
                } else{
                  return _hasData();
                }
              },
            ),
          )
        ],
      ),
    );
  }

  _auth(){
    return Expanded(
      child: FutureBuilder(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.hasData){
            setState(() {
              _isEmpty = false;
            });
          }

          if (null == snapshot.data || snapshot.data.length == 0) {
            _isEmpty = true;

          }

          return CircularProgressIndicator();
        },
      ),
    );

  }

  _hasData() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => homeScreen()));

  }
  _hasNoData() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => profileScreen()));
  }

}