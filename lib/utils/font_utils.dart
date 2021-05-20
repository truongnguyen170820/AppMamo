
import 'package:flutter/cupertino.dart';

import 'color_utils.dart';

class FontUtils {
  static final NORMAL = TextStyle(
    fontFamily: 'SFUIText',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: ColorUtils.TEXT_NORMAL,

  );

  static final MEDIUM = TextStyle(
    fontFamily: 'SFUIText',
    fontWeight: FontWeight.w500,
    color: ColorUtils.TEXT_NORMAL,
  );

  static final SEMIBOLD = TextStyle(
    fontFamily: 'SFUIText',
    fontWeight: FontWeight.w600,
    color: ColorUtils.TEXT_NORMAL,
  );
  static final BOLD = TextStyle(
    fontFamily: 'SFUIText',
    fontWeight: FontWeight.w700,
    color: ColorUtils.TEXT_NORMAL,
  );
  static final Italic = TextStyle(
    fontFamily: 'Italic',
    fontWeight: FontWeight.w700,
    color: ColorUtils.TEXT_NORMAL,
  );
}