import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifemap_v7/constants.dart';
import 'package:lifemap_v7/db/database_helper.dart';
import 'package:lifemap_v7/models/strength.dart';
import 'package:lifemap_v7/models/user.dart';
import 'package:lifemap_v7/screens/userProfileScreen.dart';

class homeScreen extends StatefulWidget {
  @override
  _homeScreen createState() => _homeScreen();
}

class _homeScreen extends State<homeScreen> {
  Future<List<User>> user;
  List<PieChartSectionData> _sections = List<PieChartSectionData>();

  // String fName = user.fName;
  String _fName;

  final formKey = new GlobalKey<FormState>();

  var dbHelper, getUsers;

  void initState() {
    super.initState();
    dbHelper = DBHelper();
    // getUsers = User(user);
    // print();
    // user = users;
    // print(DBHelper().getUser());

    //pie chart sample data

    PieChartSectionData _item1 = PieChartSectionData(
        color: Colors.red,
        value: 40,
        title: 'Liabilities',
        radius: 70
    );
    PieChartSectionData _item2 = PieChartSectionData(
        color: Colors.green,
        value: 40,
        title: 'Assets',
        radius: 70
    );
    PieChartSectionData _item3 = PieChartSectionData(
        color: Colors.blue,
        value: 20,
        title: 'profit',
        radius: 70
    );
    _sections = [_item1,_item2,_item3];

    //sample data ends here
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
              title: Text("Hello World"),
              elevation: 0.0,
              backgroundColor: Colors.transparent.withOpacity(0.2),
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: Colors.blueAccent),
                    accountName: new Text('User'),
                    accountEmail: new Text('TechMap.dev@test.com'),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: AssetImage('Assets/background.png'),
                    ),
                  ),
                  ListTile(
                    title: Text('Profile'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => userProfile()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text("Item 2"),
                  ),

                ],
              ),
            ),
            body: ListView(
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              children: <Widget>[
                SizedBox(height: 40,),
                Text('Reminders',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 5,),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 0.5
                    )
                  ),
                  child: Column(
                    children: <Widget>[
                      // RaisedButton(onPressed: print(getUsers.fName),),

                    ],
                  ),
                ),// Time/schedule
                SizedBox(height: 20.0,),
                Container(
                  height: 200,
                 decoration: BoxDecoration(
                   color: Colors.white70.withOpacity(0.3),
                   border: Border.all(
                     color: Colors.black,
                     width: 0.5
                   )
                 ),
                 child: Center(
                   child: DataTable(
                     columns: [
                       DataColumn(
                         label: Text(
                           'Strength',
                           style: TextStyle(
                               fontSize: 15,
                               fontWeight: FontWeight.w400,
                               color: Colors.black),
                         ),
                       ),
                       DataColumn(
                         label: Text('Weakness',
                             style: TextStyle(
                                 fontSize: 15,
                                 fontWeight: FontWeight.w400,
                                 color: Colors.black),
                           textAlign: TextAlign.right,
                         ),
                       ),
                     ],
                     rows: <DataRow>[]
                   ),
                 ),
                ),
                // Talent
                SizedBox(height: 30,),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 150, vertical: 80),
                  child: Text('Progress',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 25
                    ),
                  ),
                ),

                //monthly report
                Text('Monthly Report',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.all(80),
                  decoration: BoxDecoration(
                    color: Colors.white70.withOpacity(0.3),
                    border: Border.all(
                      color: Colors.black,
                      width: 0.5
                    )
                  ),
                  // height: 100,
                  // width: 100,
                  child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text('Past Month'),
                            SizedBox(height: 5.0,),
                            PieChart(PieChartData(
                                sections: _sections,
                                centerSpaceRadius: 10.0,
                                borderData: FlBorderData(show: false),
                                sectionsSpace: 0,

                            ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10,),
                        Column(
                          children: <Widget>[
                            Text('Present Month'),
                            SizedBox(height: 5.0,),
                            PieChart(PieChartData(
                                sections: _sections,
                                centerSpaceRadius: 10.0,
                                borderData: FlBorderData(show: false),
                                sectionsSpace: 0),
                            ),
                          ],
                        ),
                        SizedBox(width: 10,),
                        Column(
                          children: <Widget>[
                            Text('Next Month'),
                            SizedBox(height: 5.0,),
                            PieChart(PieChartData(
                                sections: _sections,
                                centerSpaceRadius: 10.0,
                                borderData: FlBorderData(show: false),
                                sectionsSpace: 0),
                            ),
                          ],
                        ),
                        SizedBox(width: 10,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40,),

                //yearly report
                Text('Yearly Report',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.all(80),
                  decoration: BoxDecoration(
                    color: Colors.white70.withOpacity(0.3),
                      border: Border.all(
                          color: Colors.black,
                          width: 0.5
                      )
                  ),
                  // height: 100,
                  // width: 100,
                  child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text('Goals Past 5 years'),
                            SizedBox(height: 5.0,),
                            PieChart(PieChartData(
                                sections: _sections,
                                centerSpaceRadius: 10.0,
                                borderData: FlBorderData(show: false),
                                sectionsSpace: 0),
                            ),
                          ],
                        ),
                        SizedBox(width: 10,),
                        Column(
                          children: <Widget>[
                            Text('Present Present Year Goal'),
                            SizedBox(height: 5.0,),
                            PieChart(PieChartData(
                                sections: _sections,
                                centerSpaceRadius: 10.0,
                                borderData: FlBorderData(show: false),
                                sectionsSpace: 0),
                            ),
                          ],
                        ),
                        SizedBox(width: 10,),
                        Column(
                          children: <Widget>[
                            Text('Goal after 5 Years'),
                            SizedBox(height: 5.0,),
                            PieChart(PieChartData(
                                sections: _sections,
                                centerSpaceRadius: 10.0,
                                borderData: FlBorderData(show: false),
                                sectionsSpace: 0),
                            ),
                          ],
                        ),
                        SizedBox(width: 10,),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }


  _showDialog(User user) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          // title: Text("Step 3.2"),
          // shape: RoundedRectangleBorder(),
            content: Container(
              height: 140,
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    child: Text("press"),
                    onPressed: () {
                      print(user.fName);
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[

            ]));
  }

  _listCash() {
    return Expanded(
      child: FutureBuilder(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _showDialog(snapshot.data);

          }


//          refreshList();
          return CircularProgressIndicator();
        },
      ),
    );
  }

}
