


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:project_1_todo_app/Models/TaskType/TaskType.dart';

import '../../home/controller.dart';

class DoneList extends StatelessWidget {
  final homeCntrl = Get.put(HomeController());
  DoneList({super.key, required this.data});
  final TaskType data;

  @override
  Widget build(BuildContext context) {
    return GetX<HomeController>(builder: (controller){
      return  Visibility(
          visible: controller.donetask.isNotEmpty,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 18.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                Text("Completed(${controller.donetask.length})",style: TextStyle(color: Colors.grey,fontSize: 20),),
                ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: controller.donetask.length,
                    itemBuilder: (context, int index) {
                      return ListTile(
                        leading: Icon(Icons.done,color: Colors.blue,),
                        title: Text(
                          controller.donetask[index]["todoname"],
                          style: TextStyle(fontSize: 20,decoration: TextDecoration.lineThrough),
                        ),
                        trailing: IconButton(onPressed: (){
                          var title = controller.donetask[index]["todoname"];
                          controller.deletetodo(data, title);
                        },icon: Icon(Icons.delete,color: Colors.grey,),),
                      );
                    }),
              ],
            ),
          )
      );
    });
  }
}