import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifemap_v7/constants.dart';
import 'package:lifemap_v7/models/user.dart';
import 'package:lifemap_v7/db/database_helper.dart';
import 'package:lifemap_v7/screens/homescreen.dart';


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
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'Assets/background2.png',
            fit: BoxFit.cover,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              child: Center(
                child: ListView(
                  children: [
                    SizedBox(
                      height: 100.0,
                    ),

                    //Text
                    Column(
                      children: [
                        Text("We want to know you better",
                          style: GoogleFonts.getFont('Alice', textStyle: TextStyle(
                          fontSize: 30
                          )
                          ),
                        ),
                        SizedBox(height: 15,),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 18),
                          child: Text('Please fill in the following :',
                            style: GoogleFonts.getFont('Alice',
                              textStyle: TextStyle(
                                fontSize: 17
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),

                    //Registration
                    form(),
                    //NextButton
                    SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      children: [
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
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
                      validator: (val) {return val.length == 0 ? "Field should not be empty":null;},
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
                      validator: (val) {return val.length == 0 ? "Field should not be empty":null;},
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
              Container(
                height: 47,
                width: 370,
                child: TextFormField(
                  validator: (val) {return val.length == 0 ? "Field should not be empty":null;},
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
                  validator: (val) {return val.length == 0 ? "Field should not be empty":null;},
                  keyboardType: TextInputType.number,
                  initialValue: '60',
                  decoration: InputDecoration(
                      labelText: 'Retirement Age',
                      // border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0)),
                  onSaved: (val) => retirementAge = val,
                ),
              )
            ],
          ),
        ));
  }

  next() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      User e =
      User(null, fName, lName, int.parse(age), int.parse(retirementAge));

      dbHelper.saveUser(e);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => homeScreen()));
    }
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