

import 'dart:convert';

import 'package:intl/intl.dart';

String taskToJson(Task data) => json.encode(data.toJson());

class Task {
  String nameTask;
  bool doneTask;
  String deadlineTask;
  String idUser;
  String? uid;
  Task(this.nameTask, this.doneTask, this.deadlineTask, this.idUser,
      [this.uid]);

  DateTime strToDateTime(String str) {
    return DateTime.parse(str);
  }

  String dateTimeToStr(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  Map<String, dynamic> toJson() => {
        "name": nameTask,
        "isDone": doneTask,
        "deadline": deadlineTask,
        "idUser": idUser
      };
}