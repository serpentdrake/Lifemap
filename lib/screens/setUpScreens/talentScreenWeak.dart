import 'package:flutter/material.dart';
import 'package:lifemap_v7/constants.dart';
import 'package:lifemap_v7/db/database_helper.dart';
import 'package:lifemap_v7/models/weakness.dart';

class talentScreenWeak extends StatefulWidget {
  @override
  _talentScreenWeakState createState() => _talentScreenWeakState();
}

class _talentScreenWeakState extends State<talentScreenWeak> {
  Future<List<Weakness>> weak;

  int userId, ctr = 0, updateWeakId;
  String weakDesc, title;

  bool _setActive, isUpdate = false, isCoreWeak;

  final formKey = new GlobalKey<FormState>();
  TextEditingController _controllerWeak = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = "Core Weakness";
    // isCoreStr = true;
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
              elevation: 0.0,
              backgroundColor: Colors.transparent.withOpacity(0.2),
            ),
            body: Container(
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
                      Text('"Weakness"',
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
            floatingActionButton: _floatingButton(),
          )
        ],
      ),
    );
  }



  _refreshList() {
    setState(() {
      weak = DBHelper().getWeak();
    });
  }

  _floatingButton(){
    if(ctr == 5){
      return FloatingActionButton(
        child: Icon(Icons.arrow_forward),
        onPressed: _next,
      );
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
        Weakness e = Weakness(updateWeakId, weakDesc, userId);

        DBHelper().updateWeak(e);
      }
      setState(() {
        isUpdate = false;
      });

    } else {
      if(formKey.currentState.validate()){
        formKey.currentState.save();
        Weakness e = Weakness(null, weakDesc, userId);

        DBHelper().saveWeak(e);
      }
      setState(() {
        title = "Weakness";
      });
      ctr++;
    }
    print(ctr);
    _refreshList();
    Navigator.pop(context);
  }

  _next() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => null));
  }

  Container dataList(List<Weakness> weak) {
    return Container(
      child: DataTable(
        dividerThickness: 0,
        columns: [
          DataColumn(
            label: Text("Weakness",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
        rows: weak
            .map((weak) => DataRow(cells: [
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
                  title: Text(weak.weakDesc),
                  trailing: IconButton(icon: Icon(Icons.edit), onPressed: (){
                    _editDialog();
                    setState(() {
                      isUpdate = true;
                      updateWeakId = weak.weakId;
                    });
                    _controllerWeak.text = weak.weakDesc;
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
      future: weak,
      builder: (context, snapshot){
        if(snapshot.hasData) {
          return dataList(snapshot.data);
        }
        if(snapshot.data == null || snapshot.data.length == 0){
          return Center(
            child: Container(
              child: Column(
                children: <Widget>[
                  Text("Determine  your 5 Main Weakness"),
                  Text("Where the 1st one will be your Core Weakness"),
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
                    Text("Update your Weakness"),
                    // SizedBox(height: 5.0,),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _controllerWeak,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'ex. Sociable',
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




}

// class _talentScreenState extends State<talentScreen> {
//   Future<List<Strength>> str;
//   List<Strength> _str = [];
//
//   String strDesc;
//   int userId;
//
//   final formKey = new GlobalKey<FormState>();
//   var dbHelper;
//
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     str = DBHelper().getStr();
//     dbHelper = DBHelper();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Stack(
//         fit: StackFit.expand,
//         children: [
//           Image.asset(
//             'Assets/background2.png',
//             fit: BoxFit.cover,
//           ),
//           Scaffold(
//             backgroundColor: Colors.transparent,
//             body: FutureBuilder(
//               future: str,
//               builder: (context, snapshot){
//                 if(snapshot.hasData){
//                   return Container(
//                     child: ListView.builder(
//                       itemCount: _str.length,
//                       itemBuilder: (BuildContext context, int index){
//                         return Container(
//                           padding: EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.5),
//                                   spreadRadius: 5,
//                                   blurRadius: 7,
//                                   offset: Offset(0, 3),
//                                 ),
//                               ]
//                           ),
//                           child: ListTile(
//                             title: Text(_str.toString()[index]),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 }
//
//                 if(null == snapshot.data || snapshot.data.length == 0){
//                   return Container(
//                     child: Center(
//                       child: FloatingActionButton(
//                         child: Icon(Icons.add),
//                         onPressed: _showDialog,
//                       ),
//                     ),
//                   );
//                 }
//               },
//             ).toList(),
//
//           )
//
//         ],
//       ),
//     );
//   }
//
//   _switcher() {
//     return Expanded(
//       child: FutureBuilder(
//         future: str,
//         builder: (context, snapshot) {
//           if (snapshot.hasData){
//             return null;
//           }
//
//           if (null == snapshot.data || snapshot.data.length == 0) {
//             return RaisedButton(
//               child: Text("Click"),
//               onPressed: _showDialog,
//             );
//
//           }
//
//           return CircularProgressIndicator();
//         },
//       ),
//     );
//   }
//
//   _refreshList() {
//     setState(() {
//       str = dbHelper.getStr();
//     });
//   }
//
//
//   _showDialog() {
//     showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           // title: Text("Step 3.2"),
//           // shape: RoundedRectangleBorder(),
//             content: Form(
//               key: formKey,
//               child: Container(
//                 height: 140,
//                 child: Column(
//                   children: <Widget>[
//                     Text("Enter your Strength"),
//                     // SizedBox(height: 5.0,),
//                     TextFormField(
//                       keyboardType: TextInputType.text,
//                       decoration: InputDecoration(
//                         labelText: 'Description',
//                         hintText: 'ex. Sociable',
//                         hintStyle: kHintTextStyle,
//                         // border: InputBorder.none,
//                         // contentPadding: EdgeInsets.all(8.0)
//                       ),
//                       onSaved: (val) => strDesc = val,
//                     ),
//
//
//                   ],
//                 ),
//               ),
//             ),
//             actions: <Widget>[
//               FlatButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: Text('Cancel')),
//               FlatButton(
//                 onPressed: _save,
//                 child: Text("Save"),
//               ),
//             ]));
//   }
//
//   _save() {
//     if(formKey.currentState.validate()){
//       formKey.currentState.save();
//       Strength e = Strength(null, strDesc, userId);
//
//       dbHelper.saveStr(e);
//     }
//     _refreshList();
//     Navigator.pop(context);
//   }
//
//   form() {
//     return Form(
//         child: Container(
//           height: 200,
//           padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
//           child: Column(
//             children: [
//               Text("Identify your Strengths"),
//               SizedBox(height: 20.0,),
//               Container(
//                   width: 350.0,
//                   child: TextFormField(
//                     keyboardType: TextInputType.text,
//                     decoration: InputDecoration(
//                         labelText: "Core Strength",
//                         contentPadding: EdgeInsets.all(8.0)),
//                   )),
//               SizedBox(height: 20.0,),
//             ],
//           ),
//         ));
//   }
// }

