import 'dart:ffi';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifemap_v7/Time/tasks.dart';
import 'package:lifemap_v7/Time/timeAlotment.dart';
import 'package:lifemap_v7/constants.dart';
import 'package:lifemap_v7/db/database_helper.dart';
import 'package:lifemap_v7/models/strength.dart';
import 'package:lifemap_v7/models/timeAllot.dart';
import 'package:lifemap_v7/models/user.dart';
import 'package:lifemap_v7/models/weakness.dart';
import 'package:lifemap_v7/screens/setUpScreens/talentScreen.dart';
import 'package:lifemap_v7/screens/setUpScreens/talentScreenStrength.dart';
import 'package:lifemap_v7/screens/setUpScreens/talentScreenWeak.dart';
import 'package:lifemap_v7/screens/Edits/strengthEdit.dart';
import 'package:lifemap_v7/screens/userProfileScreen.dart';

class homeScreen extends StatefulWidget {
  @override
  _homeScreen createState() => _homeScreen();
}

class _homeScreen extends State<homeScreen> {



  Future <List<Strength>> str;
  Future <List<Weakness>> weak;

  var temp;
  int pastMonth;
  int currentMonth;

  var work;
  var advoc;
  var rest;

  Future<List<User>> user;
  List<PieChartSectionData> _sections = List<PieChartSectionData>();
  List<PieChartSectionData> tasking =  List<PieChartSectionData>();



  Future <List<WeekSched>> works;
  // String fName = user.fName;
  String _fName;

  bool isTrue;

  final formKey = new GlobalKey<FormState>();

  DBHelper _dbHelper = DBHelper();


  var dbHelper, getUsers;



  Future<void> initState()  {
    super.initState();
    _refreshList();
    currentMonth = DateTime.now().month;

    // getUsers = User(user);
    // print();
    // user = users;
    // print(DBHelper().getUser());

    //pie chart sample data
    PieChartSectionData _work = PieChartSectionData(
        color: Colors.red,
        value: 40,
        title: 'Work',
        radius: 70
    );
    PieChartSectionData _advocacy = PieChartSectionData(
        color: Colors.green,
        value: 20,
        title: 'Data 2',
        radius: 70
    );
    PieChartSectionData _rest = PieChartSectionData (
        color: Colors.blue,
        value: 40,
        title: 'Rest',
        radius: 70
    );
    tasking = [_work, _advocacy,_rest ];


    PieChartSectionData _item1 = PieChartSectionData(
        color: Colors.red,
        value: 40,
        title: 'Data 1',
        radius: 70
    );
    PieChartSectionData _item2 = PieChartSectionData(
        color: Colors.green,
        value: 40,
        title: 'Data 2',
        radius: 70
    );
    PieChartSectionData _item3 = PieChartSectionData(
        color: Colors.blue,
        value: 20,
        title: 'Data 3',
        radius: 70
    );

    _sections = [_item1,_item2,_item3];

    //sample data ends here
  }



  @override
  Widget build(BuildContext context) {

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.asset(
          'Assets/background2.png',
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("HOME"),
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
              Center(
                child: Text('Summary',
                  style: GoogleFonts.getFont('Alice', textStyle: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  )
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left:15.0),
                  child: Column(
                    children: <Widget>[
                      Text('Summary',
                        style: GoogleFonts.getFont('Alice', textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400
                        )
                        ),
                      ),

                      Text('Summary',
                        style: GoogleFonts.getFont('Alice', textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400
                        )
                        ),
                      ),
                      Text('Summary',
                        style: GoogleFonts.getFont('Alice', textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400
                        )
                        ),
                      ),
                      Text('Summary',
                        style: GoogleFonts.getFont('Alice', textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400
                        )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox( height: 30,),

              Container(
                height: 300,
               decoration: BoxDecoration(
                 color: Colors.white70.withOpacity(0.3),
                 border: Border.all(
                   color: Colors.black,
                   width: 0.5
                 )
               ),
               child: Center(
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     _listStr(),
                   ],
                 ),
               ),
              ),
              // Talent
              SizedBox(height: 30,),

              //monthly report
              Text('Monthly Report',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: double.infinity,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:<Widget>[
                      Padding(
                        padding: EdgeInsets.all(70.0),
                        child: Column(
                          children: <Widget>[
                            Text('Monthly Income/Expense Ratio'),
                            SizedBox(height: 5.0,),
                            GestureDetector(
                              onTap: (){},
                              child: PieChart(PieChartData(
                                  sections: _sections,
                                  centerSpaceRadius: 10.0,
                                  borderData: FlBorderData(show: false),
                                  sectionsSpace: 0,

                              ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding:  EdgeInsets.all(70.0),
                        child: Column(

                          children: <Widget>[
                            Text('Present Task'),
                            SizedBox(height: 5.0,),
                            PieChart(PieChartData(
                                sections: tasking,
                                centerSpaceRadius: 10.0,
                                borderData: FlBorderData(show: false),
                                sectionsSpace: 0),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding:  EdgeInsets.all(70.0),
                        child: Column(
                          children: <Widget>[
                            Text('Time Allocation'),
                            SizedBox(height: 5.0,),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => TimeAlotment()));
                              },
                              child: PieChart(PieChartData(
                                    sections: tasking,
                                    centerSpaceRadius: 10,
                                    borderData: FlBorderData(show: false),
                                    sectionsSpace: 0
                                  )
                                  )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40,),

              //yearly report
              Text('Annual Report',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400
                ),
              ),
              SizedBox(height: 10,),
              Container(
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
                      Padding(
                        padding: const EdgeInsets.all(70.0),
                        child: Column(
                          children: <Widget>[
                            Text('Goals Past 5 years'),
                            SizedBox(height: 5.0,),
                            GestureDetector(
                              onTap: (){},
                              child: PieChart(PieChartData(
                                  sections: _sections,
                                  centerSpaceRadius: 10.0,
                                  borderData: FlBorderData(show: false),
                                  sectionsSpace: 0),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(70),
                        child: Column(
                          children: <Widget>[
                            Text('Present Present Year Goal'),
                            SizedBox(height: 5.0,),
                            GestureDetector(
                              onTap: (){},
                              child: PieChart(PieChartData(
                                  sections: _sections,
                                  centerSpaceRadius: 10.0,
                                  borderData: FlBorderData(show: false),
                                  sectionsSpace: 0),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(70.0),
                        child: Column(
                          children: <Widget>[
                            Text('Goal after 5 Years'),
                            SizedBox(height: 5.0,),
                            GestureDetector(
                              onTap: (){},
                              child: PieChart(PieChartData(
                                  sections: _sections,
                                  centerSpaceRadius: 10.0,
                                  borderData: FlBorderData(show: false),
                                  sectionsSpace: 0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox( height: 30,),

              //weakness
              Container(
                height: 300,
                decoration: BoxDecoration(
                    color: Colors.white70.withOpacity(0.3),
                    border: Border.all(
                        color: Colors.black,
                        width: 0.5
                    )
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _listWeak(),
                    ],
                  ),
                ),
              ),

              SizedBox( height: 30,),
              Text('Motivational Quote',
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
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        height: 190,
                        child: FutureBuilder(
                          initialData: [],
                          future: _dbHelper.getTasks(),
                          builder: (context, snapshot){
                            return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context,index){
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: 180,
                                      child: Center(
                                        child: ListTile(
                                          title: Text(snapshot.data[index].title,
                                            style: GoogleFonts.getFont('Alice',
                                                textStyle: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w400
                                                )
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },

                        ),
                      ),
                    ],
                  )
              )

            ],
          ),
        ),
      ],
    );
  }

  _refreshList(){
        setState(() {
          str = _dbHelper.getStr();
          weak = _dbHelper.getWeak();

        });

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

  _listStr() {
    return FutureBuilder(
      initialData: [],
      future: str,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return dataTableStr(snapshot.data);
        }

        if(snapshot.data == 0 || snapshot.data.length == 0){
          return Center(child: Text("Has no Data"),);
        }
        return CircularProgressIndicator();
      },
    );
  }

  _listWeak() {
    return FutureBuilder(
      initialData: [],
      future: weak,
      builder: (context,snapshot){
        if(snapshot.hasData){
          return dataTableWeak(snapshot.data);
        }

        if(snapshot.data == 0 || snapshot.data.length == 0){
          return Center(child: Text("Has no Data"),);
        }
        return CircularProgressIndicator();
      },
    );
  }

  Container dataTableStr(List<Strength> str){
    return Container(
      child: DataTable(
        columns: [
          DataColumn(label: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => StrengthEdit(isTrue: true,))
              );
            },
              child: Text("Strength")
          )
          ),
        ],
        rows: str
          .map((str) => DataRow(cells: [
            DataCell(
              Text(str.strDesc),
            )
        ])).toList(),
      ),
    );
  }

  Container dataTableWeak(List<Weakness> weak){
    return Container(
      child: DataTable(
        columns: [
          DataColumn(
              label: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => talentScreenWeak())
                  );
                },
              child: Text("Weakness")
          )
          ),
        ],
        rows: weak
            .map((weak) => DataRow(cells: [
          DataCell(
            Text(weak.weakDesc),
          )
        ])).toList(),
      ),
    );
  }

   workSection() async {

     await _dbHelper.getTimeAllot();
    return FutureBuilder(
      initialData: [],
      future: _dbHelper.getTimeAllot(),
        builder: (context, snapShot){
        work = snapShot.data[0].work;
        return work;
        }
        );
  }

  advocSection() async {

    await _dbHelper.getTimeAllot();
    return FutureBuilder(
        initialData: [],
        future: _dbHelper.getTimeAllot(),
        builder: (context, snapShot){
          advoc = snapShot.data[0].advoc;
          return advoc;
        }
    );

  }

  restSection() async {
    await _dbHelper.getTimeAllot();
    return FutureBuilder(
        initialData: [],
        future: _dbHelper.getTimeAllot(),
        builder: (context, snapShot) {
          rest = snapShot.data[0].rest;
          return rest;
        }
    );
  }

  _loopMonths(){
    switch(currentMonth){
      case 1:
        {
          Column(
            children: <Widget>[
              Text('January'),
              Expanded(
                child: PieChart(PieChartData(
                    sections: _sections,
                    centerSpaceRadius: 10.0,
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0),
                ),
              ),
            ],
          );
        }
        break;

      case 2:
        {
          Column(
            children: <Widget>[
              Text('February'),
              Expanded(
                child: PieChart(PieChartData(
                    sections: _sections,
                    centerSpaceRadius: 10.0,
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0),
                ),
              ),
            ],
          );
        }
        break;

      case 3:
        {
          Column(
            children: <Widget>[
              Text('March'),
              Expanded(
                child: PieChart(PieChartData(
                    sections: _sections,
                    centerSpaceRadius: 10.0,
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0),
                ),
              ),
            ],
          );
        }
        break;

      case 4:
        {
          Column(
            children: <Widget>[
              Text('April'),
              Expanded(
                child: PieChart(PieChartData(
                    sections: _sections,
                    centerSpaceRadius: 10.0,
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0),
                ),
              ),
            ],
          );
        }
        break;

      case 5:
        {
          Column(
            children: <Widget>[
              Text('May'),
              Expanded(
                child: PieChart(PieChartData(
                    sections: _sections,
                    centerSpaceRadius: 10.0,
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0),
                ),
              ),
            ],
          );
        }
        break;

      case 6:
        {
          Column(
            children: <Widget>[
              Text('June'),
              Expanded(
                child: PieChart(PieChartData(
                    sections: _sections,
                    centerSpaceRadius: 10.0,
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0),
                ),
              ),
            ],
          );
        }
        break;

      case 7:
        {
          Column(
            children: <Widget>[
              Text('July'),
              Expanded(
                child: PieChart(PieChartData(
                    sections: _sections,
                    centerSpaceRadius: 10.0,
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0),
                ),
              ),
            ],
          );
        }
        break;

      case 8:
        {
          Column(
            children: <Widget>[
              Text('August'),
              Expanded(
                child: PieChart(PieChartData(
                    sections: _sections,
                    centerSpaceRadius: 10.0,
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0),
                ),
              ),
            ],
          );
        }
        break;

      case 9:
        {
          Column(
            children: <Widget>[
              Text('September'),
              Expanded(
                child: PieChart(PieChartData(
                    sections: _sections,
                    centerSpaceRadius: 10.0,
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0),
                ),
              ),
            ],
          );
        }
        break;

      case 10:
        {
          Column(
            children: <Widget>[
              Text('October'),
              Expanded(
                child: PieChart(PieChartData(
                    sections: _sections,
                    centerSpaceRadius: 10.0,
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0),
                ),
              ),
            ],
          );
        }
        break;

      case 11:
        {
          Column(
            children: <Widget>[
              Text('November'),
              Expanded(
                child: PieChart(PieChartData(
                    sections: _sections,
                    centerSpaceRadius: 10.0,
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0),
                ),
              ),
            ],
          );
        }
        break;

      case 12:
        {
          Column(
            children: <Widget>[
              Text('December'),
              Expanded(
                child: PieChart(PieChartData(
                    sections: _sections,
                    centerSpaceRadius: 10.0,
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0),
                ),
              ),
            ],
          );
        }
        break;
    }


  }

}
