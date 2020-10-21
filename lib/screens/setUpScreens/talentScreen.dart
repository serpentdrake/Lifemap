import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifemap_v7/constants.dart';
import 'package:lifemap_v7/db/database_helper.dart';
import 'package:lifemap_v7/models/strength.dart';

class talentScreen1 extends StatefulWidget {
  @override
  _talentScreenState createState() => _talentScreenState();
}

class _talentScreenState extends State<talentScreen1> {
  Future<List<Strength>> str;

  int userId, ctr = 0;
  String strDesc, title;

  bool _setActive, isUpdate, isCoreStr;

  final formKey = new GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = "Core Strength";
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
                        style: GoogleFonts.getFont('Alice', textStyle:TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Text('"Strength"',
                        style: GoogleFonts.getFont('Alice', textStyle:TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                      ),
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
      str = DBHelper().getStr();
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
    if(formKey.currentState.validate()){
      formKey.currentState.save();
      Strength e = Strength(null, strDesc, userId);

      DBHelper().saveStr(e);
    }
    setState(() {
      title = "Strength";
    });
    ctr++;
    print(ctr);
    _refreshList();
    Navigator.pop(context);
  }

  _next() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => null));
  }

  Container dataList(List<Strength> str) {
    return Container(
      child: DataTable(
        dividerThickness: 0,
        columns: [
          DataColumn(
            label: Text("Strength",
              style: GoogleFonts.getFont('Alice', textStyle:TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
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
                // decoration: BoxDecoration(
                //   color: Colors.white,
                //   boxShadow: [
                //     BoxShadow(
                //       color: Colors.grey.withOpacity(0.5),
                //       spreadRadius: 5,
                //       blurRadius: 7,
                //       offset: Offset(0, 3), // changes position of shadow
                //     ),
                //   ]
                // ),
                child: ListTile(
                  title: Text(str.strDesc),
                  trailing: IconButton( highlightColor: Colors.transparent, splashColor: Colors.transparent ,icon: Icon(Icons.more_vert), onPressed: (){}),
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
                  Text('Talent Management is the key'
              'ingredient in goal setting as it can'
              'determine the success or failure of your'
              'future plan' ,
                    style: GoogleFonts.getFont('Alice', textStyle:TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10,),
                  Text('Let\'s start by  determining your Strengths where the first one you enter is your core Strength',
                    style: GoogleFonts.getFont('Alice', textStyle:TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                      letterSpacing: 0.5
                    ),
                    textAlign: TextAlign.center,
                  ),
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

