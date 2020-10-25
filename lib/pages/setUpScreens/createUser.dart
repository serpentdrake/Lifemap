import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifemap_betav1/models/user.dart';
import 'package:lifemap_betav1/providers/db_provider.dart';
import 'package:lifemap_betav1/pages/homeScreen/homePage.dart';
import 'dart:math' as math;

class createUser extends StatefulWidget {
  @override
  _createUserState createState() => _createUserState();
}

class _createUserState extends State<createUser> {
  final formKey = new GlobalKey<FormState>();

  bool isEmployed;
  String fName, lName, age, retireAge, monthIn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEmployed = false;
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
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent.withOpacity(0.2),
            ),
            body: Container(
              child: Center(
                child: ListView(
                  children: [
                    SizedBox(height: 20.0,),
                    Column(
                      children: [
                        Text("We want to know you better",
                        style: TextStyle(fontSize: 20.0),),
                        SizedBox(height: 10.0,),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 18),
                          child: Text(
                            "Please fill in the following",
                            style: TextStyle(fontSize: 15.0),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20.0,),
                    form()
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  form(){
    return Form(
      key: formKey,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: [
            //Full Name
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 60.0,
                  width: 180.0,
                  child: TextFormField(
                    validator: (val) {
                      return val.length == 0
                          ? "Field should not be empty"
                          : null;
                    },
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      hintText: 'Enter your First Name',
                    ),
                    onSaved: (val) => fName = val,
                  ),
                ),
                Container(
                  height: 60.0,
                  width: 180.0,
                  child: TextFormField(
                    validator: (val) {
                      return val.length == 0
                          ? "Field should not be empty"
                          : null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      hintText: 'Enter your Last Name',
                    ),
                    onSaved: (val) => lName = val,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0,),
            //Age
            Container(
              height: 60.0,
              width: 200.0,
              child: TextFormField(
                validator: (val) {
                  return val.length == 0
                      ? "Field should not be empty"
                      : null;
                },
                decoration: InputDecoration(
                  labelText: 'Current Age',
                ),
                onSaved: (val) => age = val,
              ),
            ),
            SizedBox(height: 10.0,),
            //Retirement Age
            Container(
              height: 60.0,
              width: 200.0,
              child: TextFormField(
                validator: (val) {
                  return val.length == 0
                      ? "Field should not be empty"
                      : null;
                },
                initialValue: '60',
                decoration: InputDecoration(
                  labelText: 'Retirement Age'
                ),
                onSaved: (val) => retireAge = val,
              ),
            ),
            SizedBox(height: 10.0,),
            //isEmployed
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(

                  child: Text(
                    'Employed',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Checkbox(
                  value: isEmployed,
                  onChanged: (val) {
                    if (isEmployed == false) {
                      setState(() {
                        isEmployed = true;
                        print(isEmployed);
                      });
                    } else if (isEmployed == true) {
                      setState(() {
                        isEmployed = false;
                        print(isEmployed);
                      });
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 10.0,),
            //Monthly Income
            Container(
              height: 60.0,
              width: 200.0,
              child: TextFormField(
                inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
                initialValue: '0.00',
                decoration: InputDecoration(
                  labelText: 'Monthly Income',
                  hintText: '0.00',
                ),
                onSaved: (val) => monthIn = val,
              ),
            ),
            SizedBox(height: 20.0,),
            //Next
            RaisedButton(
              elevation: 5.0,
              child: Text(
                'Next',
              ),
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }

  _save() {
    if(formKey.currentState.validate()){
      formKey.currentState.save();
      User e = User(id: null, fName: fName, lName: lName, age: int.parse(age), retireAge: int.parse(retireAge), monthIn: double.parse(monthIn));
      DBProvider.db.createUser(e);
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => homePage()));
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({this.decimalRange})
      : assert(decimalRange == null || decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, // unused.
      TextEditingValue newValue,
      ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(".") &&
          value.substring(value.indexOf(".") + 1).length > decimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}