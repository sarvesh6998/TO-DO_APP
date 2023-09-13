import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_provider/add_task_screen.dart';
import 'package:task_provider/task_add_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TaskScreen extends StatelessWidget {
  var initialTaskList;
  TaskScreen({super.key, required this.initialTaskList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Task'),
        ),
        body: Consumer<TaskProvider>(
            builder: (_, taskProvider, __) => Column(
                  children: [
                    const Text('Task 1', style: TextStyle(fontSize: 30)),
                    Expanded(
                        child: ListView.separated(
                            itemCount: taskProvider.taskList == null
                                ? initialTaskList.length
                                : taskProvider.taskList.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 12,
                                ),
                            itemBuilder: (context, index) {
                              return ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                tileColor: Colors.blueGrey,
                                title: Text(
                                  taskProvider.taskList == null
                                      ? initialTaskList[index]
                                      : taskProvider.taskList[index] ??
                                          "value not added",
                                  style: const TextStyle(fontSize: 30),
                                ),
                              );
                            })),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddTaskScreen()));
                        },
                        child: const Text('Add Task'))
                  ],
                )));
  }
}
