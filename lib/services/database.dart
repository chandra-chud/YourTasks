import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/models/brew.dart';
//import 'package:flutter/material.dart';

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


  Future createUserData(String name, String time, bool checked, String tuid) async {
    print('edited');
    print(name);

    print(time);

    return await brewCollection.document(tuid).setData({
      'name': name,
      'time':time,
      'checked': checked,
      'puid':uid,
      'tuid':tuid
    });
  }

  Future deleteUserData(String name, String tuid) async {
    print('deleted');
    print(name);

    return await brewCollection.document(tuid).delete();
  }




  // Future getTask(String name, String tuid) async {
  //   return await brewCollection
  //   .snapshots();
  // }

  // Future getTask(String name, widget.checked,String tuid) async {
  //   QuerySnapshot qShot = await brewCollection.getDocuments();

  //   dynamic myList = qShot.documents.map((doc) => Brew(
  //     name: doc.data['name'],
  //     puid: doc.data['puid'],
  //     tuid: doc.data['tuid'],
  //   )).toList();

  //   myList[0].name = name;
  //   // return await brewCollection
  //   //     .document();
  // }

  // List<Brew> brewElementFromSnapshots(QuerySnapshot snapshot){
  //   return snapshot.documents.map((doc) {
  //     return Brew(
  //         name: doc.data['name'] ?? '',
  //         checked: doc.data['checked'] ?? false,
  //         puid: doc.data['puid'] ?? false,
  //         tuid: doc.data['tuid'] ?? false,
  //         );
  //   });
  // }

  // Stream<List<Brew>> get currentTask {
  //   return brewCollection
  //   .where('tuid', isEqualTo: tuid)
  //   .snapshots().map(brewElementFromSnapshots);
  // } 


  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Brew(
          name: doc.data['name'] ?? '',
          time: doc.data['time'] ?? '',
          checked: doc.data['checked'] ?? false,
          puid: doc.data['puid'] ?? '',
          tuid: doc.data['tuid'] ?? '',
          );
    }).toList();
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
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

}
