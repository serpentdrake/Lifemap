import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TimeAlotment extends StatefulWidget {
  @override
  _TimeAlotmentState createState() => _TimeAlotmentState();
}

class _TimeAlotmentState extends State<TimeAlotment> {

  List<PieChartSectionData> _sections = List<PieChartSectionData>();

  double workHours;
  double leisureHours;
  double restHours;
  TextEditingController inputVal = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    PieChartSectionData works = PieChartSectionData(
        color: Colors.red,
        value: workHours,
        title: '$workHours%',
        radius: 70
    );
    PieChartSectionData leisure = PieChartSectionData(
        color: Colors.green,
        value: leisureHours,
        title: '$leisureHours%',
        radius: 70
    );

    PieChartSectionData rest = PieChartSectionData(
        color: Colors.blue,
        value: restHours,
        title: '$restHours%',
        radius: 70
    );

    _sections = [works, leisure, rest];

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Scaffold(
            body: ListView(
              children: <Widget>[
                Center(
                  child: Text('Time Alotment',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),
                  ) ,
                ),
                SizedBox(height: 20,),
                Center(
                  child: Container(
                    width: 250,
                    child: Text('Time alotment is where you designate where you spend most of your time in your day to day basis',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                SizedBox(height: 40,),
                Container(
                    child: TextFormField(
                      controller: inputVal,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'How long do you often work?',
                        border: InputBorder.none
                      ),
                      onSaved: (text){

                          workHours = double.parse(inputVal.text);
                          inputVal.clear();

                      },
                    ),
                ),
                SizedBox(height: 20,),
                Container(
                  child: TextFormField(
                    controller: inputVal,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'How much leisure time do you often have??',
                        border: InputBorder.none
                    ),
                    onSaved: (text){

                        leisureHours = double.parse(text);
                        inputVal.clear();

                    },
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  child: TextFormField(
                    controller: inputVal,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'How much rest do you often have?',
                        border: InputBorder.none
                    ),
                    onSaved: (text){

                        restHours = double.parse(text);
                        inputVal.clear();

                    },
                  ),
                ),
                SizedBox(height: 50,),
                PieChart(PieChartData(
                  sections: _sections,
                  centerSpaceRadius: 10.0,
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 0,

                ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
