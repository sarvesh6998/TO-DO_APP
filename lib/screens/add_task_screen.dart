import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task_provider/task_provider.dart';

import '../task.dart';

class AddTaskScreen extends StatefulWidget {
  final Task? task;
  bool isUpdate;
  AddTaskScreen({super.key, this.task, this.isUpdate = false});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

enum PriorityClass { High, Low }

class _AddTaskScreenState extends State<AddTaskScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController taskController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  void initState() {
    taskController.text = widget.task?.taskName ?? "";
    descController.text = widget.task?.taskDesc ?? "";
  }

  PriorityClass? _character = PriorityClass.Low;

  Box<Task> _taskBox = Hive.box('taskk');
  // late bool isUpdate = widget.task != null;

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
          title: Text(widget.isUpdate ? 'Update Task' : 'Add Task',
              style: GoogleFonts.montserrat(
                  fontStyle: FontStyle.normal, fontSize: 25.0)),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 60),
          child: Form(
              key: formKey,
              child: Consumer<TaskProvider>(builder: (_, taskProvider, __) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 66, vertical: 10),
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
                            horizontal: 66, vertical: 10),
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
                        height: 8,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Row(
                          children: [
                            Flexible(
                              child: RadioListTile(
                                dense: true,
                                activeColor:
                                    const Color.fromARGB(255, 228, 154, 41),
                                title: const Text('High'),
                                value: PriorityClass.High,
                                groupValue: _character,
                                onChanged: (PriorityClass? value) {
                                  setState(() {
                                    _character = value;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              child: RadioListTile(
                                dense: true,
                                activeColor:
                                    const Color.fromARGB(255, 228, 154, 41),
                                title: const Text('Low'),
                                value: PriorityClass.Low,
                                groupValue: _character,
                                onChanged: (PriorityClass? value) {
                                  setState(() {
                                    _character = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 66, vertical: 50),
                      child: ElevatedButton(
                          style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(450.00)),
                              fixedSize:
                                  Size(MediaQuery.of(context).size.width, 50.0),
                              backgroundColor:
                                  const Color.fromARGB(255, 228, 154, 41)),
                          onPressed: () {
                            if (formKey.currentState?.validate() == true) {
                              if (widget.isUpdate == true) {
                                widget.task?.taskName = taskController.text;
                                widget.task?.taskDesc = descController.text;
                                widget.task?.priority =
                                    _character == PriorityClass.High
                                        ? true
                                        : false;

                                taskProvider.updateTask(widget.task!);
                              } else {
                                taskProvider.addTask(Task(
                                  taskName: taskController.text,
                                  taskDesc: descController.text,
                                  priority: _character == PriorityClass.High
                                      ? true
                                      : false,
                                ));
                              }
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Add Task Button')),
                    )
                  ],
                );
              })),
        ),
      ),
    );
  }
}
