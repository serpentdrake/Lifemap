import 'package:flutter/material.dart';
import 'package:lifemap_v7/constants.dart';

class WorkEmploymentData extends StatefulWidget {
  @override
  _WorkEmploymentDataState createState() => _WorkEmploymentDataState();
}

class _WorkEmploymentDataState extends State<WorkEmploymentData> {
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
                  body:ListView(
                    children: <Widget>[
                      //title texts
                      SizedBox(height: 40,),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Text('Work Employment Data',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 30,),

                      //checkBoxes
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text('Employed',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Checkbox(value: false, onChanged: null ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('UnEmployed',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Checkbox(value: false , onChanged: null),
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
                            SizedBox(width: 10,),
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
                            SizedBox(width: 10,),
                            Container(
                              width: 120,
                              child: TextFormField(
                                initialValue: '60',
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(8),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20,),

                      Column(
                        children: <Widget>[
                          RaisedButton(
                            child: Text('Next'),
                              onPressed: (){}),
                        ],
                      )

                    ],
                  ),
                )
              ]
          )
      ),
    );
  }
}
