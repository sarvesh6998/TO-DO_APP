import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'task.dart';

class TaskProvider extends ChangeNotifier {
  TaskProvider() {
    _loadTask();
  }

  List<Task> _taskList = [];
  Box<Task> _taskBox = Hive.box('taskk');

  List<Task> get taskList => _taskList;
  _loadTask() {
    _taskList = _taskBox.values.toList();
    notifyListeners();
  }

  addTask(Task task) {
    _taskBox.add(task);
    _loadTask();
  }

  Future<void> deleteTask(int index) async {
    _taskBox.deleteAt(index);
    _loadTask();
  }

  Future<void> updateTask(Task task) async {
    task.save();

    _loadTask();
  }

  priorityTask() {}
}
