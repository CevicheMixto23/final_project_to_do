
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_to_do/models/task_model.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List<Task>> getTasks() async {
  List<Task> tasks = [];
  CollectionReference tasksCollection = db.collection('tasks');
  QuerySnapshot queryTask = await tasksCollection.where('isDone',isEqualTo: false).get();

  queryTask.docs.forEach((doc) {
    Task task = Task(
      doc['name'],
      doc['isDone'],
      doc['deadline'],
    );
    tasks.add(task);
  });

  return tasks;
}

Future<List<Task>> getTasksDone() async {
  List<Task> tasks = [];
  CollectionReference tasksCollection = db.collection('tasks');
  QuerySnapshot queryTask = await tasksCollection.where('isDone',isEqualTo: true).get();
  
  queryTask.docs.forEach((doc) {
    Task task = Task(
      doc['name'],
      doc['isDone'],
      doc['deadline'],
    );
    tasks.add(task);
  });

  return tasks;
}