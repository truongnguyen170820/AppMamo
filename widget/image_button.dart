import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {

  String assetUrl;
  double width, height;
  Function onTap;

  ImageButton({this.assetUrl, this.onTap, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Image.asset(
        assetUrl, width: this.width, height: this.height,
        fit: BoxFit.fill,
      ),
    );
  }
}