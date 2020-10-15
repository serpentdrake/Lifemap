import 'package:flutter/material.dart';
import 'package:lifemap_v7/db/database_helper.dart';
import 'package:lifemap_v7/constants.dart';
import 'package:lifemap_v7/models/user.dart';

class WorkEmploymentData extends StatefulWidget {
  @override
  _WorkEmploymentDataState createState() => _WorkEmploymentDataState();
}

class _WorkEmploymentDataState extends State<WorkEmploymentData> {
  Future<List<User>> user;

  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = DBHelper().getUser();
    // user = DBHelper().getUser();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: (Stack(fit: StackFit.expand, children: <Widget>[
        Image.asset(
          'Assets/background2.png',
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: _loader(),
        )
      ])),
    );
  }

  _loader() {
    return FutureBuilder(
      future: user,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return employmentForms(snapshot.data);
        }
        if(snapshot.data == null || snapshot.data.length == 0){
          return Text("NoData");
        }
        return Center(child: CircularProgressIndicator());
      },

    );
  }

  Container employmentForms(List<User> user) {
    return Container(
      child: Form(
        key: formKey,
        child: DataTable(
          columns: [
            DataColumn(label: Text(""))
          ],
          rows: user
            .map((user) => DataRow(cells: [
              DataCell(
                ListView(
                  children: <Widget>[
                    //title texts
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Work Employment Data',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),



                    SizedBox(
                      height: 30,
                    ),

                    //checkBoxes
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                'Employed',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Checkbox(value: false, onChanged: null),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'UnEmployed',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Checkbox(value: false, onChanged: null),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: <Widget>[
                          Text('Monthly Income'),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 120,
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(8),
                                hintText: '0.00',
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: <Widget>[
                          Text('Retirement Age'),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 120,
                            child: TextFormField(
                              initialValue: user.retireAge.toString(),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(8),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),



                    Column(
                      children: <Widget>[
                        RaisedButton(child: Text('Next'), onPressed: () {}),
                      ],
                    )
                  ],
                )
              ),
          ])),
        )
      ),
    );
  }

  // ListView none(List<User> user) {
  //     child: Form(
  //       child: ListView(
  //         children: <Widget>[
  //           //title texts
  //           SizedBox(
  //             height: 40,
  //           ),
  //           Container(
  //             child: Column(
  //               children: <Widget>[
  //                 Text(
  //                   'Work Employment Data',
  //                   style: TextStyle(
  //                     fontSize: 30,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //
  //
  //
  //           SizedBox(
  //             height: 30,
  //           ),
  //
  //           //checkBoxes
  //           Padding(
  //             padding: const EdgeInsets.all(12.0),
  //             child: Row(
  //               children: <Widget>[
  //                 Row(
  //                   children: <Widget>[
  //                     Text(
  //                       'Employed',
  //                       style: TextStyle(
  //                         fontSize: 15,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                     Checkbox(value: false, onChanged: null),
  //                   ],
  //                 ),
  //                 Row(
  //                   children: <Widget>[
  //                     Text(
  //                       'UnEmployed',
  //                       style: TextStyle(
  //                         fontSize: 15,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                     Checkbox(value: false, onChanged: null),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //
  //           Container(
  //             padding: EdgeInsets.all(8),
  //             child: Row(
  //               children: <Widget>[
  //                 Text('Monthly Income'),
  //                 SizedBox(
  //                   width: 10,
  //                 ),
  //                 Container(
  //                   width: 120,
  //                   child: TextFormField(
  //                     decoration: InputDecoration(
  //                       contentPadding: EdgeInsets.all(8),
  //                       hintText: '0.00',
  //                     ),
  //                     keyboardType: TextInputType.number,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //
  //           Container(
  //             padding: EdgeInsets.all(8),
  //             child: Row(
  //               children: <Widget>[
  //                 Text('Retirement Age'),
  //                 SizedBox(
  //                   width: 10,
  //                 ),
  //                 Container(
  //                   width: 120,
  //                   child: TextFormField(
  //                     initialValue: user.ret,
  //                     decoration: InputDecoration(
  //                       contentPadding: EdgeInsets.all(8),
  //                     ),
  //                     keyboardType: TextInputType.number,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //
  //           SizedBox(
  //             height: 20,
  //           ),
  //
  //           Column(
  //             children: <Widget>[
  //               RaisedButton(child: Text('Next'), onPressed: () {}),
  //             ],
  //           )
  //         ],
  //       ),
  //     );
  // }
}
