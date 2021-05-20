import 'package:flutter/material.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/widget/global.dart';

class LoadingView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoadingViewState();
}

class LoadingViewState extends State<LoadingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: ColorUtils.BG_COLOR,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: setHeight(10)),
              alignment: Alignment.center,
              width: setWidth(113),
              height: setHeight(105),
              child: Image.asset(
                  "assets/images/loading_ic.png"
              ),
            ),
            Text('Loading...', style: TextStyle(fontSize: setSp(16), color: Colors.white),),
          ],
        ),
      ),
    );
  }
}