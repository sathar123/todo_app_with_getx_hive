
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:project_1_todo_app/provider/theme_notifier.dart';
import 'package:project_1_todo_app/themes/themes.dart';
import 'package:provider/provider.dart';
import '../controller.dart';
import 'CustomShowCase.dart';

class Theme_Change extends StatefulWidget {
   Theme_Change({Key? key}) : super(key: key);


  @override
  State<Theme_Change> createState() => _Theme_ChangeState();
}

class _Theme_ChangeState extends State<Theme_Change> with TickerProviderStateMixin{
  final homect = Get.put(HomeController());
   AnimationController? animationController;
  @override
  void initState() {

    animationController = AnimationController(
        vsync: this, duration: Duration(seconds: 1));
    super.initState();
  }

  bool isLight = true;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()async {
        await animationController?.animateTo(isLight ? 0.5 : 1);
        context.read<ThemeNotifier>().changeTheme();
        isLight = !isLight;
      },

      child: CustomShowcaseWidget(
        title: 'Change Theme',
        description: 'To Switch Dark Mode and Light Mode',
        globalKey: homect.keyFour,
        child: Lottie.asset(
          "assets/lottie/ThemeChange.json",
          repeat: false,
          animate: false,
          controller: animationController,
        ),
      ),
    );
  }
}
