
import 'package:flutter/material.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/widget/global.dart';

class CustomProgressBar extends StatelessWidget {
  final double height, width, radius, maxPoint, centerPoint;
  final EdgeInsets margin;

  const CustomProgressBar({Key key, this.height, this.width, this.radius, this.margin,this.maxPoint, this.centerPoint, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(height: setHeight(height),width: setWidth(width),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius),
        color: ColorUtils.backgroundBoldColor),),
        Container(height: setHeight(height),width: setWidth(centerPoint*width/maxPoint),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius),
              gradient: Gradien_Progressbar ),),
      ],
    );
  }
}
 const Gradien_Progressbar = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xffFA60A4),
      Color(0xffF41666),
    ]);