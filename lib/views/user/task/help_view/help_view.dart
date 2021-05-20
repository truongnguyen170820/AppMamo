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
                      controller: _ytbCtrl = YoutubePlayerController(initialVideoId: YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=5nYI0Ie6g2g"),
                          flags: YoutubePlayerFlags(
                              enableCaption: false,
                              isLive: false,
                              autoPlay: false,
                          )
                      ),
                    ),
                  ),
                  // Text("Hướng dẫn đọc truyện kiếm tiền 1111", style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE),),
                  // Container(
                  //   margin: EdgeInsets.only(top: setHeight(16)),
                  //   padding: EdgeInsets.all(6),
                  //   height: setHeight(175),
                  //   decoration: BoxDecoration(
                  //       color: ColorUtils.gray,
                  //       borderRadius: BorderRadius.circular(12)
                  //   ),
                  //   child: YoutubePlayer(
                  //     controller: _ytbCtrl = YoutubePlayerController(initialVideoId: YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=8GxS3lAvONE&list=RD8GxS3lAvONE&start_radio=1"),
                  //         flags: YoutubePlayerFlags(
                  //             enableCaption: false,
                  //             isLive: false,
                  //             autoPlay: false
                  //         )
                  //     ),
                  //   ),
                  // ),
                  // // Text(
                  // //   "Để nhận được sự hỗ trợ trong quá trình sử dụng ứng dụng Cây Khế, bạn có thể truy cập vào trang web của Cây Khế hoặc tham gia Cộng đồng người dùng Cây Khế trên mạng xã hội Facebook và Zalo.",
                  // //   textAlign: TextAlign.justify,
                  // //   style: TextStyle(
                  // //     fontFamily: 'SFUIText',
                  // //     color: Colors.black54,
                  // //     fontWeight: FontWeight.bold,
                  // //     fontSize: setSp(13),
                  // //     // fontWeight: FontWeight.bold,
                  // //   ),
                  // // ),
                  // // SizedBox(
                  // //   height: setHeight(15),
                  // // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     launchURL();
                  //   },
                  //   child: Row(
                  //     children: [
                  //       Image.asset(
                  //         'assets/icons/drawer/web.png',
                  //         width: setWidth(42),
                  //         height: setHeight(46),
                  //       ),
                  //       SizedBox(
                  //         width: setWidth(10),
                  //       ),
                  //       Text(
                  //         'Trang web của Cây Khế',
                  //         style: TextStyle(
                  //             fontFamily: 'SFUIText',
                  //             color: ColorUtils.BG_COLOR,
                  //             fontSize: setSp(14),
                  //             fontWeight: FontWeight.bold),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: setHeight(15),
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     launchFB();
                  //   },
                  //   child: Row(
                  //     children: [
                  //       Image.asset(
                  //         'assets/icons/drawer/fb.png',
                  //         width: setWidth(42),
                  //         height: setHeight(46),
                  //       ),
                  //       SizedBox(
                  //         width: setWidth(10),
                  //       ),
                  //       Text(
                  //         'Group Cây Khế trên Facebook',
                  //         style: TextStyle(
                  //             fontFamily: 'SFUIText',
                  //             color: ColorUtils.BG_COLOR,
                  //             fontSize: setSp(14),
                  //             fontWeight: FontWeight.bold),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: setHeight(15),
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     launchZalo();
                  //   },
                  //   child: Row(
                  //     children: [
                  //       Image.asset(
                  //         'assets/icons/drawer/zl.png',
                  //         width: setWidth(42),
                  //         height: setHeight(46),
                  //       ),
                  //       SizedBox(
                  //         width: setWidth(10),
                  //       ),
                  //       Text(
                  //         'Nhóm chat Cây Khế trên Zalo',
                  //         style: TextStyle(
                  //             fontFamily: 'SFUIText',
                  //             color: ColorUtils.BG_COLOR,
                  //             fontSize: setSp(14),
                  //             fontWeight: FontWeight.bold),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: setHeight(15),
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     launchYoutube("https://www.youtube.com/watch?v=pU7H14EIc0I&feature=youtu.be");
                  //   },
                  //   child: Row(
                  //     children: [
                  //       Image.asset(
                  //         'assets/icons/drawer/yt.png',
                  //         width: setWidth(42),
                  //         height: setHeight(46),
                  //       ),
                  //       SizedBox(
                  //         width: setWidth(10),
                  //       ),
                  //       Expanded(
                  //         child: Text(
                  //           'Video hướng dẫn nhiệm vụ tìm kiếm từ khóa',
                  //           style: TextStyle(
                  //               fontFamily: 'SFUIText',
                  //               color: ColorUtils.BG_COLOR,
                  //               fontSize: setSp(14),
                  //               fontWeight: FontWeight.bold),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: setHeight(10),
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     launchYoutube("https://www.youtube.com/watch?v=5nYI0Ie6g2g");
                  //   },
                  //   child: Row(
                  //     children: [
                  //       Image.asset(
                  //         'assets/icons/drawer/yt.png',
                  //         width: setWidth(42),
                  //         height: setHeight(46),
                  //       ),
                  //       SizedBox(
                  //         width: setWidth(10),
                  //       ),
                  //       Expanded(
                  //         child: Text(
                  //           'Video hướng dẫn nhiệm vụ đọc truyện, đọc báo',
                  //           style: TextStyle(
                  //               fontFamily: 'SFUIText',
                  //               color: ColorUtils.BG_COLOR,
                  //               fontSize: setSp(14),
                  //               fontWeight: FontWeight.bold),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: setHeight(10),
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     launchYoutube("https://www.youtube.com/watch?v=kwoRtDACRfA");
                  //   },
                  //   child: Container(
                  //     width: double.infinity,
                  //     child: Row(
                  //       children: [
                  //         Image.asset(
                  //           'assets/icons/drawer/yt.png',
                  //           width: setWidth(42),
                  //           height: setHeight(46),
                  //         ),
                  //         SizedBox(
                  //           width: setWidth(10),
                  //         ),
                  //         Expanded(
                  //           child: Text(
                  //             'Video hướng dẫn nhiệm vụ click ảnh có chữ i',
                  //             style: TextStyle(
                  //                 fontFamily: 'SFUIText',
                  //                 color: ColorUtils.BG_COLOR,
                  //                 fontSize: setSp(14),
                  //                 fontWeight: FontWeight.bold),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: setHeight(10),
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     launchYoutube("https://www.youtube.com/watch?v=iw6_oBr6pSA");
                  //   },
                  //   child: Row(
                  //     children: [
                  //       Image.asset(
                  //         'assets/icons/drawer/yt.png',
                  //         width: setWidth(42),
                  //         height: setHeight(46),
                  //       ),
                  //       SizedBox(
                  //         width: setWidth(10),
                  //       ),
                  //       Expanded(
                  //         child: Text(
                  //           'Video hướng dẫn nhiệm vụ đánh giá địa điểm',
                  //           style: TextStyle(
                  //               fontFamily: 'SFUIText',
                  //               color: ColorUtils.BG_COLOR,
                  //               fontSize: setSp(14),
                  //               fontWeight: FontWeight.bold),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: setHeight(10),
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     launchYoutube("https://www.youtube.com/watch?v=InAbzoSIGn4&feature=youtu.be");
                  //   },
                  //   child: Row(
                  //     children: [
                  //       Image.asset(
                  //         'assets/icons/drawer/yt.png',
                  //         width: setWidth(42),
                  //         height: setHeight(46),
                  //       ),
                  //       SizedBox(
                  //         width: setWidth(10),
                  //       ),
                  //       Expanded(
                  //         child: Text(
                  //           'Video hướng dẫn nhiệm vụ share Facebook',
                  //           style: TextStyle(
                  //               fontFamily: 'SFUIText',
                  //               color: ColorUtils.BG_COLOR,
                  //               fontSize: setSp(14),
                  //               fontWeight: FontWeight.bold),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: setHeight(10),
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     launchYoutube("https://www.youtube.com/watch?v=0xnNjpCNF_w&feature=youtu.be");
                  //   },
                  //   child: Row(
                  //     children: [
                  //       Image.asset(
                  //         'assets/icons/drawer/yt.png',
                  //         width: setWidth(42),
                  //         height: setHeight(46),
                  //       ),
                  //       SizedBox(
                  //         width: setWidth(10),
                  //       ),
                  //       Expanded(
                  //         child: Text(
                  //           'Video hướng dẫn nhiệm vụ đánh giá Facebook',
                  //           style: TextStyle(
                  //               fontFamily: 'SFUIText',
                  //               color: ColorUtils.BG_COLOR,
                  //               fontSize: setSp(14),
                  //               fontWeight: FontWeight.bold),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
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
