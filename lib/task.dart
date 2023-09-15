import 'package:hive_flutter/hive_flutter.dart';
part 'task.g.dart';

@HiveType(typeId: 1)
class Task  {
  @HiveField(0)
  String? taskName;
  @HiveField(1)
  String? taskDesc;
  Task({this.taskName, this.taskDesc});

  Map toJson() => {"taskName": taskName, "taskDesc": taskDesc};
}
