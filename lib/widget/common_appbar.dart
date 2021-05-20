import 'package:flutter/material.dart';
import 'package:mamo/utils/font_utils.dart';
import 'package:mamo/utils/text_styles.dart';
import 'package:mamo/utils/color_utils.dart';

import 'global.dart';

Widget searchAppBar(BuildContext context, String title, Function onBackPress, SearchDelegate delegate) {
  return AppBar(
    leading: IconButton(
      onPressed: onBackPress,
      icon: Icon(Icons.arrow_back_ios),
    ),
    title: Text(
      title,
      style: TextStyle(fontSize: setSp(17), fontWeight: FontWeight.normal),
    ),
    centerTitle: true,
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          showSearch(
            context: context,
            delegate: delegate,
          );
        },
      ),
    ],
    flexibleSpace: Container(
      decoration: BoxDecoration(
        color: ColorUtils.MAIN_GRADIENT_1,
        // gradient: ColorUtils.APPBAR_GRADIENT,
      ),
    ),
    textTheme:
    TextTheme(headline6: TextStyle(color: Colors.white, fontSize: setSp(17))),
    iconTheme: IconThemeData(color: Colors.white),
    elevation: 0.0,
  );
}

Widget backAppBar(BuildContext context, String title) {
  return AppBar(
    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(Icons.arrow_back_ios, size: 30,),
    ),
    title: Text(
      title,
      style: TextStyles.appbar_text,
    ),
    centerTitle: true,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/appbar_bg.png"),
          fit: BoxFit.fill,
        ),
      ),
    ),
    // textTheme:
    // TextTheme(headline6: TextStyle(color: Colors.white, fontSize: setSp(17))),
    // iconTheme: IconThemeData(color: Colors.white),
    elevation: 0.0,
  );
}

Widget transAppBar(BuildContext context, String title) {
  return AppBar(
    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(Icons.arrow_back_ios, size: 30,),
    ),
    title: Text(
      title,
      style: TextStyles.appbar_text,
    ),
    centerTitle: true,
    backgroundColor: Colors.transparent,
    // textTheme:
    // TextTheme(headline6: TextStyle(color: Colors.white, fontSize: setSp(17))),
    // iconTheme: IconThemeData(color: Colors.white),
    elevation: 0.0,
  );
}



Widget appbarDefault(BuildContext context, String title, {Color bgColor, List<Widget> actions,bool isShowLeading=true,bool isCenterTitle=true, dynamic result }) {
  return AppBar(
    leading:isShowLeading? IconButton(
      onPressed: () => pop(context,result:result ),
      icon: Icon(Icons.arrow_back_outlined),color: ColorUtils.NUMBER_PAGE,
    ):SizedBox(),
    title: Text(
      title, style: FontUtils.MEDIUM.copyWith(fontSize: setSp(16),color: ColorUtils.NUMBER_PAGE),),
    centerTitle: isCenterTitle,
    actions: actions,
    backgroundColor: bgColor,
    // flexibleSpace: Container(
    //   decoration: BoxDecoration(
    //     gradient: ColorUtils.APPBAR_GRADIENT,
    //   ),
    // ),
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
