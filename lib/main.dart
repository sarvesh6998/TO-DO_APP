import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_provider/task_add_provider.dart';
import 'package:task_provider/task_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'task.dart';

final String taskDB = 'taskDB';
late final Box box;
late List<String> initialTaskList;
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  box = await Hive.openBox('taskDatabase');

  print("initial box :${box.values}");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    initialTaskList = box.values.toList().cast<String>();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MaterialApp(
        home: TaskScreen(
          initialTaskList: initialTaskList,
        ),
      ),
    );
  }
}
