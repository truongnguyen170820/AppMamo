import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/utils/screen/screen_utils.dart';
import 'package:mamo/views/main/main_view.dart';
import 'package:mamo/views/user/signin_account_view.dart';
import 'package:mamo/widget/global.dart';

class SplashView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashViewState();
}

class SplashViewState extends State<SplashView> {

  startTimer() async {
    var duration = Duration(seconds: 3);
    return Timer(duration, router);
  }
  router(){
    Navigator.push(context, MaterialPageRoute(builder: (context) =>SigninAccountView()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        height: 667, width: 375, allowFontScaling: true);
    return Scaffold(
      body: Container(
        color: ColorUtils.colorTextLogo,
        child: Padding(
          padding: const EdgeInsets.only(left: 0, right: 0,),
          child: Image.asset(
            getAssetsImage("Loading.png"),width: double.infinity, height: double.infinity,
          ),
        ),
      ),
    );
  }
}