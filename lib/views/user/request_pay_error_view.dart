import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/utils/font_utils.dart';
import 'package:mamo/utils/text_styles.dart';
import 'package:mamo/widget/custombutton.dart';
import 'package:mamo/widget/global.dart';
import 'package:mamo/widget/image_button.dart';
import 'package:flutter/material.dart';
import 'package:mamo/widget/common_appbar.dart';

class RequestPayError extends StatefulWidget {
  final String error;

  RequestPayError(this.error);

  @override
  _RequestPayErrorState createState() => _RequestPayErrorState();
}

class _RequestPayErrorState extends State<RequestPayError> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          appbarDefault(context, 'Yêu cầu rút tiền', bgColor: ColorUtils.WHITE),
      backgroundColor: ColorUtils.WHITE,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: setHeight(50)),
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: setHeight(130), bottom: setHeight(20)),
                    child: Image.asset(getAssetsIcon("yeucaurut.png"),)),
                Text(
                  widget.error,
                  style: FontUtils.BOLD.copyWith(color: ColorUtils.NUMBER_PAGE.withOpacity(0.8)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: setHeight(50),
                ),
                Center(
                  child: ButtonCustom(
                    textStyle: FontUtils.MEDIUM.copyWith(color: ColorUtils.WHITE,fontSize: setSp(16)),
                    width: setWidth(200),
                    height: setHeight(42),
                    borderRadius: 12,
                    onTap: () {
                      backToAchieve();
                    },
                    title: "Đóng",
                  ),
                ),
                SizedBox(
                  height: setHeight(40),
                ),
                Text(
                  'Bạn chỉ có thể rút tiền sau khi yêu cầu rút tiền trước đó đã được thanh toán.',
                  style: FontUtils.NORMAL.copyWith(color: ColorUtils.TEXT_NAME, fontSize: setSp(12)),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void backToAchieve() {
    Navigator.pop(context);
  }
}
