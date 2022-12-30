

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_1_todo_app/screen/details/widget/done_list.dart';
import 'package:project_1_todo_app/screen/details/widget/notDonelist.dart';
import 'package:project_1_todo_app/widgets/icons.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../Models/TaskType/TaskType.dart';
import '../home/controller.dart';

class Details extends StatelessWidget {
 Details({Key? key, required this.data}) : super(key: key);
 final homecontroller =Get.find<HomeController>();
 final todocontroller = TextEditingController();
 var icons = getIcons();
 final TaskType  data;

  @override
  Widget build(BuildContext context) {

    return WillPopScope(onWillPop: ()async =>false,
    child: Scaffold(
       body: ListView(
         children: [
           Padding(
             padding: EdgeInsets.all(8.0),
             child: Row(
               children: [
                 IconButton(
                   onPressed: () {
                     Get.back();
                   },
                   icon: Icon(
                     Icons.arrow_back,
                   ),
                 ),
               ],
             ),
           ),


           Padding(
             padding: EdgeInsets.symmetric(
               horizontal: 20.0,
             ),
             child: Row(
               children: [
                 icons[data.icon],
                 SizedBox(
                   width: 10.0,
                 ),
                 Text(
                   data.title,
                   style: TextStyle(
                     color: Colors.blueGrey,
                     fontSize: 20.0,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
               ],
             ),
           ),
          GetX<HomeController>(builder: (controller){
            var totalTodos = controller.donetask.length + controller.notdonetask.length ;
            return Padding(
              padding: EdgeInsets.only(
                left: 25.0,
                top: 8.0,
                right: 25.0,
              ),
              child: Row(
                children: [
                  Text(
                    "$totalTodos Tasks",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                      child: StepProgressIndicator(
                        totalSteps: totalTodos == 0 ? 1 : totalTodos,
                        currentStep: controller.donetask.length,
                        size: 5.0,
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
                      )),



                ],
              ),
            );
          }),


           Padding(
             padding: EdgeInsets.symmetric(
               vertical: 2.0,
               horizontal: 5.0,
             ),
             child: Padding(
               padding:  EdgeInsets.symmetric(horizontal: 18.0),
               child: TextField(
                 controller: todocontroller,
                 autofocus: true,
                 decoration: InputDecoration(
                   focusedBorder: UnderlineInputBorder(
                     borderSide: BorderSide(color: Colors.grey[400]!),
                   ),
                   prefixIcon: Icon(
                     Icons.check_box_outline_blank,
                     color: Colors.grey[400],
                   ),
                   suffixIcon: IconButton(
                     onPressed: () {
                       var todo = todocontroller.text.trim();
                       if(todo.isNotEmpty){
                      var status =    homecontroller.addtodoDirect(todo,data);
                        if(!status){
                        EasyLoading.showError("Duplicated Task");
                        }

                       }else {
                         EasyLoading.showInfo("Please Enter task name");
                       }
                        todocontroller.clear();
                     },
                     icon: Icon(Icons.done),
                   ),
                 ),

               ),
             ),
           ),
           DoingList(data: data),
           DoneList(data: data,),

         ],
       ),
    ),
    );
  }
}
