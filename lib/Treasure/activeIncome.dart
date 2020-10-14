import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActiveIncome extends StatefulWidget {
  @override
  _ActiveIncomeState createState() => _ActiveIncomeState();
}

class _ActiveIncomeState extends State<ActiveIncome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: (
      Stack(
        fit: StackFit.expand,
        children:<Widget>[
          Image.asset(
              'Assets/background2.png',
            fit: BoxFit.cover,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: ListView(
              children: <Widget>[

                //title texts
                SizedBox(height: 40,),
                Container(
                  child: Column(
                    children: <Widget>[
                      Text('Active Income',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          )
        ]
      )
      ),
    );
  }
//   SingleChildScrollView dataTableUser(List<Cash> cash) {
// //    var year;
//     return SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       child: Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(21),
//             color: Colors.white70
//         ),
//         child: Column(
//           children: <Widget>[
//             DataTable(
//               columns: [
//                 DataColumn(
//                   label: Text(
//                     'Description',
//                     style: TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.w400,
//                         color: Colors.black),
//                   ),
//                 ),
//                 DataColumn(
//                   label: Text('Value',
//                       style: TextStyle(
//                           fontSize: 25,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.black)),
//                 ),
//               ],
//               rows: cash
//                   .map(
//                     (cash) => DataRow(cells: [
//                   DataCell(
//                     Text(cash.cashDesc),
//                     onTap: () {},
//                   ),
//                   DataCell(
//                     Text(cash.cashVal.toString()),
//                     onTap: () {},
//                   ),
//                 ]),
//               )
//                   .toList(),
//             ),
//             SizedBox(
//               height: 20.0,
//             ),
//             Container(
//               child: Center(
//                 child: FloatingActionButton(
//                   elevation: 5.0,
//                   child: Icon(Icons.add),
//                   onPressed: _showDialog,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 20.0,
//             ),
//             Container(
//               child: Center(
//                 child: RaisedButton(
//                   elevation: 5.0,
//                   child: Text("Next"),
//                   onPressed: next,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//
//       //Add & Next Button
//     );
//   }
}
