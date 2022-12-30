import 'package:flutter/material.dart';

class LightTheme {
  ThemeData themeLight = ThemeData.light().copyWith(
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        backgroundColor: LigthColor().bgColor,
        selectedItemColor: LigthColor().buttonColor,

      ),
      appBarTheme: AppBarTheme(
          color: LigthColor().iconColor,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(20)))),
      scaffoldBackgroundColor: LigthColor().bgColor,
      textTheme: ThemeData.light().textTheme.copyWith(
          headline1: TextStyle(
            color: LigthColor().iconColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            height: 1.2,
          ),
          subtitle1: TextStyle(
              fontSize: 24.0,
              color: Colors.grey,
              fontWeight: FontWeight.w400),
          subtitle2: TextStyle(
            color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20.0
          )
      ));

  ThemeData themeDark = ThemeData.dark().copyWith(
   scaffoldBackgroundColor: DarkColor().scaffoldBg,
    appBarTheme: AppBarTheme(
      elevation: 0,
        color: DarkColor().cardTextColor,
        iconTheme: IconThemeData(color: LigthColor().buttonColor),
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.vertical(bottom: Radius.circular(20)))),

      textTheme: ThemeData.light().textTheme.copyWith(
          headline1: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            height: 1.2,
          ),
          subtitle1: TextStyle(
             color: Colors.grey,
              fontSize: 24.0,
              fontWeight: FontWeight.w400),
        subtitle2: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0
        )
      ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: DarkColor().scaffoldBg,
      selectedItemColor: LigthColor().buttonColor,

    ),

  );
}

class LigthColor {
  final Color _textColor = Colors.blueGrey;
  final Color bgColor = Color(0xFFEFF5F5);
  final Color cardColor = Color(0xFFD6E4E5);
  final Color iconColor = Color(0xFF497174);
  final Color buttonColor = Color(0xFFEB6440);
}

class DarkColor {
  final Color bgColor = Color(0xFF222831);
  final Color textColor = Color(0xffEEEEEE);
  final Color buttonColor = Color(0xff00ADB5);
  final Color scaffoldBg = Color(0xFF393E46);
  final Color cardTextColor = Color(0xFF222831);
}
