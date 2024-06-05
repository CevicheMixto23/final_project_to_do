import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_to_do/models/task_model.dart';
import 'package:final_project_to_do/models/user_model.dart';

//Instancia de la base de datos
FirebaseFirestore db = FirebaseFirestore.instance;
//Obtener las tareas
Future<List<Task>> getTasks(String idUser) async {
  List<Task> tasks = [];
  CollectionReference tasksCollection = db.collection('tasks');
  QuerySnapshot queryTask = await tasksCollection
      .where('isDone', isEqualTo: false)
      .where('idUser', isEqualTo: idUser)
      .get();

  // ignore: avoid_function_literals_in_foreach_calls
  queryTask.docs.forEach((doc) {
    Task task =
        Task(doc['name'], doc['isDone'], doc['deadline'], idUser, doc.id);
    tasks.add(task);
  });

  return tasks;
}

//Obtener las tareas completadas
Future<List<Task>> getTasksDone(String idUser) async {
  List<Task> tasks = [];
  CollectionReference tasksCollection = db.collection('tasks');
  QuerySnapshot queryTask = await tasksCollection
      .where('isDone', isEqualTo: true)
      .where('idUser', isEqualTo: idUser)
      .get();

  // ignore: avoid_function_literals_in_foreach_calls
  queryTask.docs.forEach((doc) {
    Task task =
        Task(doc['name'], doc['isDone'], doc['deadline'], idUser, doc.id);
    tasks.add(task);
  });

  return tasks;
}

//Agregar una tarea
Future<void> addTask(Task task) async {
  await db.collection('tasks').add(task.toJson());
}

//Editar el estado de una tarea
Future<void> changeTaskStatus(String uid, Task task) async {
  await db.collection('tasks').doc(uid).update({'isDone': !task.doneTask});
}

//Eliminar una tarea
Future<void> deleteTask(String uid) async {
  await db.collection('tasks').doc(uid).delete();
}

//Agregar Usuario
Future<bool> addUser(User user) async {
  CollectionReference usersCollection = db.collection('users');
  QuerySnapshot querySnapshot =
      await usersCollection.where('correo', isEqualTo: user.correo).get();
  if (querySnapshot.docs.isEmpty) {
    await db.collection('users').add(user.toJson());
    return true;
  } else {
    return false;
  }
}

Future<String> loginUser(User user) async {
  CollectionReference usersCollection = db.collection('users');
  QuerySnapshot querySnapshot =
      await usersCollection.where('correo', isEqualTo: user.correo).get();
  if (querySnapshot.docs.isEmpty) {
    return '';
  } else {
    DocumentSnapshot doc = querySnapshot.docs.first;
    if (doc['contrasena'] != user.contrasena) {
      return '';
    } else {
      return doc.id;
    }
  }
}
