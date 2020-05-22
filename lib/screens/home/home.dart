import 'package:brew_crew/services/auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/screens/home/brew_list.dart';


class Home extends StatelessWidget {

  final AuthService _auth = AuthService();
  
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>>.value(
        value: DatabaseService().brews,
        child: Scaffold(
        backgroundColor: Colors.purple[50],
        appBar: AppBar(
          title:Text('Brew Crew'),
          backgroundColor: Colors.purple[500],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
              },
              )
          ],
        ),
        body: BrewList(),
        floatingActionButton: new FloatingActionButton(
           child: const Icon(Icons.add),
           backgroundColor: Colors.purple[500],
        ),
      ),
    );
  }
}