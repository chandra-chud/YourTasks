import 'package:brew_crew/models/brew.dart';

class User {
  final String uid;
  final List<Brew> brewsArray;

  User({this.uid, this.brewsArray});
}