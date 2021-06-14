import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_app/models/task.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference taskCollection =
      FirebaseFirestore.instance.collection('tasks');


  // to create and update task data
  Future createUserData(String name, String time, bool checked, String tuid) async {
    return await taskCollection.doc(tuid).set({
      'name': name,
      'time':time,
      'checked': checked,
      'puid':uid,
      'tuid':tuid
    });
  }

  // to delete task data
  Future deleteUserData(String name, String tuid) async {
    return await taskCollection.doc(tuid).delete();
  }


  // converts querysnapshots from firebase to our own models sturcture
  List<Task> _taskListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc1) {
      return Task(
          name: doc1.data()['name'] ?? '',
          time: doc1.data()['time'] ?? '',
          checked: doc1.data()['checked'] ?? false,
          puid: doc1.data()['puid'] ?? '',
          tuid: doc1.data()['tuid'] ?? '',
          );
    }).toList();
  }

  // get the query snapshots and return the converted from the above function
  Stream<List<Task>> get tasks {
    return taskCollection.snapshots().map(_taskListFromSnapshot);
  }
}
