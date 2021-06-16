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
      appBar: appbarDefault(
          context, "Hướng dẫn kiếm tiền", bgColor: ColorUtils.WHITE),
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
              Container(
                margin: EdgeInsets.only(bottom: setHeight(15)),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Text(
                  "Để nhận được sự hỗ trợ trong quá trình sử dụng ứng dụng Mamo, bạn có thể "
                      "like fanpage hoặc tham gia nhóm người dùng Mamo trên mạng xã hội Facebook.",
                  style: FontUtils.MEDIUM.copyWith(
                      color: ColorUtils.TEXT_NORMAL),
                  textAlign: TextAlign.justify,
                  textScaleFactor: 1.1,
                ),
              ),
              _buildItem("Fanpage của Mamo", "wed.png", ontap: () {
                launchPageFB();
              }),
              _buildItem("Group của Mamo", "fb.png", ontap: () {
                launchFB();
              }),
              SizedBox(height: setHeight(16)),
              Text("Hướng dẫn đọc truyện kiếm tiền",
                style: FontUtils.MEDIUM.copyWith(
                    color: ColorUtils.NUMBER_PAGE),),
              Container(
                margin: EdgeInsets.only(
                    top: setHeight(16), bottom: setHeight(16)),
                padding: EdgeInsets.all(6),
                height: setHeight(175),
                decoration: BoxDecoration(
                    color: ColorUtils.gray,
                    borderRadius: BorderRadius.circular(12)
                ),
                child: YoutubePlayer(
                  controller: _ytbCtrl = YoutubePlayerController(
                      initialVideoId: YoutubePlayer.convertUrlToId(
                          "https://www.youtube.com/watch?v=SzhgTo26kh8&ab_channel=PetoRugs"),
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

  Widget _buildItem(String name, String imageUrl, {Function ontap}) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.only(bottom: setHeight(8), top: setHeight(8)),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: ColorUtils.gray6
                )
            )
        ),
        child: Row(
          children: [
            Image.asset(getAssetsIcon(imageUrl), height: setHeight(45),),
            SizedBox(width: setWidth(8)),
            Text(name,
                style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE))
          ],
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

  launchPageFB() async {
    const url = 'https://www.facebook.com/App-Mamo-%C4%90%E1%BB%8Dc-truy%E1%BB%87n-ki%E1%BA%BFm-ti%E1%BB%81n-online-102350535417291';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Không thể mở trang $url';
    }
  }

  launchFB() async {
    const url = 'https://www.facebook.com/groups/953132765446966/';
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
