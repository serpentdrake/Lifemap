import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lifemap_v7/db/database_helper.dart';
import 'package:lifemap_v7/models/indicator.dart';
import 'package:lifemap_v7/models/timeAllot.dart';
import 'package:lifemap_v7/screens/homescreen.dart';

class TimeAlotment extends StatefulWidget {
  @override
  _TimeAlotmentState createState() => _TimeAlotmentState();
}

class _TimeAlotmentState extends State<TimeAlotment> {
  List<PieChartSectionData> _sections;

  Future<List<WeekSched>> weekSched;

  final _formKey = new GlobalKey<FormState>();
  double workHours;
  double leisureHours;
  double restHours;
  final TextEditingController inputVal = TextEditingController();

  // @override
  // void setState(fn) {
  //   // TODO: implement setState
  //   super.setState(fn);
  //   PieChartSectionData works = PieChartSectionData(
  //       color: Colors.red, value: workHours, title: '$workHours%', radius: 70);
  //   PieChartSectionData leisure = PieChartSectionData(
  //       color: Colors.green,
  //       value: leisureHours,
  //       title: '$leisureHours%',
  //       radius: 70);
  //
  //   PieChartSectionData rest = PieChartSectionData(
  //       color: Colors.blue, value: restHours, title: '$restHours%', radius: 70);
  //   _sections = [works, leisure, rest];
  // }

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
              title: Text('TIME ALLOCATION'),
              elevation: 0.0,
              backgroundColor: Colors.transparent.withOpacity(0.2),
            ),
            body: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        border: Border.all(color: Colors.black, width: 0.3)),
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Text(
                            'Time Alotment',
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(12),
                            width: 250,
                            child: Text(
                              'Time allotment is where you designate your 24 hours, it shows where you spend most of your time in your day to day basis',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50,),
                form(),

                SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        border: Border.all(color: Colors.black, width: 0.3)),
                    child: Column(
                      children: <Widget>[
                        Indicator(
                          color: Colors.red,
                          text: 'work hours',
                          isSquare: true,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Indicator(
                          color: Colors.blue,
                          text: 'rest/leisure hours',
                          isSquare: true,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Indicator(
                          color: Colors.green,
                          text: 'advocacy hours',
                          isSquare: true,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        AspectRatio(
                          aspectRatio: 1,
                          child: PieChart(
                            PieChartData(
                              sections: _sections,
                              centerSpaceRadius: 50,
                              borderData: FlBorderData(show: false),
                              sectionsSpace: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  form() {
    return Form(
      key: _formKey,
        child: Column(children: <Widget>[
      Container(
        height: 280,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.white70,
              border: Border.all(color: Colors.black, width: 0.3)),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(12),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'How long do you often work?',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(8)),
                    onChanged: (text) {
                      setState(() {
                        workHours = double.parse(text);
                      });
                    },
                    // onFieldSubmitted: (value) async {
                    //   if (value != "") {
                    //     DBHelper _dbhelper = DBHelper();
                    //     WeekSched _newSched =
                    //         WeekSched(work: double.parse(value));
                    //     await _dbhelper.insertTimeAllot(_newSched);
                    //   }
                    // },
                    onSaved: (val) => workHours = double.parse(val),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'How much Advocacy time do you often have??',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(8)),
                    onChanged: (text) {
                      setState(() {
                        leisureHours = double.parse(text);
                      });
                    },
                    // onFieldSubmitted: (value) async {
                    //   if (value != "") {
                    //     DBHelper _dbhelper = DBHelper();
                    //     WeekSched _newSched =
                    //         WeekSched(advoc: double.parse(value));
                    //     await _dbhelper.insertTimeAllot(_newSched);
                    //   }
                    // },
                    onSaved: (val) => leisureHours = double.parse(val),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  child: TextFormField(
                    
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText:
                              'How much Rest/Leisure time do you often have?',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(8)),
                      onChanged: (text) {
                        setState(() {
                          restHours = double.parse(text);
                        });
                      },
                      // onFieldSubmitted: (value) async {
                      //   if (value != "") {
                      //     DBHelper _dbhelper = DBHelper();
                      //     WeekSched _newSched =
                      //         WeekSched(rest: double.parse(value));
                      //     await _dbhelper.insertTimeAllot(_newSched);
                      //   }
                      // },
                    onSaved: (val) => restHours = double.parse(val),
                      ),
                ),
              ],
            ),
          )
      ),
          RaisedButton(
            child: Text('Save'),
              onPressed: (){
              setState(() {
                PieChartSectionData works = PieChartSectionData(
                    color: Colors.red, value: workHours, title: '$workHours%', radius: 70);
                PieChartSectionData leisure = PieChartSectionData(
                    color: Colors.green,
                    value: leisureHours,
                    title: '$leisureHours%',
                    radius: 70);

                PieChartSectionData rest = PieChartSectionData(
                    color: Colors.blue, value: restHours, title: '$restHours%', radius: 70);
                _sections = [works, leisure, rest];
              });
      if (_formKey.currentState.validate()) {
        DBHelper _db = DBHelper();
        _formKey.currentState.save();

       WeekSched week =
        WeekSched(work: workHours, advoc: leisureHours, rest: restHours);
       _db.insertTimeAllot(week);

      }
    }

          ),
    ]
        )
    );
  }
}
