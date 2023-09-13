import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_provider/task_add_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'main.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key});
  List? editedTaskList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text('Add Task'),
      ),
      body: SingleChildScrollView(child: taskForm()),
    );
  }

  Widget taskForm() {
    return Form(child: Consumer<TaskProvider>(builder: (_, taskProvider, __) {
      final ValueNotifier<String> _taskName =
          ValueNotifier<String>(taskProvider.taskController.text);
      final ValueNotifier<String> _taskDesc =
          ValueNotifier<String>(taskProvider.descController.text);
      return ValueListenableBuilder(
          valueListenable: _taskName,
          builder: (context, taskName, widget) {
            return ValueListenableBuilder(
                valueListenable: _taskDesc,
                builder: (context, taskDesc, widget) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 66, vertical: 86),
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.center,
                            controller: taskProvider.taskController,
                            decoration: InputDecoration(
                              labelText: 'Task',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(450.0),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 66, vertical: 1),
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.center,
                            controller: taskProvider.descController,
                            decoration: InputDecoration(
                                labelText: 'Description',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(450.0),
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              var name = await box
                                  .add(taskProvider.taskController.text);
                              editedTaskList =
                                  box.values.map((e) => e).toList();
                              print('edited task list print: $editedTaskList');
                              taskProvider.addTask(
                                  editedTaskList ?? ["Task 1", "Task 2"]);
                              taskProvider.descController.clear();
                              taskProvider.taskController.clear();
                              Navigator.pop(context);
                            },
                            child: const Text('Add Task'))
                      ]);
                });
          });
    }));
  }
}
