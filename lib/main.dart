import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_provider/task_add_provider.dart';
import 'package:task_provider/task_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

final String taskDB = 'taskDB';
late final box;
void main() async {
  await Hive.initFlutter();
  box = await Hive.openBox(taskDB);
  print("initial box :${box.values}");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var initialTaskList;
  @override
  void initState() {
    super.initState();
    // final taskBox = Hive.box(taskDB);
    initialTaskList = box.values.map((e) => e).toList();
    print('init called$initialTaskList');
    // box.clear();
    // print('Erase list called$initialTaskList');
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
