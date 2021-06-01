import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mamo/blocs/task/reward_history_tab_view_bloc.dart';
import 'package:mamo/model/user/transaction_history_model.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/utils/font_utils.dart';
import 'package:mamo/utils/global_cache.dart';
import 'package:mamo/utils/utilities.dart';
import 'package:mamo/widget/common_appbar.dart';
import 'package:mamo/widget/custom_loading.dart';
import 'package:mamo/widget/global.dart';
import 'package:mamo/widget/time_ago.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

class MonetizationHistory extends StatefulWidget {
  @override
  _MonetizationHistoryState createState() => _MonetizationHistoryState();
}

class _MonetizationHistoryState extends State<MonetizationHistory> {
 RewardHistoryBloc blocReward = RewardHistoryBloc();
 final int pageSize = 20;
 int pageIndex = 1;
 bool isLoading = false;
 NumberFormat nf = NumberFormat("###,###,###", "en_US");
 bool isRefesh=false;

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    blocReward.initListener(context);
    blocReward.getRewardHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarDefault(context, "Lịch sử thưởng", bgColor: ColorUtils.WHITE, result: isRefesh),
      backgroundColor: ColorUtils.WHITE,
      body: StreamBuilder(
          stream: blocReward.getRewardHistoryStream,
          builder: (context, snapshot){
            if(snapshot.hasData){
              List<TransactionHistoryModel> rewardList =snapshot.data;
              double sum = 0;
              rewardList.forEach((element) {
                sum += element.rewardBalance ;
              });
              isLoading = false;
              if(rewardList.length == 0){
                return Center(
                  child: Text("Chưa có lịch sử thưởng",
                    style: FontUtils.MEDIUM.copyWith(color: ColorUtils.TEXT_NAME),),
                );
              }else{
                return
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: setWidth(16), right: setWidth(16)),
                          padding: EdgeInsets.only(top: setHeight(12)),
                          decoration: BoxDecoration(
                              border: Border(top: BorderSide(width: 1, color: ColorUtils.underlined))
                          ),
                          child: Row(
                            children: [
                              Text("Tổng: " +
                                  Utilities.formatMoney( sum??"", suffix: 'đ')
                                , style: FontUtils.BOLD.copyWith(color: ColorUtils.TEXT_PRICE),),
                            ],
                          ),
                        ),
                        SizedBox(height: setHeight(12)),
                        Expanded(
                            child: ListView.builder(
                                itemCount: rewardList.length,
                                itemBuilder: (context, index){
                              return itemReward(rewardList[index]);
                            })),
                      ],
                  //   ),
                //   ),
                );
              }
            }else{
              return Center(child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(ColorUtils.BG_COLOR),
              ));
            }
          }),
    );
  }

 Widget getRewardIcon(int rewardType) {
   switch (rewardType) {
     case 1:
       {
         return Image.asset(getAssetsIcon("readbook.png"), height: setHeight(13),width: setWidth(23),color: ColorUtils.colorTextLogo,);
       }
     case 2:
       {
         return Image.asset(getAssetsIcon("news.png"), height: setHeight(13),width: setWidth(23),color: ColorUtils.colorTextLogo,);
       }
     case 3:
       {
         return Image.asset(getAssetsIcon("video.png"), height: setHeight(13),width: setWidth(23),color: ColorUtils.colorTextLogo,);
       }
     default:
       {
         return Image.asset(getAssetsIcon(""), height: setHeight(13),width: setWidth(23),color: ColorUtils.colorTextLogo,);
       }
   }
 }
 Widget getNameType(int rewardType){
   switch(rewardType){
     case  1:
       {
         return Text("Đọc truyện", style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE, fontSize: setSp(12)));
       }
     case 2 :
       {
         return Text("Đọc báo" , style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE, fontSize: setSp(12)));
       }
     default:
   }
 }

  Widget itemReward(TransactionHistoryModel transaction){
   return Container(
     width: setWidth(343),
     padding: EdgeInsets.only(left: setWidth(16), right: setWidth(16), top: setHeight(11), bottom: setHeight(11)),
     child: Row(
       children: [
         Container(
           margin: EdgeInsets.only(right: setWidth(8)),
             padding: EdgeInsets.all(8),
             decoration: BoxDecoration(
                 color: ColorUtils.colorStatus,
               borderRadius: BorderRadius.circular(12),
             ),
             child: getRewardIcon(transaction.rewardType??"")),
         Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text(transaction.rewardType == 1 ?"đọc truyện" : "đọc báo",
                 maxLines: 2,
                 overflow: TextOverflow.clip,
                 style: FontUtils.MEDIUM.copyWith(
                     fontSize: setSp(12),
                     color: ColorUtils.NUMBER_PAGE)),
             Row(
               children: [
                 Text(formatTimeNow(transaction?.createdDateStr??"")
                   , style: FontUtils.NORMAL.copyWith(fontSize: setSp(11), color: ColorUtils.TEXT_NAME),),
                 SizedBox(width: setWidth(5)),
                 Container(
                   padding: EdgeInsets.all(3),decoration: BoxDecoration(
                     shape: BoxShape.circle, color: ColorUtils.TEXT_PRICE
                 ),),
                 SizedBox(width: setWidth(5)),
                 Text(getDifferentTimeFromNow(transaction.createdDateStr??''), style: FontUtils.NORMAL.copyWith(fontSize: setSp(11), color: ColorUtils.TEXT_NAME),)
               ],
             )
           ],
         ),
         Spacer(),
           Text( "+"+Utilities.formatMoney(transaction.rewardBalance??"", suffix: 'đ')
           , style: FontUtils.BOLD.copyWith(color: ColorUtils.colorTextLogo, fontSize: setSp(12)),)
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
}
