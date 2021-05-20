import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mamo/utils/text_styles.dart';

import 'global.dart';

class ImageButton extends StatelessWidget {
  String title;
  bool enable;
  Function onTap;

  ImageButton({this.title, this.enable, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(bottom: setHeight(5)),
        alignment: Alignment.center,
        width: setWidth(150),
        height: setWidth(40),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: enable
                ? AssetImage("assets/icons/simple_btn.png")
                : AssetImage("assets/icons/disable_btn.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Text(
          title,
          style: TextStyles.button_text,
        ),
      ),
    );
  }
}

class SimpleButton extends StatelessWidget {
  String title;
  Function onTap;
  double width;
  double height;
  bool enable;
  SimpleButton(this.title, this.onTap,
      {this.width = 150, this.height = 40, this.enable = true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(bottom: setHeight(5)),
        alignment: Alignment.center,
        width: setWidth(width),
        height: setWidth(height),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: enable
                ? AssetImage("assets/icons/simple_btn.png")
                : AssetImage("assets/icons/disable_btn.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Text(
          title,
          style: TextStyles.button_text,
        ),
      ),
    );
  }
}
