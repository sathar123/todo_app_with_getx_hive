


import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_1_todo_app/Models/TaskType/TaskType.dart';

class BoxRepository {
  static const String boxName = "taskdb";

  static openBox() async => await Hive.openBox<TaskType>(boxName);

  static Box getBox() => Hive.box<TaskType>(boxName);

  static closeBox() async => await Hive.box(boxName).close();

}