


import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:project_1_todo_app/Models/TaskType/TaskType.dart';

import '../../../widgets/icons.dart';
import '../controller.dart';
import 'CustomShowCase.dart';

class AddTaskType extends StatelessWidget {
   AddTaskType({Key? key}) : super(key: key);
   final homect = Get.put(HomeController());
final titleController = TextEditingController();
  @override
  Widget build(BuildContext context)  {
    final icons = getIcons();
    return  GestureDetector(
      onTap: ()=> showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title:  Center(child: Text('Task Type',style: TextStyle(color: Colors.white),)),
            content: Container(
              height: Get.height * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: TextFormField(
                      controller: titleController,
                      style: TextStyle(

                          color: Colors.grey
                      ),
                      decoration: const InputDecoration(

                        border: OutlineInputBorder(),
                        labelText: "Title",
                      ),
                    ),
                  ),
                  Wrap(
                    spacing: 5.0,
                    children: icons.map((e) => Obx(() {
                      final index = icons.indexOf(e);
                      return ChoiceChip(

                        pressElevation: 0,

                        label: e,
                        selected: HomeController.chipIndex.value == index,
                        onSelected: (bool selected) {
                          HomeController.chipIndex.value =
                          selected ? index : 0;
                        },
                      );
                    })).toList(),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: Size(150, 40),
                    ),
                    onPressed: () {
                     final selecticon = HomeController.chipIndex.value ;
                     final title = titleController.text.trim();
                     if(title.isNotEmpty){
                      var status =  homect.createTaskType(TaskType(title: title, icon: selecticon,));
                      if(status){
                        EasyLoading.showSuccess("Create success");
                      }else{
                        EasyLoading.showError("Duplicated Item");
                      }

                       HomeController.chipIndex.value = 0;
                       titleController.clear();
                       Navigator.pop(context);

                     } else {
                       EasyLoading.showInfo('Please Enter Title');
                     }


                    },
                    child: Text("Confirm"),
                  ),
                ],
              ),
            ),
          )
      ),
      child: Container(
        height: 40,
        width: 100,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.only(bottom: 15,left: 5,right: 5),
        child: CustomShowcaseWidget(
          title: "Add Task Type",
          description: 'Create Task Type.Created Task Type Long Press to Delete',
          globalKey: homect.keyOne,
          child: DottedBorder(
            borderPadding: EdgeInsets.only(bottom: 5),
            dashPattern: [8,4],
            color: Colors.grey,
            strokeWidth: 1,
            child: Center(child: Icon(Icons.add,color: Colors.grey,size: 50,)),
          ),
        ),
      ),
    );
  }
}
