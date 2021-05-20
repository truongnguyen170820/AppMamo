import 'package:flutter/material.dart';
import 'package:mamo/widget/global.dart';

import 'color_utils.dart';

class TextStyles {
  static final String font = 'Coiny';
    static final String fonti = 'Italic';
  static final String font1 = 'SFUIText';
  static TextStyle copy(
      {Color color,
        double fontSize,
        FontWeight fontWeight,
        TextDecoration decoration}) =>
      TextStyle(
          color: color ?? Colors.white,
          fontSize: fontSize ?? 16,
          fontFamily: font,
          fontWeight: fontWeight ?? FontWeight.normal,
          decoration: decoration);
  static TextStyle hint = TextStyle(fontFamily: font1, fontSize: setSp(12), color: ColorUtils.gray6,);
  static TextStyle hinti = TextStyle(fontFamily: fonti, fontSize: setSp(12), color: ColorUtils.gray6,);
  static TextStyle menu_text = TextStyle(fontFamily: font, color: Colors.white, fontSize: setSp(18));
  static TextStyle button_text = TextStyle(fontFamily: font, color: Colors.white, fontSize: setSp(13));
  static TextStyle common_text = TextStyle(fontFamily: font1, color: Colors.black54, fontSize: setSp(12), fontWeight: FontWeight.bold);
  static TextStyle common_black = TextStyle(fontFamily: font1, color: Colors.black, fontSize: setSp(13), fontWeight: FontWeight.bold);
  static TextStyle appbar_text = TextStyle(fontFamily: font, color: Colors.white, fontSize: setSp(16));
  static TextStyle drawer_text = TextStyle(fontFamily: font, color: Colors.black54, fontSize: setSp(13));
  static TextStyle dialog_text = TextStyle(fontFamily: font, color: Colors.black, fontSize: setSp(12), fontWeight: FontWeight.bold);
  static TextStyle orange_text = TextStyle(fontFamily: font, color: ColorUtils.BG_COLOR, fontSize: setSp(12));
  static TextStyle progress_text = TextStyle(fontFamily: font, color: ColorUtils.colorTextLogo, fontSize: setSp(14));
  static TextStyle appBar =
  TextStyle(fontFamily: font, fontSize: setSp(18), fontWeight: FontWeight.bold);
  static TextStyle text = TextStyle(fontFamily: font);
  static TextStyle textColor({Color color}) => TextStyle(fontFamily: font, color: color);
}
