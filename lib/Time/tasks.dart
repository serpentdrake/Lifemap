import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<String> tasks;
  List<bool> isCompleted;
  int completedTask = 0;
  int aindex = 0;
  TextEditingController taskName = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tasks = [];
    isCompleted = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          BackButton(
            onPressed: (){
              Navigator.pop(context, [tasks.length,completedTask]);
            },
          )
        ],
      ),
      body: Container(
        child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (BuildContext context, index) {
              return Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ]
                ),
                child: ListTile(
                  title: Text(tasks[index]),
                  leading: Checkbox(
                    activeColor: Colors.white,
                    checkColor: Colors.green,
                      value: isCompleted[index],
                      onChanged: (val) {
                      setState(() {
                        isCompleted[index] = !isCompleted[index];
                        completedTask +=1;
                      });
                      }),
                  trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed:(){
                        setState(() {
                          tasks.removeAt(index);
                          aindex -=1;
                          if(isCompleted[index] = true){
                            completedTask -=1;
                          }
                        });

                      }
                  ) ,

                ),
              );
            }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
          onPressed: _showDialog),
    );

  }
  _showDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            content: TextField(
              controller: taskName,
            ),
        actions: <Widget>[
          FlatButton(
            child: Text('Add'),
            onPressed: (){
              setState(() {
                if(aindex == 0) {
                  tasks.insert(aindex, taskName.text);
                  aindex +=1;
                  print(aindex);
                } else if(aindex != 0){
                  tasks.insert(aindex, taskName.text);
                  aindex +=1;
                  print(aindex);
                }
                isCompleted.add(false);
                taskName.clear();
              });

              Navigator.pop(context);
            },),
        ],
        )
    );
  }




}