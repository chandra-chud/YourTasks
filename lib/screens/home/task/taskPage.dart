import 'package:flutter/material.dart';
import 'package:task_app/shared/constants.dart';
import 'package:task_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:task_app/models/user.dart';

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
  String displayTime = '';
  String displayTimeFormatted = '';

  TimeOfDay time = TimeOfDay.now();
  TimeOfDay pickedTime = TimeOfDay(hour: 15, minute: 0);

  //time picker function
  Future<Null> selectTime(BuildContext context) async {
    final TimeOfDay pickedTime =
        await showTimePicker(context: context, initialTime: time);

    if (pickedTime != null && pickedTime != time) {
      setState(() {
        time = pickedTime;
        displayTime = time.toString();
        displayTimeFormatted = displayTime.substring(10, 15);
      });
    }
  }


  @override
  void initState() {
    super.initState();
    displayTime = widget.time.toString();
    displayTimeFormatted = displayTime.substring(10, 15);
    taskName = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TaskUser>(context);

    return Scaffold(
      backgroundColor: Colors.purple[80],
      appBar: AppBar(
        title: Text('Edit task'),
        backgroundColor: Colors.purple[500],
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary :Colors.white),
                    child: Icon(Icons.timer),
                    onPressed: () {
                      selectTime(context);
                      displayTime = time.toString();
                      displayTimeFormatted = displayTime.substring(10, 15);
                    },
                  ),
                  SizedBox(width: 12.0),
                  Text(displayTimeFormatted)
                ],
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary :Colors.purple[800]),
                  child: Text(
                    'Done',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    print('taskpage');
                    print(displayTime);

                    await DatabaseService(uid: user.uid)
                        .createUserData(taskName, displayTime, widget.checked, widget.tuid);
                    // redirect to the previous page
                    Navigator.pop(context);
                  }),
              SizedBox(height: 12.0),
            ],
          ))),
    );
  }
}
