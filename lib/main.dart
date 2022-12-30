

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_1_todo_app/provider/theme_notifier.dart';
import 'package:project_1_todo_app/screen/home/controller.dart';
import 'package:project_1_todo_app/screen/home/home.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import 'Models/TaskType/TaskType.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if(!Hive.isAdapterRegistered(TaskTypeAdapter().typeId)){
    Hive.registerAdapter(TaskTypeAdapter());
  }
  await Hive.openBox<TaskType>("taskdb");
  runApp(MultiProvider(
    providers: [

      ChangeNotifierProvider<ThemeNotifier>(
          create: (context) => ThemeNotifier()),
    ],
    builder: (context, child) => MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final homect = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: context.watch<ThemeNotifier>().currentTheme,
      home: ShowCaseWidget(
        builder: Builder(builder: (_) =>Home()),

      ),
      builder: EasyLoading.init(),
    );
  }
}
