import 'package:flutter/material.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/screens/home/task/taskPage.dart';
import 'package:task_app/services/database.dart';
import 'package:task_app/models/user.dart';
import 'package:provider/provider.dart';
import 'package:task_app/shared/loading.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  TaskTile({this.task});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final displayTime = task.time.substring(10, 15);

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            leading: Checkbox(
              value: task.checked,
              activeColor: Colors.purple,
              onChanged: (bool newVal) {
                DatabaseService(uid: user.uid)
                    .createUserData(task.name, task.time, newVal, task.tuid);
              },
            ),
            title: Text(task.name,
                style: (task.checked
                    ? TextStyle(decoration: TextDecoration.lineThrough)
                    : TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0))),
            subtitle: Text('Due At:$displayTime',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            trailing: ((task.checked == true)
                ? FlatButton.icon(
                    icon: Icon(Icons.delete),
                    label: Text('Delete'),
                    onPressed: () {
                      DatabaseService().deleteUserData(task.name, task.tuid);
                    },
                  )
                : FlatButton(
                    child: Icon(Icons.mode_edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TaskPage(task.name, task.time,
                                task.checked, task.puid, task.tuid)),
                      );
                    },
                  )),
          )),
    );
  }
}
