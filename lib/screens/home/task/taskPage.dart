import 'package:flutter/material.dart';
//import 'package:flutter/src/material/time_picker.dart';
import 'package:brew_crew/shared/constants.dart';
//import 'package:brew_crew/shared/TaskClass.dart';
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';

class TaskPage extends StatefulWidget {
  final String name;
  final String time;
  final bool checked;
  final String puid;
  final String tuid;

  const TaskPage(this.name,this.time, this.checked, this.puid, this.tuid);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  String taskName = '';
  String taskID = '';
  String taskUID = '';
  String displayTime = '';

  TimeOfDay time = TimeOfDay(hour: 15, minute: 0);
  TimeOfDay pickedTime = TimeOfDay.now();

  Future<Null> selectTime(BuildContext context) async {
    final TimeOfDay pickedTime =
        await showTimePicker(context: context, initialTime: time);

    if (pickedTime != null && pickedTime != time) {
      print(pickedTime);
      setState(() {
        time = pickedTime;
      });
    }
  }

  @override
  void initState() {
    super.initState();
//    displayTime = widget.time;
    taskName = widget.name;
  }

  // print()
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      backgroundColor: Colors.purple[80],
      appBar: AppBar(
        title: Text('Edit task'),
        backgroundColor: Colors.purple[500],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.delete_forever),
            label: Text('Delete'),
            onPressed: () {
              DatabaseService().deleteUserData(widget.name, widget.tuid);
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
              child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                initialValue: taskName,
                decoration: textInputDecoration.copyWith(hintText: 'Task Name'),
                onChanged: (val) {
                  setState(() {
                    taskName = val;
                  });
                },
              ),
              SizedBox(height: 20.0),
              Row(
                children: <Widget>[
                  RaisedButton(
                    color: Colors.white,
                    child: Icon(Icons.timer),
                    onPressed: () {
                      selectTime(context);
                      print(time);
                    },
                  ),
                  SizedBox(width: 12.0),
                  Text(displayTime)
                ],
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                  color: Colors.purple[800],
                  child: Text(
                    'Done',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    print('taskpage');
                    print(pickedTime.toString());

                    await DatabaseService(uid: user.uid)
                        .createUserData(taskName, pickedTime.toString(), widget.checked, widget.tuid);
                    Navigator.pop(context);
                  }),
              SizedBox(height: 12.0),
            ],
          ))),
    );
  }
}
