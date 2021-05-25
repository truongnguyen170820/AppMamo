import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mamo/blocs/drawalBloc/drawal_history_bloc.dart';
import 'package:mamo/blocs/impl/api_result_listener.dart';
import 'package:mamo/blocs/impl/event_type.dart';
import 'package:mamo/blocs/impl/stream_event.dart';
import 'package:mamo/blocs/user/get_account_bloc.dart';
import 'package:mamo/blocs/user/request_pay_bloc.dart';
import 'package:mamo/blocs/user/withdrawal_history_tab_view_bloc.dart';
import 'package:mamo/model/user/transaction_history_model.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/utils/font_utils.dart';
import 'package:mamo/utils/global_cache.dart';
import 'package:mamo/utils/utilities.dart';
import 'package:mamo/views/user/item/request_history_tab_view.dart';
import 'package:mamo/views/user/request_pay_view.dart';
import 'package:mamo/widget/circle_avatar.dart';
import 'package:mamo/widget/common_appbar.dart';
import 'package:mamo/widget/custom_loading.dart';
import 'package:mamo/widget/custombutton.dart';
import 'package:mamo/widget/fail_widget.dart';
import 'package:mamo/widget/global.dart';
import 'package:mamo/widget/loading_widget.dart';


class AchievementsBoard extends StatefulWidget {
  @override
  _AchievementsBoardState createState() => _AchievementsBoardState();
}

class _AchievementsBoardState extends State<AchievementsBoard> implements ApiResultListener {
  GetAccountBloc getAccountBloc = GetAccountBloc();
  // HistoryWithdrawalBloc bloc = HistoryWithdrawalBloc();
  WithdrawalHistoryBloc bloc = WithdrawalHistoryBloc();

  final int pageSize = 20;
  int pageIndex = 1;
  bool isLoading = false;
  // List<TransactionHistoryModel> withdrawalList = [];
  NumberFormat nf = NumberFormat("###,###,###", "en_US");
  int payType = 1;
  DateTime dateTimeNow=DateTime.now();
    DateFormat formatter = DateFormat('dd/MM/yyyy');
  todatDate(){
    DateTime dateTime = DateTime.now();
    String formatterDate = formatter.format(dateTime);
    print(formatterDate);
    return formatterDate;
  }
  List<int> itemDropdown = List<int>.generate(4, (index) => index);
  List<String> labelDropdown = ["Hôm nay", "Tuần này", "Tháng này", "Năm nay"];
  int selected = 0;
  String fromDate ;
  String toDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.initListener(context);
    bloc.getWithdrawalHistory(pageIndex, pageSize);
    getAccountBloc.getAccount(context);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: appbarDefault(context, "Bảng thành tích", bgColor: ColorUtils.WHITE),
      body: Container(
        decoration: BoxDecoration(
            color: ColorUtils.WHITE,
          border: Border(
            top: BorderSide(
              color: ColorUtils.underlined,
              width: 1
            )
          )
        ),
        margin: EdgeInsets.only(left: setWidth(16), right: setWidth(16)),

        child: StreamBuilder(
          stream: getAccountBloc.getAccountStream,
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.only(left: setWidth(16), right: setWidth(19),top: setHeight(20), bottom: setHeight(19)),
                    height: setHeight(65),
                   decoration: BoxDecoration(
                     color: ColorUtils.BG_ICOn,
                     borderRadius: BorderRadius.circular(16)
                  ),
                    child: Row(
                      children: [
                        Text("Tổng thu nhập", style: FontUtils.MEDIUM.copyWith(fontSize: setSp(13), color: ColorUtils.colorStatus)),
                        Spacer(),
                        Text(Utilities.formatMoney(GlobalCache().loginData.account.totalBalance??"", suffix: 'đ'), style: FontUtils.BOLD.copyWith(color: ColorUtils.colorStatus, fontSize: setSp(20)),)
                      ],
                    ),
                  ),
                  SizedBox(height: setHeight(16)),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   _itemRead("readbook.png", "Đọc truyện", Utilities.formatMoney(GlobalCache().loginData.account.totalBalanceReadStory??"", suffix: 'đ')),
                 _itemRead("news.png", "Đọc báo",  Utilities.formatMoney(GlobalCache().loginData.account.totalBalanceReadNews??"", suffix: 'đ'))
                 ],
               ),
                  SizedBox(height: setHeight(12)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _itemRead("video.png", "Xem video",Utilities.formatMoney(GlobalCache().loginData.account.totalBalanceViewVideo??"", suffix: 'đ') ),
                      _itemRead("hoahong.png", "Hoa hồng",Utilities.formatMoney(GlobalCache().loginData.account.totalBalanceAffiliate??"", suffix: 'đ') ),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(top: setHeight(16), bottom: setHeight(16)),
                      decoration: BoxDecoration(border: Border.all(width: 1, color: ColorUtils.underlined))),
                  GestureDetector(
                    onTap: (){
                      pushTo(context,RequestHistoryTabView() );
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> RequestHistoryTabView()));
                    },
                    child: Container(
                      padding: EdgeInsets.only(bottom: setHeight(16)),
                      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: ColorUtils.underlined, width: 2))),
                      child: Row(
                        children: [
                          Container(
                              // margin: EdgeInsets.only(left: setWidth(16)),
                              padding: EdgeInsets.all(9),
                              decoration: BoxDecoration(
                                  color: ColorUtils.colorStatus,
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child:
                              Image.asset(getAssetsIcon("history.png"), color: ColorUtils.BG_ICOn,width: setWidth(20),height: setHeight(14),)
                          ),
                          SizedBox(width: setWidth(10)),
                          Text("Yêu cầu rút thẻ",  style: FontUtils.MEDIUM.copyWith(color: ColorUtils.colorTextLogo), ),
                          Spacer(),
                          ButtonCustom(width: setWidth(100),
                            borderRadius: 8,
                            bgColor: ColorUtils.YELLOW_TEXT,
                            height: setHeight(35),
                            textStyle: FontUtils.MEDIUM.copyWith(color: ColorUtils.WHITE),
                            title: "Xem",
                          ),
                        ],
                      ),
                    ),
                  ),


                  Container(
                    margin: EdgeInsets.only(top: setHeight(16), bottom: setHeight(16)),
                    padding: EdgeInsets.only(left: setWidth(16), right: setWidth(19),top: setHeight(20), bottom: setHeight(19)),
                    height: setHeight(65),
                    decoration: BoxDecoration(
                        color: ColorUtils.colorStatus,
                        borderRadius: BorderRadius.circular(16)
                    ),
                    child: Row(
                      children: [
                        Text("Ví hiện có", style: FontUtils.MEDIUM.copyWith(fontSize: setSp(13), color: ColorUtils.colorTextLogo)),
                        Spacer(),
                        Text(
                          Utilities.formatMoney(GlobalCache().loginData.account.balance??"",
                              suffix: 'đ'), style: FontUtils.BOLD.copyWith(color: ColorUtils.TEXT_PRICE, fontSize: setSp(20)),)
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonCustom(
                        title: "RÚT MOMO",
                        width: setWidth(163),
                        height: setHeight(42),
                        borderRadius: 12,
                        bgColor: ColorUtils.TEXT_PRICE,
                        textStyle: FontUtils.MEDIUM.copyWith(color: ColorUtils.WHITE),
                        onTap: (){
                          pushTo(context, RequestPayView(
                            balance:  GlobalCache()
                                .loginData
                                .account
                                .balance,payType: payType = 1 ,
                          ));
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>RequestPayView(
                          //    balance:  GlobalCache()
                          //        .loginData
                          //        .account
                          //        .balance,payType: payType = 1 ,
                          // )));
                        },
                      ),
                      ButtonCustom(
                        title: "RÚT THẺ ĐT",
                        width: setWidth(163),
                        height: setHeight(42),
                        borderRadius: 12,
                        bgColor: ColorUtils.colorTextLogo,
                        textStyle: FontUtils.MEDIUM.copyWith(color: ColorUtils.WHITE),
                        onTap: (){
                          pushTo(context, RequestPayView(
                            balance:  GlobalCache()
                                .loginData
                                .account
                                .balance,payType: payType = 2 ,
                          ));
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>RequestPayView(balance:   GlobalCache()
                          //     .loginData
                          //     .account
                          //     .balance,
                          // payType: payType = 2,
                          // ))) ;
                        })
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(top: setHeight(16), bottom: setHeight(16)),
                      decoration: BoxDecoration(border: Border.all(width: 1, color: ColorUtils.underlined))),
                  Text("Lịch sử rút tiền", style: FontUtils.MEDIUM.copyWith(fontSize: setSp(16)),),
                  SizedBox(height: setHeight(3)),
                  Container(
                    // color: ColorUtils.colorTextLogo,
                    height: setHeight(200),
                    child: StreamBuilder(
                      stream: bloc.getWithdrawalHistoryStream,
                      builder: (context, snapshot){
                        if(snapshot.hasData){
                          List<TransactionHistoryModel> listData = snapshot.data;
                          double sum = 0;
                          listData.forEach((element) {
                            sum += element.amount;
                          });
                          if (listData.length == 0) {
                            return Center(
                                child: Text(
                                  'Chưa có lịch sử rút tiền',
                                  style: FontUtils.MEDIUM.copyWith(color: ColorUtils.TEXT_NAME),),
                            );
                          }
                          else{
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      // withdrawalList.amount??""
                                      "Tổng: ${Utilities.formatMoney(sum??"", suffix: 'đ')} "
                                      , style: FontUtils.BOLD.copyWith(fontSize: setSp(13), color: ColorUtils.TEXT_PRICE),),
                                    // Spacer(),
                                    // Container(
                                    //   height: setHeight(30),
                                    //   width: setWidth(112),
                                    //   padding: EdgeInsets.only(left: setWidth(12), right: setWidth(12), ),
                                    //   decoration: BoxDecoration(
                                    //       borderRadius: BorderRadius.circular(12),
                                    //       border: Border.all(color: ColorUtils.TEXT_NAME, width: 1)
                                    //   ),
                                    //   child: DropdownButtonHideUnderline(
                                    //     child: DropdownButton(
                                    //         icon: Icon(Icons.keyboard_arrow_down,color: ColorUtils.TEXT_NAME,size: 14,),
                                    //         value: selected,
                                    //         items: itemDropdown.map<DropdownMenuItem<int>>((int value) {
                                    //           return DropdownMenuItem(
                                    //             value: value,
                                    //             child: Text("${labelDropdown[value]}",
                                    //                 style: FontUtils.NORMAL.copyWith(color: ColorUtils.TEXT_NAME, fontSize: setSp(12) )),
                                    //           );
                                    //         }).toList(),
                                    //         onChanged: (int index){
                                    //           listData = [];
                                    //           selected = index;
                                    //           fitterData();
                                    //         }),
                                    //   ),
                                    // )
                                  ],
                                ),
                                SizedBox(height: setHeight(10)),
                                Expanded(
                                    child: ListView.builder(
                                        itemCount: listData.length,
                                        itemBuilder: (context, index){
                                          return _buildHistory(listData[index]);
                                        })),
                              ],
                            );
                          }
                        }else{
                          return Center(child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(ColorUtils.BG_COLOR),
                          ));
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }

  Widget _itemRead(String imageUrl, String nameRead, String money){
    return Container(
      height: setHeight(68),
      width: setWidth(165),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorUtils.underlined, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(left: setWidth(16)),
              padding: EdgeInsets.all(9),
              decoration: BoxDecoration(
                  color: ColorUtils.colorStatus,
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Image.asset(getAssetsIcon(imageUrl), color: ColorUtils.BG_ICOn,width: setWidth(20),height: setHeight(20),)
          ),
          SizedBox(width: setWidth(8)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(nameRead, style: FontUtils.MEDIUM.copyWith(fontSize: setSp(12), color: ColorUtils.TEXT_NAME)),
              Text(money, style: FontUtils.BOLD.copyWith(color: ColorUtils.NUMBER_PAGE)),
            ],
          )
        ],
      ),
    );
  }
  Widget _buildHistory(TransactionHistoryModel historyModel){
    return Container(
      height: setHeight(48),
      margin: EdgeInsets.only(left: setWidth(16), right: setWidth(16), top: setHeight(6)),
      child: Row(
        children: [
          Container(
              // margin: EdgeInsets.only(left: setWidth(16)),
              padding: EdgeInsets.all(9),
              decoration: BoxDecoration(
                  color: ColorUtils.colorStatus,
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Image.asset(getAssetsIcon("donal.png"), color: ColorUtils.BG_ICOn,width: setWidth(20),height: setHeight(14),)
          ),
          SizedBox(width: setWidth(8)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Bạn đã rút thành công "+
                  Utilities.formatMoney(historyModel.amount??"",suffix: 'đ')
                  , style: FontUtils.MEDIUM.copyWith(fontSize: setSp(12), color: ColorUtils.NUMBER_PAGE)),
              Text(getDifferentTimeFromNow(historyModel.createdDateStr??""), style: FontUtils.NORMAL.copyWith(fontSize: setSp(11), color: ColorUtils.TEXT_NAME),)
            ],
          ),
          Spacer(),
          Text(
              Utilities.formatMoney(historyModel.amount??"",suffix: 'đ')
              , style: FontUtils.BOLD.copyWith(fontSize: setSp(12),color: ColorUtils.colorTextLogo))
        ],
      ),
    );
  }
  
  String getDifferentTimeFromNow(String pastTime) {
    try {
      DateTime past = DateTime.parse(
          pastTime.substring(0, 10).split('/').reversed.join() +
              pastTime.substring(10));
      Duration duration = DateTime.now().difference(past);
      if (duration.inDays >= 1) {
        return '${duration.inDays} ngày ${duration.inHours - 24 * duration.inDays} giờ trước';
      } else if (duration.inHours >= 1) {
        return '${duration.inHours} giờ ${duration.inMinutes - 60 * duration.inHours} phút trước';
      } else if (duration.inMinutes >= 1) {
        return '${duration.inMinutes} phút trước';
      } else
        return '${duration.inSeconds} giây trước';
    } catch (e) {
      return '';
    }
  }
  // fitterData(){
  //   DateTime pastDay;
  //   DateTime recentDay;
  //   setState(() {
  //     if(selected == 0){
  //       fromDate = "${dateTimeNow.day}/${dateTimeNow.month}/${dateTimeNow.year}";
  //       toDate = "${dateTimeNow.day}/${dateTimeNow.month}/${dateTimeNow.year}";
  //       bloc.getWithdrawalHistory(pageIndex, pageSize);
  //     }else if(selected == 1){
  //       pastDay = dateTimeNow.subtract(Duration(days: dateTimeNow.weekday + 6));
  //       fromDate = "${pastDay.day}/${pastDay.month}/${pastDay.year}";
  //       recentDay = dateTimeNow.subtract(Duration(days: dateTimeNow.weekday));
  //       toDate = "${recentDay.day}/${recentDay.month}/${recentDay.year}";
  //       bloc.getWithdrawalHistory(pageIndex, pageSize);
  //     }else if(selected == 2){
  //       if (dateTimeNow.month > 1) {
  //         fromDate = FullMonthRequest((dateTimeNow.month - 1), dateTimeNow.year)
  //             .toMap()["FromDateStr"];
  //         toDate = FullMonthRequest((dateTimeNow.month - 1), dateTimeNow.year)
  //             .toMap()["ToDateStr"];
  //       } else {
  //         fromDate = "01/12/${dateTimeNow.year - 1}";
  //         toDate = "31/12/${dateTimeNow.year - 1}";
  //       }
  //       bloc.getWithdrawalHistory(pageIndex, pageSize);
  //     }else{
  //
  //     }
  //   });
  // }

  @override
  void onError(String message) {
    // TODO: implement onError
  }

  @override
  void onRequesting() {
    // TODO: implement onRequesting
  }

  @override
  void onSuccess(List response) {
    // TODO: implement onSuccess
  }
  @override
  void dispose() {
    // TODO: implement dispose
    getAccountBloc.dispose();
    bloc.dispose();
    super.dispose();
  }
}

