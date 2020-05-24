import 'package:task_app/screens/authenticate/authenticate.dart';
import 'package:task_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);    

    print(user);

    if(user == null){
      return Authenticate();    
    } else {
      return Home();
    }
    //return either home or authenticate
  }
}