import 'package:flutter/material.dart';
import 'package:lifemap_v7/models/user.dart';
import 'package:lifemap_v7/models/time.dart';
import 'package:lifemap_v7/db/database_helper.dart';
import 'package:intl/intl.dart';
import 'package:lifemap_v7/db/database_helper.dart';
import 'package:lifemap_v7/screens/homescreen.dart';
import 'package:lifemap_v7/screens/talentScreens/strengthCreate.dart';

class confirmProfile extends StatefulWidget {

  String fName, lName, birthDate, retire;
  confirmProfile({this.fName, this.lName, this.birthDate, this.retire});


  @override
  _confirmProfile createState() => _confirmProfile(fName, lName, birthDate, retire);
}

class _confirmProfile extends State<confirmProfile> {

  Future<List<User>> users;
  Future<List<Time>> time;

  final formKey = new GlobalKey<FormState>();

  int userId, age, prodHour, prodYear, retireAge;
  String fName, lName, birthDate, retire;

  _confirmProfile(this.fName, this.lName, this.birthDate, this.retire);

  var dbHelper;
  DateTime x;

  DateTime convertToDate(String input) {
    try
    {
      var d = new DateFormat.yMd().parse(input);
      return d;
    } catch (e) {
      return null;
    }
  }


  void initState() {
    super.initState();
    // Age = 65;
    dbHelper = DBHelper();
    x = convertToDate(birthDate);
    age = DateTime.now().year - x.year;

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Screen'),
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
                vertical: 100.0,
              ),

              child: Container(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    form(),
                  ],
                ),
              ),
            ),
          ),

        ],

      ),
    );
  }

  void convertDateFromString(String strDate){
    final date = DateTime.parse(strDate);
    print(date);
  }

  form(){
    return Form(
      key: formKey,
        child: Column(
         children: <Widget>[
           TextFormField(
             initialValue: fName,
             decoration: InputDecoration(labelText: 'First Name'),
             onSaved: (value){
               fName = value;
             },
           ),
           TextFormField(
             initialValue: lName,
             decoration: InputDecoration(labelText: 'Last Name'),
             onSaved: (value){
               lName = value;
             },
           ),
           TextFormField(
             initialValue: birthDate,
             decoration: InputDecoration(labelText: 'Birthdate'),
             onSaved: (value){
               birthDate = value;
             },
           ),
           TextFormField(
             initialValue: retire,
             decoration: InputDecoration(labelText: 'Retire Age'),
             onSaved: (value){
               retire = value;
             },
           ),
           SizedBox(height: 20.0,),
           FlatButton(onPressed: save, child: Text('Save'))
         ],
        ),
    );
  }

  save() {
    
    retireAge = int.parse(retire);


    if(formKey.currentState.validate()) {
      formKey.currentState.save();
      User e = User(null, fName, lName, birthDate, age, retireAge );

      dbHelper.saveUser(e);
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => strengthCreate()));
  }
}