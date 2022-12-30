import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../home/controller.dart';

class Report extends StatelessWidget {
  final homecontrol = Get.find<HomeController>();

  Report({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          var createdTasks = homecontrol.getTotaltask();
          var completedTasks = homecontrol.getTotalDonetask();
          var liveTasks = createdTasks! - completedTasks;
          var percent =
              (completedTasks * 100 / createdTasks).toStringAsFixed(0);
          return ListView(
            padding: EdgeInsets.all(10),
            children: [
              Text(
                'My Report',
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    ?.copyWith(fontSize: 30),
              ),
              SizedBox(height: 20),
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Divider(
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatus(
                        Colors.green, liveTasks, "Live Tasks", context),
                    _buildStatus(
                        Colors.orange, completedTasks, "Complated", context),
                    _buildStatus(Colors.blue, createdTasks, "Created", context),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularStepProgressIndicator(
                  totalSteps: createdTasks == 0 ? 1 : createdTasks,
                  currentStep: completedTasks,
                  stepSize: 20,
                  selectedColor: Colors.green,
                  unselectedColor: Colors.grey,
                  padding: 0,
                  width: Get.width * 0.3,
                  height: Get.height * 0.4,
                  selectedStepSize: 22,
                  roundedCap: (_, __) => true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${createdTasks == 0 ? 0 : percent}%",
                          style: Theme.of(context).textTheme.headline1),
                      SizedBox(
                        height: 1.0,
                      ),
                      Text("Efficiency",
                          style: Theme.of(context).textTheme.headline1)
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

Row _buildStatus(Color color, int number, String title, BuildContext ctx) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 15.0,
        width: 15.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 3,
              color: color,
            )),
      ),
      SizedBox(
        width: 5.0,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$number", style: Theme.of(ctx).textTheme.subtitle2),
          SizedBox(
            height: 2.0,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          )
        ],
      ),
    ],
  );
}
