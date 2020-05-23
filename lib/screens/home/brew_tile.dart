import 'package:flutter/material.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/task/taskPage.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/models/user.dart';
import 'package:provider/provider.dart';

class BrewTile extends StatelessWidget {
  final Brew brew;
  BrewTile({this.brew});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            leading: Checkbox(
              value: brew.checked,
              activeColor: Colors.purple,
              onChanged: (bool newVal) {
                DatabaseService(uid: user.uid)
                    .createUserData(brew.name, newVal, brew.tuid);
              },
            ),
            title: Text(brew.name,
                style: (brew.checked
                    ? TextStyle(decoration: TextDecoration.lineThrough)
                    : TextStyle(fontWeight: FontWeight.bold))),
            subtitle: Text('Time:'),
            trailing: ((brew.checked == true)
                ? FlatButton.icon(
                    icon: Icon(Icons.delete),
                    label: Text('Delete'),
                    onPressed: () {
                      DatabaseService()
                          .deleteUserData(brew.name, brew.tuid);
                    },
                  )
                : FlatButton(
                    child: Icon(Icons.mode_edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TaskPage(
                                brew.name, brew.checked, brew.puid, brew.tuid)),
                      );
                    },
                  )),
          )),
    );
  }
}

// return Padding(
//   padding: EdgeInsets.only(top: 8.0),
//   child: Card(
//       margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
//       child: ListTile(
//           leading: Checkbox(
//             value: brew.checked,
//             checkColor: Colors.white,
//             onChanged: (bool newVal) {
//               setState(() {
//                 brew.checked = newVal;
//               });
//             },
//           ),
//           title: Text(brew.name,
//               style: (brew.checked
//                   ? TextStyle(decoration: TextDecoration.lineThrough)
//                   : TextStyle(fontWeight: FontWeight.bold))),
//           subtitle: Text('Scheduled time:'),
//           trailing: ((brew.checked == true) ? FlatButton():FlatButton(
//             child: Icon(Icons.mode_edit),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => TaskPage(
//                   brew.name, brew.checked,brew.puid, brew.tuid
//                 )),
//               );
//             },
//           )))),
// );
