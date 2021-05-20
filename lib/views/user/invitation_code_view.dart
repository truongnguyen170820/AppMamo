import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:mamo/utils/font_utils.dart';
import 'package:mamo/utils/text_styles.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/utils/global_cache.dart';
import 'package:mamo/utils/utilities.dart';
import 'package:mamo/widget/custombutton.dart';
import 'package:mamo/widget/global.dart';
import 'package:mamo/widget/image_button.dart';
import 'package:flutter/material.dart';
import 'package:mamo/widget/common_appbar.dart';
import 'package:share/share.dart';

class InvitationView extends StatefulWidget {
  @override
  _InvitationViewState createState() => _InvitationViewState();
}

class _InvitationViewState extends State<InvitationView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.WHITE,
      appBar: appbarDefault(context, 'Giới thiệu bạn bè',
          bgColor: ColorUtils.WHITE),
      body: Container(
        margin: EdgeInsets.only(left: setWidth(16), right: setWidth(16)),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 1, color: ColorUtils.gray
            )
          )
        ),
        // padding: EdgeInsets.all(setWidth(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: setHeight(14)),

            Image.asset(
              getAssetsImage("info_kiemtien.png"),
              width: setWidth(285),
              height: setHeight(196),
            ),
            Container(
              margin: EdgeInsets.only(top: setHeight(19)),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                  "Cơ chế tính hoa hồng giới thiệu app Mamo",
                    style: FontUtils.NORMAL.copyWith(color: ColorUtils.NUMBER_PAGE),
                    textAlign: TextAlign.justify,
                    textScaleFactor: 1.1,
                  ),
                  Text(
                    "● Khi thành viên được giới thiệu hoàn thành nhiệm vụ thì bạn (người giới thiệu app) sẽ được nhận 10% giá trị tiền thưởng"
                    ,    style: FontUtils.NORMAL.copyWith(color: ColorUtils.NUMBER_PAGE, fontSize: setSp(13)),
                    textAlign: TextAlign.justify,
                    textScaleFactor: 1.1,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: setHeight(12),
            ),
            Text('Link giới thiệu bạn bè',
                style: FontUtils.NORMAL.copyWith(
                    color: ColorUtils.TEXT_NAME, fontSize: setSp(12))),
            SizedBox(
              height: setHeight(10),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: setWidth(16), top: setHeight(8), bottom: setHeight(9)),
              width: setWidth(343),
              decoration: BoxDecoration(
                  color: ColorUtils.underlined,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1, color: ColorUtils.TEXT_NAME)),
              child: Text(
                url??"lỗi",
                style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE),
              ),
            ),
            SizedBox(height: setHeight(16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ButtonCustom(
                  title: "COPY",
                  height: setHeight(42),
                  width: setWidth(163),
                  borderRadius: 12,
                  textStyle: FontUtils.MEDIUM.copyWith(color: ColorUtils.WHITE),
                  bgColor: ColorUtils.TEXT_PRICE,
                  onTap: (){
                    FlutterClipboard.copy(url??"");
                    // FlutterClipboard.copy("");
                    Utilities.showToast(
                        context, "Đã copy đường dẫn trang web");
                  },
                ),
                ButtonCustom(
                  title: "SHARE",
                  height: setHeight(42),
                  width: setWidth(163),
                  borderRadius: 12,
                  textStyle: FontUtils.MEDIUM.copyWith(color: ColorUtils.WHITE),
                  onTap:
                      url.isEmpty? null :
                      (){
                    share(context);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  String url = "http://mamo-app.com?source=${GlobalCache().loginData.userName??""}";
  String subject = "";

  share (BuildContext context){
    final RenderBox box = context.findRenderObject();
    Share.share(url,subject: subject, sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
