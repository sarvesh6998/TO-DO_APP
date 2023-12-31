import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_provider/task_provider.dart';
import 'package:task_provider/screens/task_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'task.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  final box = await Hive.openBox<Task>('taskk');

  box.clear();
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
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TaskScreen(),
      ),
    );
  }
}
