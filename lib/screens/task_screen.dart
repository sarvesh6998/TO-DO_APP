import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'add_task_screen.dart';
import 'package:task_provider/task_add_provider.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
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
        title: Text('Tasks',
            style: GoogleFonts.montserrat(
                fontStyle: FontStyle.normal, fontSize: 25.0)),
      ),
      body: Card(
          elevation: 0,
          color: Colors.orange.shade100,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: taskProvider.taskList.length,
              itemBuilder: (context, index) {
                final task = taskProvider.taskList[index];
                return ListTile(
                  title: Text(task.taskName),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddTaskScreen(
                                          isUpdate: true,
                                          task: task,
                                        )));
                          },
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () => taskProvider.deleteTask(index),
                          icon: const Icon(Icons.delete))
                    ],
                  ),
                );
              })),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
            style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(150.00)),
                fixedSize: Size(MediaQuery.of(context).size.width, 50.0),
                backgroundColor: const Color.fromARGB(255, 228, 154, 41)),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddTaskScreen()));
            },
            child: const Text(
              'Add Task',
              style: TextStyle(color: Colors.black),
            )),
      ),
    );
  }
}
