import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/TaskType/TaskType.dart';
import '../../db/Box_db.dart';

class HomeController extends GetxController {
  final Box _observableBox = BoxRepository.getBox();
  Box get observableBox => _observableBox;
  int get tasktypeCount => _observableBox.length;
  static final tabIndex = 0.obs;
  static final chipIndex = 0.obs;
  var tasktype = <dynamic>[].obs;
  final donetask = <dynamic>[].obs;
  final notdonetask = <dynamic>[].obs;

  final keyOne = GlobalKey();

  final keyTwo = GlobalKey();

  final keyThree = GlobalKey();

  final keyFour = GlobalKey();


@override
  void onInit(){

    // TODO: implement onInit
  getitem();
    super.onInit();

  }


  @override
  void onClose() {
    SaveData();
    super.onClose();
  }

  // hive add tasktype
  bool createTaskType(TaskType data){
  for(int i =0 ; i < tasktype.length ; i++){
    if(tasktype[i].title == data.title){
      return false;
    }
  }
  _observableBox.add(data);
  update();
  getitem();
  return true;

  }

  void getitem() {
  tasktype.clear();
     List.generate(_observableBox.length, (index){
       tasktype.add(_observableBox.getAt(index));
     });
     tasktype.refresh();
     update();
  }

  void typeselect(int index) {
   for(int i =0 ; i < tasktype.length; i++){
     if(i == index){
       tasktype[i].select = true;
     }else {
       tasktype[i].select = false;
     }
   }
    tasktype.refresh();
    update();
  }

  void clearselect(){
       for(int i = 0 ; i < tasktype.length ; i++){
         tasktype[i].select = false;
       }
       tasktype.refresh();

  }

// hive add task
 bool addtodo(String todoname, int index)  {
  for(int i = 0 ; i < tasktype.length ; i++){
    if(i == index){
      for(int j =0 ;j < tasktype[i].todo.length ; j++){
        if(tasktype[i].todo[j]["todoname"] == todoname){
          tasktype[i].select = false;
          return false;
        }
      }
      tasktype[i].todo.add({"todoname": todoname, "isDone": false});
      tasktype[i].select = false;
      tasktype[i].notdonetask ++;

    }

  }
SaveData();
tasktype.refresh();
    update();
  return true;
  }

  Future<void> SaveData() async {
  for(int i = 0 ; i < tasktype.length ; i ++){
  await  _observableBox.putAt(i, tasktype[i]);
  }
 getitem();
  }



  void listTask(TaskType data) {
    data.notdonetask = 0;
    data.isdonetask = 0;
    notdonetask.value.clear();
    donetask.value.clear();
    for (int i = 0; i < data.todo.length; i++) {
      if (data.todo[i]["isDone"] == false) {
        data.notdonetask++;
        notdonetask.add(data.todo[i]);
      } else {
        data.isdonetask ++;
        donetask.add(data.todo[i]);
      }
    }
    donetask.refresh();
    notdonetask.refresh();
  }


  void clicktaskDone(bool value, TaskType data, String title) {
    var doingTodo = {"todoname": title, "isDone": false};
    int index = data.todo.indexWhere(
        (element) => mapEquals<String, dynamic>(doingTodo, element));
    data.todo[index]["isDone"] = value;
   SaveData();
    listTask(data);
   tasktype.refresh();

  }

  void deletetodo(TaskType data,String title) {
    var doneTodo = {"todoname": title, "isDone": true};
    int index = data.todo.indexWhere(
            (element) => mapEquals<String, dynamic>(doneTodo, element));
    data.todo.removeAt(index);
    listTask(data);
    SaveData();
    tasktype.refresh();


  }

  void addtype(TaskType type)  {
  tasktype.add(type);

  }





  bool addtodoDirect(String todoname,TaskType data) {
  for(int i =0 ; i < data.todo.length; i ++){
    if(data.todo[i]["todoname"] == todoname){
      return false;
    }
  }

   data.todo.add({"todoname": todoname, "isDone": false});
    data.notdonetask++;
    SaveData();

    listTask(data);
    donetask.refresh();
    notdonetask.refresh();
    return true;
  }

  static void changeTabIndex(int value) {
    tabIndex.value = value;
  }

  int? getTotaltask (){
    int? res = 0;
    for(int i = 0 ; i < tasktype.length ; i ++){
      res = (res! + tasktype[i].todo.length) as int? ;
    }
    return res;
  }

  int getTotalDonetask (){
    var res = 0 ;
    for(int i =0 ; i < tasktype.length ; i ++){
      for(int j = 0 ; j<tasktype[i].todo.length ; j ++){
        if(tasktype[i].todo[j]["isDone"] == true){
          res++;
        }
      }
    }
    return res;
  }

  Future<bool> DeleteTaskType(TaskType data,int index) async {
 var isDelete = tasktype.remove(data);
  _observableBox.deleteAt(index);
  SaveData();
  tasktype.refresh();
  update();
 return isDelete;
  }


}
