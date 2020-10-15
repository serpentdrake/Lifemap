// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:lifemap_v7/db/database_helper.dart';
// import 'package:intl/intl.dart';
// import 'package:lifemap_v7/constants.dart';
// import 'dart:async';
// import 'package:lifemap_v7/models/user.dart';
// import 'package:lifemap_v7/screens/homescreen.dart';
//
//
// class birthScreen extends StatefulWidget {
//   String passedFname, passedLname;
//   birthScreen({this.passedFname, this.passedLname});
//
//   @override
//   _birthScreen createState() => _birthScreen(passedFname, passedLname);
// }
//
// class _birthScreen extends State<birthScreen> {
//
//   String passedFname, passedLname, date;
//   _birthScreen(this.passedFname, this.passedLname);
//
//   final formKey = new GlobalKey<FormState>();
//
//   Future _chooseDate(BuildContext context, String initialDateString) async {
//     var now = new DateTime.now();
//     var initialDate = convertToDate(initialDateString) ?? now;
//     initialDate = (initialDate.year >= 1900 && initialDate.isBefore(now) ? initialDate : now);
//
//     var result = await showDatePicker(
//         context: context,
//         initialDate: initialDate,
//         firstDate: new DateTime(1900),
//         lastDate: new DateTime.now());
//
//     if (result == null) return;
//
//     setState(() {
//       _controller.text = new DateFormat.yMd().format(result);
//     });
//   }
//
//   DateTime convertToDate(String input) {
//     try
//         {
//           var d = new DateFormat.yMd().parse(input);
//           return d;
//         } catch (e) {
//       return null;
//     }
//   }
//
//
//
//   final TextEditingController _controller = new TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Creation',
//           style: TextStyle(
//               fontWeight: FontWeight.w200,
//               color: Colors.black
//           ),
//         ),
//       ),
//       body: Stack(
//         children: <Widget>[
//
//           Container(
//             height: double.infinity,
// //            decoration: BoxDecoration(
// //              image: DecorationImage(
// //                image: AssetImage('images/assets/background2.jpg'),
// //                fit: BoxFit.cover,
// //              ),
// //            ),
//             child: SingleChildScrollView(physics: AlwaysScrollableScrollPhysics(),
//               padding: EdgeInsets.symmetric(
//                 horizontal: 48.0,
//                 vertical: 20.0,
//               ),
//               child: Column(
//                 children: <Widget>[
//                   SizedBox(height: 20.0,),
//
//                   form(),
//
//                   SizedBox(height: 30.0,),
//
//
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   form() {
//     return Form (
//       key: formKey,
//       child: Padding(
//         padding: EdgeInsets.all(15.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           verticalDirection: VerticalDirection.down,
//           children: <Widget>[
//
//             TextFormField(
//               keyboardType: TextInputType.datetime,
//               style: TextStyle(color: Colors.black54,
//                 fontFamily: 'ArialMtBold',),
//               decoration: InputDecoration(
//                 labelText: 'Date of Birth',
//                 hintText: 'M/DD/YYYY',
// //                contentPadding: EdgeInsets.only(top: 20.0,),
//                 hintStyle: kHintTextStyle,
//               ),
//
//               // validator: (val) => val.length ==  0 ? 'This field is required.' : null,
//               onChanged: (val) => date = val,
//
//
//             ),
//
//
//
//
//             SizedBox(height: 7.0,),
//
//
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 FlatButton(
//                   splashColor: Colors.blueGrey,
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => homeScreen(fName: passedFname, lName: passedLname, date: date,)),
//                     );
//                   },
//                   child: Text('Next'),
//                 ),
//                 // FlatButton(
//                 //   splashColor: Colors.blueGrey,
//                 //   onPressed: (){},
//                 //   child: Text('Cancel'),
//                 // ),
//               ],
//             ),
//
//             SizedBox(height: 30.0,),
// //            Text ('Age: '+age.toString()),
//           ],
//         ),
//       ),
//     );
//   }
// }