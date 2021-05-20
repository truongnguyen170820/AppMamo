import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mamo/blocs/impl/event_type.dart';
import 'package:mamo/blocs/impl/stream_event.dart';
import 'package:mamo/blocs/task/get_recent_rewward_bloc1.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/utils/font_utils.dart';
import 'package:mamo/widget/circle_avatar.dart';
import 'package:mamo/widget/custom_loading.dart';
import 'package:mamo/widget/fail_widget.dart';
import 'package:mamo/widget/global.dart';
import 'package:mamo/widget/loading_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationTab extends StatefulWidget {
  @override
  _NotificationTabState createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab> {
  GetRecentRewardBloc1 getRecentRewardBloc = GetRecentRewardBloc1();
  RefreshController controller = RefreshController();
  NumberFormat nf = NumberFormat("###,###,###", "en_US");

  @override
  void initState() {
    getRecentRewardBloc.getListHistoryBooking();
    getRecentRewardBloc.requestListener();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getRecentRewardBloc.getEventStream,
      initialData: StreamEvent(eventType: StreamEventType.Loading),
      builder: (context, snapshot) {
        var recentRewardList = snapshot.data;
        if (recentRewardList.data == null) return LoadingWidget();
        switch (recentRewardList.eventType) {
          case StreamEventType.Loading:
            return LoadingWidget();
            break;
          case StreamEventType.Error:
            return InkWell(
              child: FailWidget(mess: recentRewardList.message),
              onTap: () => getRecentRewardBloc.getListHistoryBooking(),
            );
            break;
          case StreamEventType.Loaded:
            controller.refreshCompleted();
        }
        return getRecentRewardBloc.listData.length == 0 ?
        Container(
          height: 100,
          alignment: Alignment.center,
          child: Text(
            "Danh sách cộng đồng trống!",
            style: FontUtils.MEDIUM.copyWith(fontSize: setSp(14)),
          ),
        ) :
        Container(
          width: double.infinity,
          height: setHeight(180),
          color: ColorUtils.WHITE,
          child: SmartRefresher(
            controller: controller,
            enablePullDown: true,
            header: CustomHeader(
              builder: (context, mode) {
                return customLoading;
              },
            ),
            onRefresh: () {
              _refreshPage();
            },
            child: ListView.builder(

                physics: BouncingScrollPhysics(),
                itemCount: getRecentRewardBloc.listData.length,
                itemBuilder: (context, index){
                  var itemList = getRecentRewardBloc.listData[index];
                  if (getRecentRewardBloc.canLoadMore(index, getRecentRewardBloc.getListLength())) {
                    getRecentRewardBloc.getListHistoryBooking();
                    return customLoading;
                  }
                  return Container(
                    margin: EdgeInsets.only(left: setWidth(16), right: setWidth(16), top: setHeight(9), bottom: setHeight(9)),
                    height: setHeight(48),
                    width: double.infinity,
                    child: Row(
                      children: [
                        circleAvatar(
                            "", itemList.fullName ?? "",
                            radius: 25),
                        SizedBox(width: setWidth(8)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: setWidth(200),
                              child: Text(
                                  (itemList.fullName ??
                                      itemList.userName) +
                                      " vừa ${itemList.readType == 1 ? "đọc truyện" : "đọc báo"} ",
                                  maxLines: 2,
                                  overflow: TextOverflow.clip,
                                  style: FontUtils.MEDIUM.copyWith(
                                      fontSize: setSp(12),
                                      color: ColorUtils.NUMBER_PAGE)),
                            ),
                            Text(
                              getDifferentTimeFromNow(
                                  itemList.transationTimeStr ??
                                      ""),
                              style: FontUtils.NORMAL.copyWith(
                                  fontSize: setSp(11),
                                  color: ColorUtils.TEXT_NAME),
                            )
                          ],
                        ),
                        Spacer(),
                        Text(
                            "+ ${nf.format(itemList.amount ?? "")}đ",
                            style: FontUtils.BOLD.copyWith(
                                fontSize: setSp(12),
                                color: ColorUtils.colorTextLogo))
                      ],
                    ),
                  );
                }),
          ),
        );
      },
    );
  }
  _refreshPage() {
    getRecentRewardBloc.getListHistoryBooking( isRefresh: true);
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
    controller.dispose();
    super.dispose();
  }
}
