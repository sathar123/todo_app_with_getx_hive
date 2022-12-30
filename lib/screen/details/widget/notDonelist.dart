import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../Models/TaskType/TaskType.dart';
import '../../../widgets/icons.dart';
import '../../home/controller.dart';

class DoingList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  final TaskType data;


  DoingList({super.key, required this.data});

  var selectindex;
  var icons = getIcons();

  @override
  Widget build(BuildContext context) {
    return GetX<HomeController>(builder: (controller) {
      return Column(
        children: [
          ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: homeCtrl.notdonetask.length,
              itemBuilder: (context, int index) {
                return ListTile(
                  leading: Checkbox(
                    value: homeCtrl.notdonetask[index]["isDone"],
                    onChanged: (bool? value) {
                      var title = homeCtrl.notdonetask[index]["todoname"];
                      controller.clicktaskDone(value!,data,title);
                    },
                  ),
                  title: Text(
                    homeCtrl.notdonetask[index]["todoname"],
                    style: TextStyle(fontSize: 20),
                  ),
                );
              }),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: homeCtrl.notdonetask.isNotEmpty? Divider(thickness: 2) : null,
          ),
          SizedBox(height: 10,)

        ],
      );
    });
  }
}
