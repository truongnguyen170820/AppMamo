import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mamo/blocs/impl/event_type.dart';
import 'package:mamo/blocs/impl/stream_event.dart';
import 'package:mamo/blocs/task/get_recent_rewward_bloc1.dart';
import 'package:mamo/blocs/user/readers_bloc.dart';
import 'package:mamo/model/user/recent_reward_model.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/utils/font_utils.dart';
import 'package:mamo/widget/circle_avatar.dart';
import 'package:mamo/widget/custom_loading.dart';
import 'package:mamo/widget/fail_widget.dart';
import 'package:mamo/widget/global.dart';
import 'package:mamo/widget/loading_widget.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationTab extends StatefulWidget {
  @override
  _NotificationTabState createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab> {
  ReadersBloc getRecentRewardBloc = ReadersBloc();
  NumberFormat nf = NumberFormat("###,###,###", "en_US");
  List<RecentReward> listRecentReward = [];

  @override
  void initState() {
    getRecentRewardBloc.getReaderList();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getRecentRewardBloc.getReaderStream,
      initialData: StreamEvent(eventType: StreamEventType.Loading),
      builder: (context, snapshot) {
       if(snapshot.hasData){
         StreamEvent notifi = snapshot.data;
         switch (notifi.eventType) {
           case StreamEventType.Loading:
             return LoadingWidget();
             break;
           case StreamEventType.Error:
             return InkWell(
               child: FailWidget(mess: notifi.message),
               onTap: () => getRecentRewardBloc.getReaderList(),
             );
             break;
           case StreamEventType.Loaded:
             listRecentReward = getRecentRewardBloc.listData;
             return  RefreshIndicator(
               onRefresh: _refreshPage,
               child: ListView.builder(
                   physics: BouncingScrollPhysics(),
                   itemCount: listRecentReward.length,
                   itemBuilder: (context, index){
                     return Container(
                       margin: EdgeInsets.only(left: setWidth(16), right: setWidth(16), top: setHeight(9), bottom: setHeight(9)),
                       height: setHeight(48),
                       width: double.infinity,
                       child: Row(
                         children: [
                           circleAvatar(
                               "", listRecentReward[index].fullName ?? "",
                               radius: 25),
                           SizedBox(width: setWidth(8)),
                           Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Container(
                                 width: setWidth(200),
                                 child: Text(
                                     (listRecentReward[index].fullName ??
                                         listRecentReward[index].userName) +
                                         " vừa ${listRecentReward[index].readType == 1 ? "đọc truyện" : "đọc báo"} ",
                                     maxLines: 2,
                                     overflow: TextOverflow.clip,
                                     style: FontUtils.MEDIUM.copyWith(
                                         fontSize: setSp(12),
                                         color: ColorUtils.NUMBER_PAGE)),
                               ),
                               Text(
                                 getDifferentTimeFromNow(
                                     listRecentReward[index].transationTimeStr ??
                                         ""),
                                 style: FontUtils.NORMAL.copyWith(
                                     fontSize: setSp(11),
                                     color: ColorUtils.TEXT_NAME),
                               )
                             ],
                           ),
                           Spacer(),
                           Text(
                               "+ ${nf.format(listRecentReward[index].amount ?? "")}đ",
                               style: FontUtils.BOLD.copyWith(
                                   fontSize: setSp(12),
                                   color: ColorUtils.colorTextLogo))
                         ],
                       ),
                     );
                   }),
             );
             break;
         }
         return Center(
             child: CupertinoActivityIndicator(
               radius: 15,
             ));
       }
       else {
         return Center(
           child: Text('Không cộng đồng'),
         );
       }
      },
    );
  }
  Future<Null> _refreshPage() async {
   await getRecentRewardBloc.getReaderList( isRefresh: true);
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
  @override
  void dispose() {
    super.dispose();
  }
}
