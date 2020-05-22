import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');

  // Future updateUserData(TimeOfDay time, String name, bool checked) async {
  //   return await brewCollection
  //       .document(uid)
  //       .setData({'time': time, 'checked': checked, 'name': name, 'puid': uid});
  // }


  Future createUserData(String name, bool checked, String tuid) async {
    //print('called');
    return await brewCollection.add({
      'name': name,
      'checked': checked,
      'puid':uid,
      'tuid':tuid
    });
  }

  // Future getUserData(TimeOfDay time, String name, bool checked) async {
  //   return await brewCollection.document(uid).setData({
  //     'time': time,
  //     'checked': checked,
  //     'name': name,
  //     // 'index': index,
  //     'puid':uid
  //   });
  // }

  // Future createNewTask(TimeOfDay time, String name, bool checked) async {
  //   return await brewCollection.document(uid).setData({
  //     'time': time,
  //     'checked': checked,
  //     'name': name,
  //     'puid':uid
  //   });
  // }
  //brew list from snapshots

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Brew(
          name: doc.data['name'] ?? '',
          checked: doc.data['checked'] ?? false);
    }).toList();
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }
}
