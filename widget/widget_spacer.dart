import 'package:flutter/material.dart';
import 'package:mamo/utils/color_utils.dart';

class WidgetSpacer extends StatelessWidget {
  double _height = 16;
  double _width;
  Color _color;
  EdgeInsets _marginInset;

  WidgetSpacer({double height, double width = 0,Color color = ColorUtils.transparent, EdgeInsets marginInset})
      : this._height = height,
        this._width = width,
        this._color = color,
        this._marginInset = marginInset;


  @override
  Widget build(BuildContext context) {
    return  Container(

      height: _height,
      width: _width,
      color: _color,
      margin: _marginInset,
    );
  }
}
