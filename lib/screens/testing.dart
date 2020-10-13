import 'package:flutter/material.dart';

class Testing extends StatefulWidget {
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {

  TextEditingController test = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 30,),
                RaisedButton(
                  child: Text('Press Me'),
                    onPressed: _showDialog )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _showDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            content: Container(
              height: 140,
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Description'),
                    controller: test ,
                  ),
                  SizedBox(height: 5.0,),
                  TextField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    controller: test ,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(onPressed: (){ Navigator.pop(context);}, child: Text('Cancel')),
              FlatButton(
                  child: Text('Save'),
                  onPressed: () {
                        Navigator.pop(context);
                      }
                  )
            ]
        )
    );
  }
}
