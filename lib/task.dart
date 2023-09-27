import 'package:hive_flutter/hive_flutter.dart';
part 'task.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String taskName;
  @HiveField(2)
  String? taskDesc;
  Task({this.id, required this.taskName, this.taskDesc});

  Map toJson() => {id: id, "taskName": taskName, "taskDesc": taskDesc};
}
