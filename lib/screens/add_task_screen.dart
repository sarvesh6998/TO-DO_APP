import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task_provider/task_add_provider.dart';

import '../task.dart';

class AddTaskScreen extends StatefulWidget {
  final Task? task;
  bool isUpdate;
  AddTaskScreen({super.key, this.task, this.isUpdate = false});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  Box<Task> _taskBox = Hive.box('taskk');
  // late bool isUpdate = widget.task != null;

  final formKey = GlobalKey<FormState>();
  TextEditingController taskController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 228, 154, 41),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text('Add Task',
              style: GoogleFonts.montserrat(
                  fontStyle: FontStyle.normal, fontSize: 25.0)),
        ),
        body: SingleChildScrollView(
          child: Form(
              key: formKey,
              child: Consumer<TaskProvider>(builder: (_, taskProvider, __) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 66, vertical: 86),
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.center,
                          controller: taskController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some task';
                            }
                            return null;
                          },
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some task descrption';
                            }
                            return null;
                          },
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.center,
                          controller: descController,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 66, vertical: 86),
                        child: ElevatedButton(
                            style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(450.00)),
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width, 50.0),
                                backgroundColor:
                                    const Color.fromARGB(255, 228, 154, 41)),
                            onPressed: () {
                              if (formKey.currentState?.validate() == true) {
                                if (widget.isUpdate == true) {
                                  widget.task?.taskName = taskController.text;
                                  widget.task?.taskDesc = descController.text;

                                  taskProvider.updateTask(widget.task!);
                                } else {
                                  taskProvider.addTask(Task(
                                      taskName: taskController.text,
                                      taskDesc: descController.text));
                                }
                                Navigator.pop(context);
                              }
                            },
                            child: const Text('Add Task Button')),
                      )
                    ]);
              })),
        ),
      ),
    );
  }
}
