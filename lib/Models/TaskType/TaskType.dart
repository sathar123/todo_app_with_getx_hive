

import 'package:hive_flutter/hive_flutter.dart';
part 'TaskType.g.dart';


@HiveType(typeId: 1)
class TaskType {
@HiveField(0)
String title;
@HiveField(1)
int icon;
@HiveField(2)
int isdonetask;
@HiveField(3)
int notdonetask;
@HiveField(4)
bool select;
@HiveField(5)
 List<Map<String,dynamic>>  todo = [];
@HiveField(6)
String? id;

TaskType({required this.title,required this.icon,this.select = false,this.isdonetask = 0,this.notdonetask =0}) {
  id = DateTime.now().microsecondsSinceEpoch.toString();

}


}