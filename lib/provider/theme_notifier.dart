

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_1_todo_app/themes/themes.dart';

class ThemeNotifier extends ChangeNotifier{
  bool isLightTheme = false;

  void changeTheme(){
    isLightTheme = !isLightTheme;
    notifyListeners();
  }
  ThemeData get currentTheme => isLightTheme ? LightTheme().themeLight: LightTheme().themeDark;
}