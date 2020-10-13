import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifemap_v7/Time/tasks.dart';

class EditScreen extends StatefulWidget {
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
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
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(child: Treasure()),
                SizedBox(height: 50,),
                Center(child: _time(),),
                SizedBox(height: 50,),
                Center(child: Talent(),)
              ],
            ),
          ),

        ],
      ),
    );
  }
  Material Treasure(){
    return Material(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        width: 210,
        child: InkWell(
          onTap: (){},
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.note, size: 50,),
              Text('Treasure',
                style: TextStyle(
                  fontSize: 30
                ),
              ),
            ],
          ),
        ),
      ),
      elevation: 25.0,
      shadowColor: Colors.black54,
    );
  }

  Material _time(){
    return Material(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        width: 210,
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => TaskScreen()));
          } ,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.watch_later, size: 50,),
              Text('Time',
                style: TextStyle(
                    fontSize: 30
                ),
              ),
            ],
          ),
        ),
      ),
      elevation: 25.0,
      shadowColor: Colors.black54,
    );
  }
  Material Talent(){
    return Material(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        width: 210,
        child: InkWell(
          onTap: (){},
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.accessibility_new, size: 50,),
              Text('Talent',
                style: TextStyle(
                    fontSize: 30
                ),
              ),
            ],
          ),
        ),
      ),
      elevation: 25.0,
      shadowColor: Colors.black54,
    );
  }
}
