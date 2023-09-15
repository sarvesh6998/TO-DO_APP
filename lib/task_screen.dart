import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_provider/add_task_screen.dart';
import 'package:task_provider/task.dart';
import 'package:task_provider/task_add_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'main.dart';

class TaskScreen extends StatelessWidget {
  List<String> initialTaskList;
  TaskScreen({super.key, required this.initialTaskList});

  @override
  Widget build(BuildContext context) {
    // final editedItem = box.get();

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
                            itemCount: initialTaskList.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 12,
                                ),
                            itemBuilder: (context, index) {
                              return ListTile(
                                trailing: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.edit),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(Icons.delete)
                                    ]),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                tileColor: Colors.blueGrey,
                                title: Text(
                                  initialTaskList[index] ?? "",
                                  style: const TextStyle(fontSize: 30),
                                ),
                              );
                            })),
                    ElevatedButton(
                        onPressed: () {
                          // print("*******************$editedItem");
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddTaskScreen()));
                        },
                        child: const Text('Add Task'))
                  ],
                )));
  }
}
