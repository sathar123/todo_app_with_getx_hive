
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:project_1_todo_app/provider/theme_notifier.dart';
import 'package:project_1_todo_app/screen/home/controller.dart';
import 'package:project_1_todo_app/screen/home/widgets/CustomShowCase.dart';
import 'package:project_1_todo_app/screen/home/widgets/addTask.dart';
import 'package:project_1_todo_app/screen/home/widgets/theme_change.dart';
import 'package:project_1_todo_app/screen/report/report.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../themes/themes.dart';
import 'homepage.dart';

class Home extends StatefulWidget {
 const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final homect = Get.put(HomeController());


   displayShowcase() async {
     SharedPreferences pref = await SharedPreferences.getInstance();
     bool firstOpen = pref.getBool("firstTime") ?? true ;

     if(firstOpen){
       pref.setBool("firstTime", false);
       return true;
     }

     return false;
   }






  @override
  void initState() {
    super.initState();
    displayShowcase().then((status){
      if(status){
        ShowCaseWidget.of(context).startShowCase([
          homect.keyOne,
          homect.keyTwo,
          homect.keyThree,
          homect.keyFour,

        ]);
      }
    });
    WidgetsBinding.instance.addPostFrameCallback(
          (_){}
    );
  }

  @override
  Widget build(BuildContext context) {
    List pages = [
     HomePage(),
      Report(),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        actions: [
          Theme_Change(),
        ],
      ),
      body: Obx(() => pages[HomeController.tabIndex.value]),

      bottomNavigationBar: Theme(
          data: context
              .watch<ThemeNotifier>()
              .currentTheme,
          child: Obx(() =>
              BottomNavigationBar(
                onTap: (int index) => HomeController.changeTabIndex(index),
                currentIndex: HomeController.tabIndex.value,
                items: [
                  const BottomNavigationBarItem(
                      icon: Icon(Icons.home_filled), label: ''),
                  BottomNavigationBarItem(
                      icon: CustomShowcaseWidgetBottom(
                        title: '',
                          description:  'View Report',
                          globalKey: homect.keyThree,
                          child: const Icon(Icons.data_usage)), label: '')
                ],
              ),)
      ),
      floatingActionButton: CustomShowcaseWidgetBottom(
        title: '',
        description: 'Create new todo',
        globalKey: homect.keyTwo,
        child: FloatingActionButton(

          backgroundColor: LigthColor().iconColor,
          onPressed: () {
            if(homect.observableBox.isNotEmpty){
              Get.to(() => AddTask(), transition: Transition.downToUp);
            }else {
              EasyLoading.showInfo('Please Add Task Type');
            }

          },
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
