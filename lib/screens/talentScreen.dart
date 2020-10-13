import 'package:flutter/material.dart';
import 'package:lifemap_v7/constants.dart';
import 'package:lifemap_v7/db/database_helper.dart';
import 'package:lifemap_v7/models/strength.dart';

class talentScreen extends StatefulWidget {
  @override
  _talentScreenState createState() => _talentScreenState();
}

class _talentScreenState extends State<talentScreen> {
  Future<List<Strength>> str;
  final formKey = new GlobalKey<FormState>();
  var dbHelper;
  @override
  void initState() {
    // TODO: implement initState
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
                child: ListView.builder(
                    itemCount: 10 ,
                    itemBuilder: (_, index){
                      return Card(
                        child: Container(
                            height: 80,
                            width: 120,
                            child: Text('List item no. ${index + 1}')
                        ),
                        elevation: 6.0,
                      );
                    }
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
        child: Container(
      height: 200,
      padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: Column(
        children: [
          Text("Identify your Strengths"),
          SizedBox(height: 20.0,),
          Container(
            width: 350.0,
              child: TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: "Core Strength",
                contentPadding: EdgeInsets.all(8.0)),
          )),
          SizedBox(height: 20.0,),
        ],
      ),
    ));
  }
}
