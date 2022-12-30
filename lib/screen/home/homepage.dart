import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_1_todo_app/screen/home/controller.dart';
import 'package:project_1_todo_app/screen/home/widgets/addTaskType.dart';
import 'package:project_1_todo_app/screen/home/widgets/task_card.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(HomeController());

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(builder: (cont) {
        var total = cont.tasktype.length ;
        List<Widget> mycard = [];
        mycard = List.generate(total, (index) {
          var data = cont.tasktype[index];
          return TaskCard(data: data,index: index,);
        });
        return Padding(
          padding: const EdgeInsets.all(10
          ),
          child: ListView(children: [
              Padding
                (padding: const EdgeInsets.all(4.0),
                child: Text
                  ('My List',
                  style: Theme.of(context).textTheme.headline1,),
              ),
        GridView.count(
        physics: const ScrollPhysics(),
        padding: EdgeInsets.zero,
        crossAxisCount: 2,
        shrinkWrap: true,
        children: [
        for(var item in mycard) item,
        AddTaskType(),
        ],
        )

            ]
            ,
          )
          ,
        );
      },),
    );
  }
}


