import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_1_todo_app/Models/TaskType/TaskType.dart';
import 'package:project_1_todo_app/screen/home/controller.dart';
import 'package:project_1_todo_app/screen/home/home.dart';
import 'package:project_1_todo_app/widgets/icons.dart';

class AddTask extends StatelessWidget {
  AddTask({Key? key}) : super(key: key);
  final controller = Get.put(HomeController());
  final taskController = TextEditingController();
  int? selectindex;
  var  data;


  var icons = getIcons();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {

                      controller.clearselect();
                      taskController.clear();
                      Get.back();


                    },
                    icon: Icon(Icons.close),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor:
                      MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      var todo = taskController.text.trim();
                      if(todo.isNotEmpty){
                        if(selectindex != null){

                         var status =  controller.addtodo(todo,selectindex!);
                         if(!status){
                           EasyLoading.showError("Duplicated Task");
                         }
                          Get.to(Home());

                        }else {
                          EasyLoading.showInfo("Please select Task Type");
                        }
                      }else {
                        EasyLoading.showInfo("Please Enter Task");
                      }
                    },
                    child: Text(
                      "Done",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  )
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "New Task",
                style: Theme
                    .of(context)
                    .textTheme
                    .headline1,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: TextField(
                controller: taskController,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[400]!,
                    ),
                  ),
                ),
                autofocus: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 15.0, left: 15.0, right: 15.0, bottom: 2.0),
              child: Text(
                "Add to",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey,
                ),
              ),
            ),
            GetBuilder<HomeController>(builder: (cont){
              var mydata = [];
              var total = cont.tasktype.length;

              return ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: cont.tasktype.length,
                  itemBuilder: (context, int index) {
                    mydata = List.generate(total, (index) {
                      var data = cont.tasktype[index];

                      return data;
                    });

                    var ic = mydata[index].icon;
                    return InkWell(
                      onTap: (){
                        cont.typeselect(index);
                        selectindex = index ;
                        data = mydata[index];
                      },
                      child: ListTile(
                        leading: icons[ic],
                        title: Text(mydata[index].title,style: TextStyle(fontSize: 20),),
                        trailing: (mydata[index].select)? Icon(Icons.check,color: Colors.blue,) : null,
                      ),
                    );

                  });
            })

          ],
        ),
      ),
    );
  }
}
