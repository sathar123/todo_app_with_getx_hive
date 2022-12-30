

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_1_todo_app/Models/TaskType/TaskType.dart';
import 'package:project_1_todo_app/main.dart';
import 'package:project_1_todo_app/provider/theme_notifier.dart';
import 'package:project_1_todo_app/themes/themes.dart';
import 'package:project_1_todo_app/widgets/icons.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../details/DetailScreen.dart';
import '../controller.dart';


class TaskCard extends StatelessWidget {
   TaskCard({required TaskType this.data, this.index} );
   final homect = Get.put(HomeController());
final icons = getIcons();
var  data;
final index;

  @override
  Widget build(BuildContext context) {
   int total = data.isdonetask + data.notdonetask  ;
    return GestureDetector(
      onTap: (){
        homect.listTask(data);
        Get.to(()=>Details(data: data),);
      },
      onLongPress: (){
        Get.defaultDialog(
          radius: 10.0,
          contentPadding: const EdgeInsets.all(20.0),
          title: "Do You Want To Delete Item?",
          titleStyle: TextStyle(color: Colors.white),
          middleText: data.title,
          textConfirm: 'Ok',
          confirm: OutlinedButton.icon(
            onPressed: ()async {
             var status =await homect.DeleteTaskType(data,index);
              if(status){
                EasyLoading.showInfo('Deleted Success');
              }else{
                EasyLoading.showError('Deleted Not Success');
              }

              Get.back();
            },

            icon: const Icon(
              Icons.check,
              color: Colors.blue,     ),
            label: const Text('Ok',
              style: TextStyle(color: Colors.blue),
            ),   ),
          cancel: OutlinedButton.icon(
            onPressed: (){
              Get.back();
            },
            icon: Icon(Icons.cancel),
            label: Text("Cancel"),),);

      },
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: Get.width * 0.012),
            child: StepProgressIndicator(
      totalSteps: (total == 0)? 1 : total,
      currentStep: data.isdonetask,
      size: 5,
      padding: 0,
      selectedGradientColor: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.red.shade100,
          Colors.red,


        ],
      ),
      unselectedGradientColor: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white,
          Colors.white,
        ],
      ),
    ),
          ),
      Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: Get.height * 0.2,
        width: Get.width * 0.45,
      decoration: BoxDecoration(
      color: LigthColor().cardColor,
      borderRadius: BorderRadius.only(bottomRight: Radius.circular(100),bottomLeft: Radius.circular(20)),

      boxShadow: [
        context.watch<ThemeNotifier>().isLightTheme ?
       BoxShadow(
        offset: Offset(0, 5),
        color: Colors.black45,
        blurRadius: 5,
      ) : BoxShadow(
          offset: Offset(0, 5),
          color: Colors.black12,
          blurRadius: 5
        )
      ]
      ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              icons[data.icon],
              Text(data.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.blueGrey.shade900),),
              Text("${data.todo.length} Task",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.grey)),
              SizedBox(height: Get.height * 0.01,)
            ],
          ),
        ),
      )
        ],
      ),
    );
  }
}
