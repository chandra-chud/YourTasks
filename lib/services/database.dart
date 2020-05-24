import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/models/task.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference taskCollection =
      Firestore.instance.collection('tasks');

  Future createUserData(String name, String time, bool checked, String tuid) async {
    return await taskCollection.document(tuid).setData({
      'name': name,
      'time':time,
      'checked': checked,
      'puid':uid,
      'tuid':tuid
    });
  }

  Future deleteUserData(String name, String tuid) async {
    return await taskCollection.document(tuid).delete();
  }


  List<Task> _taskListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Task(
          name: doc.data['name'] ?? '',
          time: doc.data['time'] ?? '',
          checked: doc.data['checked'] ?? false,
          puid: doc.data['puid'] ?? '',
          tuid: doc.data['tuid'] ?? '',
          );
    }).toList();
  }

  Stream<List<Task>> get tasks {
    return taskCollection.snapshots().map(_taskListFromSnapshot);
  }
}
