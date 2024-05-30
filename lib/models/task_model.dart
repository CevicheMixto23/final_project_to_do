

import 'package:intl/intl.dart';

class Task { 
  String nameTask;
  bool doneTask;
  String deadlineTask;

  Task(this.nameTask,this.doneTask,this.deadlineTask);

  DateTime strToDateTime(String str){   
    return DateTime.parse(str);
  }

  String dateTimeToStr(DateTime dateTime){
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

}