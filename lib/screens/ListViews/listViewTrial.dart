import 'package:flutter/material.dart';

class ListViewSample extends StatefulWidget {
  @override
  _ListViewSampleState createState() => _ListViewSampleState();
}

class _ListViewSampleState extends State<ListViewSample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
            itemCount: 10 ,
            itemBuilder: (_, index){
              return Card(
                child: Container(
                  height: 80,
                    width: 120,
                    child: Text('List item no. ${index + 1}')
                ),
                elevation: 6.0,
              );
            }
        ),
      ),
    );
  }
}
