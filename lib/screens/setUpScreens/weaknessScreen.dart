import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifemap_v7/constants.dart';
import 'package:lifemap_v7/db/database_helper.dart';
import 'package:lifemap_v7/models/weakness.dart';
import 'dart:math' as math;

import 'file:///C:/Users/serpe/Desktop/lifemap_v7/lib/screens/setUpScreens/surplusCashScreen.dart';
import 'package:lifemap_v7/screens/setUpScreens/monthlyExpensesScreen.dart';

class weaknessScreen extends StatefulWidget {
  @override
  _weaknessScreen createState() => _weaknessScreen();
}

class _weaknessScreen extends State<weaknessScreen> {
  Future<List<Weakness>> weak;
  TextEditingController _controllerWeak = TextEditingController();

  int userId, weakUpdateId, ctr;
  String weakDesc;
  bool _setActive, _setActive2, isUpdate = false;

  final formKey = new GlobalKey<FormState>();

  var dbHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
    _setActive = false;
    _setActive2 = true;
    ctr = 0;
    print(ctr);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(

      ),
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
                  Text('Enter 5 Weaknesses that you have.'),
                  SizedBox(height: 30.0,),
                  _listCash(),


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
      weak = dbHelper.getWeak();
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
                    Text("Enter your Weakness"),
                    // SizedBox(height: 5.0,),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'ex. Introvert',
                        hintStyle: kHintTextStyle,
                        // border: InputBorder.none,
                        // contentPadding: EdgeInsets.all(8.0)
                      ),
                      onSaved: (val) => weakDesc = val,
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


  SingleChildScrollView dataTableUser(List<Weakness> weak) {
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
              rows: weak
                  .map(
                    (cash) => DataRow(cells: [
                  DataCell(
                    Text(weakDesc, style: TextStyle( fontSize: 17, fontWeight: FontWeight.w300),),
                    onTap: () {},
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
        future: weak,
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
    if(formKey.currentState.validate()) {
      formKey.currentState.save();
      Weakness e = Weakness(null, weakDesc, userId);

      dbHelper.saveWeak(e);
      _refreshList();
      if(ctr == 4){
        setState(() {
          _setActive = true;
          _setActive2 = false;
        });
      } else {
        ctr++;
      }

      print(ctr);

      Navigator.pop(context);
    }
  }


  next() {
    // print(double.parse(x));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => monthlyExpensesScreen()));
  }
}