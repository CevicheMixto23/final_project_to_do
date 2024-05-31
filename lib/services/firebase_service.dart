
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_to_do/models/task_model.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List<Task>> getTasks() async {
  List<Task> tasks = [];
  CollectionReference tasksCollection = db.collection('tasks');
  QuerySnapshot queryTask = await tasksCollection.where('isDone',isEqualTo: false).get();

  // ignore: avoid_function_literals_in_foreach_calls
  queryTask.docs.forEach((doc) {
    Task task = Task(
      doc['name'],
      doc['isDone'],
      doc['deadline'],
      doc.id
    );
    tasks.add(task);
  });

  return tasks;
}

Future<List<Task>> getTasksDone() async {

  List<Task> tasks = [];
  CollectionReference tasksCollection = db.collection('tasks');
  QuerySnapshot queryTask = await tasksCollection.where('isDone',isEqualTo: true).get();
  
  // ignore: avoid_function_literals_in_foreach_calls
  queryTask.docs.forEach((doc) {
    Task task = Task(
      doc['name'],
      doc['isDone'],
      doc['deadline'],
      doc.id
    );
    tasks.add(task);
  });

  return tasks;
}

Future<void> addTask(Task task) async {
  await db.collection('tasks').add(task.toJson());
}

Future<void> changeTaskStatus(String uid,Task task) async {
  await db.collection('tasks').doc(uid).update({'isDone': !task.doneTask});
}
