import 'package:task_app/services/auth.dart';
import 'package:task_app/models/task.dart';
import 'package:flutter/material.dart';
import 'package:task_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:task_app/screens/home/task_list.dart';
import 'package:task_app/shared/taskID.dart';
import 'package:task_app/models/user.dart';


class Home extends StatelessWidget {
  
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TaskUser>(context);    

    return StreamProvider<List<Task>>.value(
      value: DatabaseService().tasks,
      child: Scaffold(
        backgroundColor: Colors.purple[80],
        appBar: AppBar(
          title: Text('Todays Tasks'),
          backgroundColor: Colors.purple[500],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
        body: TaskList(),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          backgroundColor: Colors.purple[500],
          onPressed: () async {
            String randomString = Utils().createCrypto();
            String currentTime =  TimeOfDay.now().toString();

            await DatabaseService(uid: user.uid).createUserData(
                'new task', 
                currentTime,
                false, 
                randomString
            );
          },
        ),
      ),
    );
  }
}
