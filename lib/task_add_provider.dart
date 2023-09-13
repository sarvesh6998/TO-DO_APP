import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {
  TaskProvider.init() {}
  TaskProvider();
  TextEditingController taskController = TextEditingController();
  TextEditingController descController = TextEditingController();
  var _taskList;

  get taskList => _taskList;
  addTask(task) {
    // _taskList.add(task);
    _taskList = task;
    notifyListeners();
  }
}

// class Task {
//   String? taskName;
//   String? taskDesc;
//   Task({this.taskName, this.taskDesc});
// }
