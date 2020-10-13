import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifemap_v7/constants.dart';
import 'package:lifemap_v7/db/database_helper.dart';
import 'package:lifemap_v7/models/strength.dart';
import 'dart:math' as math;

import 'file:///C:/Users/serpe/Desktop/lifemap_v7/lib/screens/setUpScreens/weaknessScreen.dart';

class strengthScreen extends StatefulWidget {
  @override
  _strengthScreen createState() => _strengthScreen();
}

class _strengthScreen extends State<strengthScreen> {
  Future<List<Strength>> str;
  TextEditingController _controllerStr = TextEditingController();

  int userId, strUpdateId, ctr;
  String strDesc;
  bool _setActive, _setActive2, isUpdate = false;

  final formKey = new GlobalKey<FormState>();

  var dbHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
    // _refreshList();
    _setActive = false;
    _setActive2 = true;
    ctr = 0;
    print(ctr);
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



          Container(
            // height: 120.0,
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 80.0,),
                  Text(
                    "Step 3",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ArialMtBold',
                    ),
                  ),
                  Text('Enter 5 Strengths that you have.'),
                  SizedBox(height: 30.0,),
                  _listCash(),
                  // SizedBox(height: 30.0,),
                  // Visibility(
                  //   visible: _setActive,
                  //   child: Container(
                  //     height: 150.0,
                  //     child: Center(
                  //       child: RaisedButton(
                  //         elevation: 5.0,
                  //         child: Text("Next"),
                  //         onPressed: next,
                  //       ),
                  //     ),
                  //   ),
                  // ),

                ],
              ),
            ),
          ),
          SizedBox(height: 20.0,),
        ],
      ),
    );
  }

  _refreshList() {
    setState(() {
      str = dbHelper.getStr();
    });
  }

  _showDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          // title: Text("Step 3.2"),
          // shape: RoundedRectangleBorder(),
            content: Form(
              key: formKey,
              child: Container(
                height: 140,
                child: Column(
                  children: <Widget>[
                    Text("Enter your Strength"),
                    // SizedBox(height: 5.0,),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'ex. Sociable',
                        hintStyle: kHintTextStyle,
                        // border: InputBorder.none,
                        // contentPadding: EdgeInsets.all(8.0)
                      ),
                      onSaved: (val) => strDesc = val,
                    ),


                  ],
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              FlatButton(
                onPressed: _save,
                child: Text("Save"),
              ),
            ]));
  }

  _editDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          // title: Text("Step 3.2"),
          // shape: RoundedRectangleBorder(),
            content: Form(
              key: formKey,
              child: Container(
                height: 140,
                child: Column(
                  children: <Widget>[
                    Text("Enter your Strength"),
                    // SizedBox(height: 5.0,),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _controllerStr,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'ex. Sociable',
                        hintStyle: kHintTextStyle,
                        // border: InputBorder.none,
                        // contentPadding: EdgeInsets.all(8.0)
                      ),
                      onSaved: (val) => strDesc = val,
                    ),


                  ],
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              FlatButton(
                onPressed: _save,
                child: Text("Save"),
              ),
            ]));
  }


  SingleChildScrollView dataTableUser(List<Strength> str) {
//    var year;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        width: 360,
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(21),
        ),

        child: Column(
          children: <Widget>[
            DataTable(
              columns: [
                DataColumn(
                  label: Text('Description',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      color: Colors.black
                    ),
                  ),
                ),
              ],
              rows: str
                  .map(
                    (str) => DataRow(cells: [
                  DataCell(
                    Text(str.strDesc, style: TextStyle( fontSize: 17, fontWeight: FontWeight.w300),),
                    onTap: () {
                      _editDialog();
                      setState(() {
                        isUpdate = true;
                        strUpdateId = str.strId;
                      });
                      _controllerStr.text = str.strDesc;
                    },

                  ),
                ]),
              )
                  .toList(),
            ),

            SizedBox(height: 20.0,),
            Visibility(
              visible: _setActive2,
              child: Container(
                child: Center(
                  child: RaisedButton(
                    elevation: 5.0,
                    child: Text("Add Entry"),
                    onPressed: _showDialog,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _setActive,
              child: Container(
                child: Center(
                  child: RaisedButton(
                    elevation: 5.0,
                    child: Text("Next"),
                    onPressed: next,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),

      //Add & Next Button

    );
  }

  _listCash() {
    return Expanded(
      child: FutureBuilder(
        future: str,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return dataTableUser(snapshot.data);

          }

          if (null == snapshot.data || snapshot.data.length == 0) {
            return Container(
              child: Column(
                children: <Widget>[
                  Center(child: Text("Click the 'Add Entry'")),
                  Center(child: RaisedButton(elevation: 5.0, child: Text("Add Entry"), onPressed: _showDialog,),),
                ],
              ),
            );
          }
//          refreshList();
          return CircularProgressIndicator();
        },
      ),
    );
  }



  _save() {
    if(isUpdate) {
      if(formKey.currentState.validate()) {
        formKey.currentState.save();
        Strength e =Strength(strUpdateId, strDesc, userId);
        dbHelper.updateStr(e);
        setState(() {
          isUpdate = false;
        });
    }
    } else {
        if(formKey.currentState.validate()) {
          formKey.currentState.save();
          Strength e = Strength(null, strDesc, userId);

          dbHelper.saveStr(e);



          if(ctr == 4){
            setState(() {
              _setActive = true;
              _setActive2 = false;
            });
          } else {
            ctr++;
          }
      }



    }
    _refreshList();
    print(ctr);

    Navigator.pop(context);
  }


  next() {
    // print(double.parse(x));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => weaknessScreen()));
  }
}