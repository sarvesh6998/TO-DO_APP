import 'package:flutter/material.dart';
import 'task.dart';
import 'main.dart';

class TaskProvider extends ChangeNotifier {
  TaskProvider();
  TextEditingController taskController = TextEditingController();
  TextEditingController descController = TextEditingController();
  List<Task> _taskList = [];

  List<Task> get taskList => _taskList;

  addTask() {
    initialTaskList.add(taskController.text);
    notifyListeners();
    updatedTask();
  }

  var newTaskList;

  updatedTask() async {
    await box.add(taskController.text);
  }
}
