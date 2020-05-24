import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/models/brew.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');

  Future createUserData(String name, String time, bool checked, String tuid) async {
    return await brewCollection.document(tuid).setData({
      'name': name,
      'time':time,
      'checked': checked,
      'puid':uid,
      'tuid':tuid
    });
  }

  Future deleteUserData(String name, String tuid) async {
    return await brewCollection.document(tuid).delete();
  }


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
}
