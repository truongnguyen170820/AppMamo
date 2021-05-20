import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:hive/hive.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/utils/font_utils.dart';
import 'package:mamo/utils/global_cache.dart';
import 'package:mamo/utils/utilities.dart';
import 'package:mamo/widget/custombutton.dart';
import 'package:mamo/widget/global.dart';
import 'package:mamo/widget/image_button.dart';
import 'package:flutter/material.dart';
import 'package:mamo/widget/common_appbar.dart';

class RequestPaySuccess extends StatefulWidget {
  final int amount;
  final String dayRequest;
  final int payType;
  final  String telcoName;
   RequestPaySuccess({Key key, this.amount, this.dayRequest, this.payType, this.telcoName}) : super(key: key);

  @override
  _RequestPaySuccessState createState() => _RequestPaySuccessState();
}

class _RequestPaySuccessState extends State<RequestPaySuccess> {
  @override
  Widget build(BuildContext context) {
    // var nf = NumberFormat("###,###,###", "en_US");
    return Scaffold(
      appBar: appbarDefault(context, 'Rút thẻ thành công', bgColor: ColorUtils.WHITE),
      backgroundColor: ColorUtils.WHITE,
      body: SingleChildScrollView(
        child: SafeArea(
          // child: Container(
          //   padding: EdgeInsets.all(20),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: <Widget>[
          //       SizedBox(
          //         height: setHeight(20),
          //       ),
          //       Center(
          //         child: Container(
          //           width: setWidth(70),
          //           height: setHeight(74),
          //           child:
          //               Image.asset('assets/icons/achievement/success_ic.png'),
          //         ),
          //       ),
          //       SizedBox(
          //         height: setHeight(20),
          //       ),
          //       // Center(
          //       //   child: Text(
          //       //     nf.format(widget.amount) + " " + GlobalCache().loginData.account.currency??'VND',
          //       //     style: TextStyle(fontFamily: "SFUIText", color: ColorUtils.BG_COLOR, fontSize: setSp(18), fontWeight: FontWeight.bold),
          //       //   ),
          //       // ),
          //       SizedBox(
          //         height: setHeight(20),
          //       ),
          //       Center(
          //         child: Text(
          //           'App Cây Khế đã nhận được yêu cầu rút tiền của bạn. Xin vui lòng chờ chúng tôi kiểm tra và xác minh trong vòng 72 giờ. Cảm ơn!',
          //           style: TextStyle(fontFamily: "SFUIText", color: Colors.black54, fontSize: setSp(16), fontWeight: FontWeight.bold),
          //           textAlign: TextAlign.center,
          //         ),
          //       ),
          //       SizedBox(
          //         height: setHeight(40),
          //       ),
          //       Center(
          //         child: ButtonCustom(
          //           title: "Đóng",
          //           onTap: (){
          //             backToAchieve();
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          child: Container(
            margin: EdgeInsets.only(left: setWidth(16), right: setWidth(16)),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: ColorUtils.gray,
                  width: 1
                ),
              )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: setHeight(22)),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: setWidth(8)),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: ColorUtils.colorStatus
                        ),
                        child: Image.asset(getAssetsIcon("pay.png"), height: setHeight(18),color: ColorUtils.colorTextLogo,)),
                    Text("Rút thẻ điện thoại thành công!", style: FontUtils.MEDIUM.copyWith(color: ColorUtils.colorTextLogo),),
                  ],
                ),
                _buildCardWithdrawal(),
                SizedBox(height: setHeight(22)),
                Text("Thẻ đã mua", style: FontUtils.BOLD.copyWith(color: ColorUtils.NUMBER_PAGE),),
                _buildRechargeCard(),
                // _buildRequestPay()
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildCardWithdrawal(){
    return Column(
      children: [
      _buildItem("Mệnh giá thẻ", "${widget.amount??""}"),
        _buildItem("Nhà mạng", widget.telcoName??"" ),
        _buildItem("Thời gian", widget.dayRequest??"")
      ],
    );
  }
  Widget _buildItem(String nameParameter, String parameter){
    return Container(
      padding: EdgeInsets.only(top: setHeight(16), bottom: setHeight(14)),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: ColorUtils.gray,
             width: 1
          )
        )
      ),
      child: Row(
        children: [
          Text(nameParameter, style: FontUtils.NORMAL.copyWith(color: ColorUtils.TEXT_NAME, fontSize: setSp(12)),),
          Spacer(),
          Text(parameter, style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE),)
        ],
      ),
    );
  }

  Widget _buildRequestPay(){
    return Container(
      width: setWidth(343),
      child: Text(GlobalCache().errorMessage??"App Mamo quy định chỉ Thứ 6 hàng tuần, các thành viên được thực hiện lệnh rút tiền. Bạn vui lòng thực hiện lệnh này vào ngày Thứ 6 hàng tuần nhé.",
      style: FontUtils.NORMAL.copyWith(color: ColorUtils.NUMBER_PAGE, fontSize: setSp(15)),textAlign: TextAlign.justify,
        textScaleFactor: 1.1,
      ),
    );
  }

  Widget _buildRechargeCard(){
    return Container(
      margin: EdgeInsets.only(top: setHeight(15 )),
      height: setHeight(203),
      width: setWidth(343),
      padding:EdgeInsets.only(left: setWidth(16), top: setHeight(16), right: setWidth(16)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorUtils.gray,width: 2)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: setWidth(8)),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ColorUtils.bg1
                ),
                child: Image.asset(getAssetsIcon("card.png"), height: setHeight(18),color: ColorUtils.TEXT_PRICE,)),
          Column(
            children: [
              Text(widget.telcoName??"", style: FontUtils.MEDIUM.copyWith(color: ColorUtils.TEXT_NAME, fontSize: setSp(12))),
              Text(Utilities.formatMoney(widget.amount??"", suffix: 'đ'),
              style: FontUtils.BOLD.copyWith(color: ColorUtils.colorTextLogo),)
            ],
          ),
          ],
        ),
          SizedBox(height: setHeight(8)),
          Container(
            width: setWidth(311),
            padding: EdgeInsets.only(left: setWidth(16), top: setHeight(11), bottom: setHeight(11)),
            decoration: BoxDecoration(
                color: ColorUtils.underlined,
                borderRadius: BorderRadius.circular(12)
            ),
            child: Text("${widget.payType??""}", style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE)),
          ),
          // SizedBox(height: setHeight(8)),
          //  Text("Số seri: 093094834343498", style: FontUtils.MEDIUM.copyWith(color: ColorUtils.TEXT_NAME,fontSize: setSp(11)),),
          SizedBox(height: setHeight(20)),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonCustom(
                width: setWidth(147),
                height: setHeight(42),
                borderRadius: 12,
                title: "SAO CHÉP",
                bgColor: ColorUtils.TEXT_PRICE,
                textStyle: FontUtils.MEDIUM.copyWith(color: ColorUtils.WHITE),
                onTap: (){
                  FlutterClipboard.copy("");
                  Utilities.showToast(
                      context, "Đã copy mã thẻ");
                },
              ),
              ButtonCustom(
                width: setWidth(147),
                height: setHeight(42),
                borderRadius: 12,
                title: "NẠP NGAY",
                bgColor: ColorUtils.colorTextLogo,
                textStyle: FontUtils.MEDIUM.copyWith(color: ColorUtils.WHITE),
                onTap: () async{
                 await FlutterPhoneDirectCaller.callNumber("0346526900");
                  Utilities.showToast(context, "lỗi");
                },
              )
            ],
          )
        ],
      ),
    );
  }
  void backToAchieve() {
    Navigator.pop(context);
  }
}
