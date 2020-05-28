import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_app/models/task.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference taskCollection =
      Firestore.instance.collection('tasks');


  // to create and update task data
  Future createUserData(String name, String time, bool checked, String tuid) async {
    return await taskCollection.document(tuid).setData({
      'name': name,
      'time':time,
      'checked': checked,
      'puid':uid,
      'tuid':tuid
    });
  }

  // to delete task data
  Future deleteUserData(String name, String tuid) async {
    return await taskCollection.document(tuid).delete();
  }


  // converts querysnapshots from firebase to our own models sturcture
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

  // get the query snapshots and return the converted from the above function
  Stream<List<Task>> get tasks {
    return taskCollection.snapshots().map(_taskListFromSnapshot);
  }
}
