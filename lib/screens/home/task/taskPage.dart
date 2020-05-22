import 'package:flutter/material.dart';
//import 'package:flutter/src/material/time_picker.dart';
import 'package:brew_crew/shared/constants.dart';


class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  String taskName = '';
  TimeOfDay time = TimeOfDay(hour: 15, minute: 0);
  TimeOfDay pickedTime = TimeOfDay.now();


  Future<Null> selectTime(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: time
    );

    if(pickedTime != null && pickedTime != time){
      print(pickedTime);
      setState(() {
        time = pickedTime;
      });
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[80],
      appBar: AppBar(
        title: Text('Brew Crew'),
        backgroundColor: Colors.purple[500],
        elevation: 0.0,
      ),
      body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Task Name'),
                      onChanged: (val) {
                        setState(() {
                          taskName = val;
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      color: Colors.white,
                      child: Icon(Icons.timer),
                      onPressed: (){
                        selectTime(context);
                        print(time);
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      color: Colors.purple[800],
                      child: Text(
                        'Done',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                      },
                    ),
                    SizedBox(height: 12.0),

                  ],
                ))
      ),
    );
  }
}
// Container(
//   child: FlatButton(
//       child: Text('Done'),
//       onPressed: () {
//         Navigator.pop(context);
//       }),
// );
