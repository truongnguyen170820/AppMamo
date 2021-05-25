import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/utils/font_utils.dart';
import 'package:mamo/widget/common_appbar.dart';
import 'package:mamo/widget/global.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HelpView extends StatefulWidget {
  // final url;
  //
  // const HelpView({Key key, this.url}) : super(key: key);
  @override
  _HelpViewState createState() => _HelpViewState();
}

class _HelpViewState extends State<HelpView> {
  YoutubePlayerController _ytbCtrl;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // runPlayYourtube();
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          appBar: appbarDefault(context, "Hướng dẫn kiếm tiền",bgColor: ColorUtils.WHITE),
          backgroundColor: ColorUtils.WHITE,
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: setWidth(16), right: setWidth(16)),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          width: 1, color: ColorUtils.gray
                      )
                  )
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hướng dẫn đọc truyện kiếm tiền", style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE),),
                  Container(
                    margin: EdgeInsets.only(top: setHeight(16), bottom: setHeight(16)),
                    padding: EdgeInsets.all(6),
                    height: setHeight(175),
                    decoration: BoxDecoration(
                        color: ColorUtils.gray,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: YoutubePlayer(
                      controller: _ytbCtrl = YoutubePlayerController(initialVideoId: YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=SzhgTo26kh8"),
                          flags: YoutubePlayerFlags(
                              enableCaption: false,
                              isLive: false,
                              autoPlay: false,
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }



  launchYoutube(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Không thể mở trang $url';
    }
  }
  
  launchURL() async {
    const url = 'http://sutichcaykhe.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Không thể mở trang $url';
    }
  }

  launchFB() async {
    const url = 'https://www.facebook.com/groups/3456736937751474/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Không thể mở trang $url';
    }
  }

  launchZalo() async {
    const url = 'https://zalo.me/g/ygheno061';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Không thể mở trang $url';
    }
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    _ytbCtrl.pause();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _ytbCtrl.dispose();
  }
}
