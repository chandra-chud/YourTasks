import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/shared/taskID.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brew_crew/models/user.dart';


class Home extends StatelessWidget {
  
  final AuthService _auth = AuthService();
//  final user = await FirebaseAuth.instance.currentUser();
    // User _userFromFirebaseUser(FirebaseUser user) {
    //   return user != null ? User(uid: user.uid): null;
    // }

    // Future<String> getUser() async {
    //   final user = await FirebaseAuth.instance.currentUser();
    //   String userid =  _userFromFirebaseUser(user).uid;
    //   return userid;
    // }



  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);    

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.purple[80],
        appBar: AppBar(
          title: Text('Your Tasks'),
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
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          backgroundColor: Colors.purple[500],
          onPressed: () async {
            // TimeOfDay currentTime = TimeOfDay.now();
            String randomString = Utils().createCrypto();

            // print(userid);
            await DatabaseService(uid: user.uid).createUserData(
                'new task', 
                false, 
                randomString
            );
          },
        ),
      ),
    );
  }
}
