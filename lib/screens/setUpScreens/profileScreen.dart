import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifemap_v7/constants.dart';
import 'package:intl/intl.dart';
import 'package:lifemap_v7/models/user.dart';
import 'package:lifemap_v7/db/database_helper.dart';
import 'package:lifemap_v7/screens/homescreen.dart';


import 'package:lifemap_v7/screens/setUpScreens/strengthScreen.dart';

class profileScreen extends StatefulWidget {
  @override
  _profileScreen createState() => _profileScreen();
}

class _profileScreen extends State<profileScreen> {
  Future<List<User>> user;

  String fName, lName, age, retirementAge;

  var dbHelper;

  final formKey = new GlobalKey<FormState>();

  final TextEditingController _controller = new TextEditingController();
  static final _UsNumberTextInputFormatter _birthDateFormat =
      new _UsNumberTextInputFormatter();

  void initState() {
    super.initState();
    dbHelper = DBHelper();
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('Assets/background2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListView(
            children: <Widget>[
              SizedBox(
                height: 80.0,
              ),
              //Step 1 Text
              Container(
                height: 120.0,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Step 1",
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ArialMtBold',
                        ),
                      ),
                      Text('Hi! we\'d\ like to know more about you'),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              //form
              form(),
              SizedBox(
                height: 10.0,
              ),
              //Next Button
              Column(
                children: <Widget>[
                  RaisedButton(
                    elevation: 5.0,
                    child: Text(
                      'Next',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'ArialMtBold'),
                    ),
                    onPressed: next,
                  ),
                  // Text(age.toString()),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  form() {
    return Form(
      key: formKey,
        child: Container(
      height: 200,
      padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 47,
                width: 180,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'First Name',
                      hintText: 'Enter First Name',
                      hintStyle: kHintTextStyle,
                      // border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0)),
                  onSaved: (val) => fName = val,
                ),
              ),
              Container(
                height: 47,
                width: 180,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'Last Name',
                      hintText: 'Enter Last Name',
                      hintStyle: kHintTextStyle,
                      // border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0)),
                  onSaved: (val) => lName = val,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          // BirthDate
          // Container(
          //   height: 47,
          //   width: 370,
          //   child: TextFormField(
          //     keyboardType: TextInputType.datetime,
          //     decoration: InputDecoration(
          //         labelText: 'Birthday',
          //         hintText: 'DD/MM/YYYY',
          //         hintStyle: kHintTextStyle,
          //         border: InputBorder.none,
          //         contentPadding: EdgeInsets.all(8.0)),
          //     inputFormatters: <TextInputFormatter>[
          //       WhitelistingTextInputFormatter.digitsOnly,
          //       // Fit the validating format.
          //       _birthDateFormat,
          //     ],
          //     onSaved: (val) => birthDate = val,
          //   ),
          // ),

          //Age
          Container(
            height: 47,
            width: 370,
            child: TextFormField(
              keyboardType: TextInputType.number,
              // initialValue: '60',
              decoration: InputDecoration(
                  labelText: 'Current Age',
                  // border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8.0)),
              onSaved: (val) => age = val,
            ),
          ),

          SizedBox(
            height: 7.0,
          ),
          Container(
            height: 47,
            width: 370,
            child: TextFormField(
              keyboardType: TextInputType.number,
              initialValue: '60',
              decoration: InputDecoration(
                  labelText: 'Retirement Age',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8.0)),
              onSaved: (val) => retirementAge = val,
            ),
          )
        ],
      ),
    ));
  }

  next() {

    
    if(formKey.currentState.validate()) {
      formKey.currentState.save();

      User e = User(null, fName, lName, int.parse(age), int.parse(retirementAge));

      dbHelper.saveUser(e);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => strengthScreen()));
    }
    // formKey.currentState.save();
    //
    // User e = User(null, fName, lName, int.parse(age), int.parse(retirementAge));
    //
    // dbHelper.saveUser(e);
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => strengthScreen()));

  }


}

class _UsNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = new StringBuffer();
    if (newTextLength >= 3) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 2) + '/');
      if (newValue.selection.end >= 2) selectionIndex++;
    }
    if (newTextLength >= 5) {
      newText.write(newValue.text.substring(2, usedSubstringIndex = 4) + '/');
      if (newValue.selection.end >= 4) selectionIndex++;
    }
    if (newTextLength >= 9) {
      newText.write(newValue.text.substring(4, usedSubstringIndex = 8));
      if (newValue.selection.end >= 8) selectionIndex++;
    }
// Dump the rest.
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return new TextEditingValue(
      text: newText.toString(),
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
