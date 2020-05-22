import 'package:flutter/material.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/screens/home/brew_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brew_crew/models/user.dart';
// import 'package:brew_crew/shared/taskID.dart';

class BrewList extends StatefulWidget {
  //BrewList();
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context){
    final brews = Provider.of<List<Brew>>(context);
    //final user = Provider.of<User>(context);


    // User _userFromFirebaseUser(FirebaseUser user) {
    //   return user != null ? User(uid: user.uid): null;
    // }
    
    //String userid;
    // Future<String> getUser() async {
    //   final user = await FirebaseAuth.instance.currentUser();
    //   userid =  _userFromFirebaseUser(user).uid;
    // }

    // getUser();
    // print(userid);
    //fruits.where((f) => f.startsWith('a')).toList();
    //print(user.uid);    
    return Row(
      children: <Widget>[
        Expanded(
              child: ListView(
                children: brews.map((brew) => BrewTile(brew: brew)).toList()
          ),
        ),  
        ],
        
    );

  }
}

              // floatingActionButton: FloatingActionButton.extended(
              //     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              //     onPressed: () { },
              //     tooltip: 'Increment',
              //     child: Icon(Icons.add),
              //     elevation: 2.0,
              // ),            
