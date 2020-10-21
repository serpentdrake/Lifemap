import 'package:flutter/material.dart';
import 'package:lifemap_v7/constants.dart';
import 'package:lifemap_v7/db/database_helper.dart';
import 'package:lifemap_v7/models/strength.dart';
import 'package:lifemap_v7/screens/setUpScreens/talentScreenWeak.dart';

class StrengthEdit extends StatefulWidget {
  bool isTrue;
  StrengthEdit({this.isTrue});
  @override
  _StrengthEdiState createState() => _StrengthEdiState(isTrue);
}

class _StrengthEdiState extends State<StrengthEdit> {
  Future<List<Strength>> str;

  _StrengthEdiState(this.isTrue);

  int userId, ctr = 0, updateStrId;
  String strDesc, title;

  bool isTrue = false, isUpdate = false, isCoreStr;

  final formKey = new GlobalKey<FormState>();
  TextEditingController _controllerStr = TextEditingController();
  @override
  void initState() {

    super.initState();
    title = "Core Strength";
    // isCoreStr = true;
    if(isTrue){
      setState(() {
        str = DBHelper().getStr();
      });
    }
    print(ctr);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'Assets/background2.png',
            fit: BoxFit.cover,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text('STRENGTH'),
              elevation: 0.0,
              backgroundColor: Colors.transparent.withOpacity(0.2),
            ),
            body: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 40.0,),
                    Center(child: Column(
                      children: <Widget>[
                        Text("Talent",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15,),
                        Text('"Strength"',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),),
                      ],
                    ),),
                    SizedBox(height: 30.0,),
                    _loader(),
                  ],
                ),
              ),
            ),
            floatingActionButton: _floatingButton(),
          )
        ],
      ),
    );
  }



  _refreshList() {
    setState(() {
      str = DBHelper().getStr();
    });
  }

  _floatingButton(){
    if(ctr == 5){
      this.deactivate();
    } else {
      return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showDialog,
      );
    }
  }

  _save() {
    if (isUpdate) {
      if(formKey.currentState.validate()){
        formKey.currentState.save();
        Strength e = Strength(updateStrId, strDesc, userId);

        DBHelper().updateStr(e);
      }
      setState(() {
        isUpdate = false;
      });

    } else {
      if(formKey.currentState.validate()){
        formKey.currentState.save();
        Strength e = Strength(null, strDesc, userId);

        DBHelper().saveStr(e);
      }
      setState(() {
        title = "Strength";
      });
      ctr++;
    }
    print(ctr);
    _refreshList();
    Navigator.pop(context);
  }

  Container dataList(List<Strength> str) {
    return Container(
      child: DataTable(
        dividerThickness: 0,
        columns: [
          DataColumn(
            label: Text("Strength",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
        rows: str
            .map((str) => DataRow(cells: [
          DataCell(
            // Text(str.strDesc)
              Container(

                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ]
                ),
                child: ListTile(
                  title: Text(str.strDesc),
                  trailing: IconButton(icon: Icon(Icons.edit), onPressed: (){
                    _editDialog();
                    setState(() {
                      isUpdate = true;
                      updateStrId = str.strId;
                    });
                    _controllerStr.text = str.strDesc;
                  }),
                ),
              )
          )
        ])).toList(),
      ),
    );
  }

  _loader() {
    return FutureBuilder(
      future: str,
      builder: (context, snapshot){
        if(snapshot.hasData) {
          return dataList(snapshot.data);
        }
        if(snapshot.data == null || snapshot.data.length == 0){
          return Center(
            child: Container(
              child: Column(
                children: <Widget>[
                  Text("Determine  your 5 Main Strength"),
                  Text("Where the 1st one will be your Core Strength"),
                ],
              ),
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
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
                    Text("Enter your $title"),
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
                    Text("Update your Strength"),
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

}

