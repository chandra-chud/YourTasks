import 'package:flutter/material.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/task/taskPage.dart';

class BrewTile extends StatelessWidget {
  final Brew brew;
  BrewTile({this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
              leading: Checkbox(
                value: brew.checked, 
                checkColor: Colors.white,
                // onChanged: {
                  
                // },
              ),
              title: Text(brew.name,
                  style: (brew.checked
                      ? TextStyle(decoration: TextDecoration.lineThrough)
                      : TextStyle(fontWeight: FontWeight.bold))),
              subtitle: Text('Scheduled time:'),
              trailing: FlatButton(
                child: Icon(Icons.mode_edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TaskPage()),
                  );
                },
              ))),
    );
  }
}
