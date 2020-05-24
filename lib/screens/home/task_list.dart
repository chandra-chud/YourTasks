import 'package:flutter/material.dart';
import 'package:task_app/models/task.dart';
import 'package:provider/provider.dart';
import 'package:task_app/screens/home/task_tile.dart';
import 'package:task_app/models/user.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context){
    var tasks = Provider.of<List<Task>>(context);
    final user = Provider.of<User>(context);    
    final List<Task> filterTask = [];
        
    for(var x in tasks){
      if(x.puid == user.uid){
        filterTask.add(x);
      }
    }

    tasks = filterTask;
    
    return Row(
      children: <Widget>[
        Expanded(
              child: ListView(
                children: tasks.map((task) => TaskTile(task: task)).toList()
          ),
        ),  
        ],        
    );

  }
}
