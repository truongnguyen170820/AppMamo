
import 'package:flutter/material.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/widget/global.dart';

Widget appbarDefault(BuildContext context, String title, {Color bgColor = ColorUtils.blue1, List<Widget> actions,bool isShowLeading=true,bool isCenterTitle=true, dynamic result }) {
  return AppBar(
    leading:isShowLeading? IconButton(
      onPressed: () => Navigator.pop(context,result ),
      icon: Icon(Icons.arrow_back_ios),
    ):SizedBox(),
    title: Text(
      title, style: TextStyle(fontSize: setSp(18), fontWeight: FontWeight.bold),),
    centerTitle: isCenterTitle,
    actions: actions,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: ColorUtils.APPBAR_GRADIENT,
      ),
    ),
//   backgroundColor: Gradient(colors: [gradient: LinearGradient(
//       colors: [ColorUtils.blue1, ColorUtils.blue2],
//       begin: const FractionalOffset(0.0, 0.0),
//       end: const FractionalOffset(0.5, 0.0),
//       stops: [0.0, 1.0],
//       tileMode: TileMode.clamp
//   ),]),
//    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.white),
    elevation: 0.0,
  );
}