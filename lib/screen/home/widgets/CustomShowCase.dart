

import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class CustomShowcaseWidget extends StatelessWidget {
  final Widget child;
  final String description;
  final GlobalKey globalKey;
  final String title;

  const CustomShowcaseWidget({
    required this.description,
    required this.child,
    required this.globalKey, required this.title,
  });

  @override
  Widget build(BuildContext context) => Showcase(
    key: globalKey,
    title: title,
     titleTextStyle: TextStyle(color: Colors.black, fontSize: 25),
    description: description,
    descTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
    // overlayColor: Colors.white,
    // overlayOpacity: 0.7,
    child: child,
  );
}




class CustomShowcaseWidgetBottom extends StatelessWidget {
  final Widget child;
  final String description;
  final GlobalKey globalKey;
  final String title;

  const CustomShowcaseWidgetBottom({
    required this.description,
    required this.child,
    required this.globalKey, required this.title,
  });

  @override
  Widget build(BuildContext context) => Showcase(
    tooltipPadding: EdgeInsets.symmetric(horizontal: 1,vertical: 5),
    key: globalKey,
    title: title,
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 0),
    description: description,
    descTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
    // overlayColor: Colors.white,
    // overlayOpacity: 0.7,
    child: child,
  );
}