import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lifemap_v7/db/database_helper.dart';
import 'package:intl/intl.dart';
import 'package:lifemap_v7/constants.dart';
import 'dart:async';
import 'package:lifemap_v7/models/user.dart';
import 'package:lifemap_v7/screens/birthScreen.dart';
import 'package:lifemap_v7/screens/homescreen.dart';


class profileScreen extends StatefulWidget {
  @override
  _profileScreen createState() => _profileScreen();
}

class _profileScreen extends State<profileScreen> {
  final formKey = new GlobalKey<FormState>();

  String givenFname, givenLname;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('User Creation',
          style: TextStyle(
              fontWeight: FontWeight.w200,
              color: Colors.black
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[

          Container(
            height: double.infinity,
//            decoration: BoxDecoration(
//              image: DecorationImage(
//                image: AssetImage('images/assets/background2.jpg'),
//                fit: BoxFit.cover,
//              ),
//            ),
            child: SingleChildScrollView(physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 48.0,
                vertical: 20.0,
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0,),

                  form(),

                  SizedBox(height: 30.0,),


                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  form() {
    return Form (
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.text,
              style: TextStyle(color: Colors.black54,
                fontFamily: 'ArialMtBold',),
              decoration: InputDecoration(
                labelText: 'First Name',
                hintText: 'Enter your First Name',
//                contentPadding: EdgeInsets.only(top: 20.0,),
                hintStyle: kHintTextStyle,
              ),

              // validator: (val) => val.length ==  0 ? 'This field is required.' : null,
              onChanged: (text) => givenFname = text,


            ),

            TextFormField(
              keyboardType: TextInputType.text,
              style: TextStyle(color: Colors.black54,
                fontFamily: 'ArialMtBold',),
              decoration: InputDecoration(
                labelText: 'Last Name',
                hintText: 'Enter your Last Name',
//                contentPadding: EdgeInsets.only(top: 20.0,),
                hintStyle: kHintTextStyle,
              ),

              // validator: (val) => val.length ==  0 ? 'This field is required.' : null,
              onChanged: (val) => givenLname = val,


            ),



            SizedBox(height: 7.0,),



            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  splashColor: Colors.blueGrey,
                  onPressed: () {
                    Navigator.push(
                      context,
                      // MaterialPageRoute(builder: (context) => homeScreen()),
                      MaterialPageRoute(builder: (context) => birthScreen(passedFname: givenFname, passedLname: givenLname,)),
                    );
                  },
                  child: Text('Next'),
                ),
                // FlatButton(
                //   splashColor: Colors.blueGrey,
                //   onPressed: (){},
                //   child: Text('Cancel'),
                // ),
              ],
            ),

            SizedBox(height: 30.0,),
//            Text ('Age: '+age.toString()),
          ],
        ),
      ),
    );
  }
}