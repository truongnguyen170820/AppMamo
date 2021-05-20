import 'package:flutter/material.dart';
import 'package:mamo/widget/global.dart';

Widget CustomIcon(double height, double width, String iconPath) {
  return Container(
    height: setHeight(height),width: setWidth(width),
    child: Image.asset(iconPath,),
  );
}