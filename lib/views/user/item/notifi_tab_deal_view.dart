import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mamo/blocs/impl/event_type.dart';
import 'package:mamo/blocs/impl/stream_event.dart';
import 'package:mamo/blocs/notifications/notifi_bloc.dart';
import 'package:mamo/blocs/notifications/notification_bloc.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/utils/font_utils.dart';
import 'package:mamo/widget/custom_loading.dart';
import 'package:mamo/widget/fail_widget.dart';
import 'package:mamo/widget/global.dart';
import 'package:mamo/widget/loading_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotifiTabDealPage extends StatefulWidget {
  final int type;
  NotifiTabDealPage(this.type);

  @override
  _NotifiTabDealPageState createState() => _NotifiTabDealPageState();
}

class _NotifiTabDealPageState extends State<NotifiTabDealPage> {
  NotificationBloc1 bloc = NotificationBloc1();
  RefreshController controller = RefreshController();
  NumberFormat nf = NumberFormat("###,###,###", "en_US");

  @override
  void initState() {
    bloc.getNotification(widget.type);
    bloc.requestListener();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.getNotificationStream,
        initialData: StreamEvent(eventType: StreamEventType.Loading),
        builder: (context, snapshot){
          var notifi = snapshot.data;
          if (notifi.data == null) return LoadingWidget();
          switch (notifi.eventType) {
            case StreamEventType.Loading:
              return LoadingWidget();
              break;
            case StreamEventType.Error:
              return InkWell(
                child: FailWidget(mess: notifi.message),
                onTap: () => notifi.getListHistoryBooking(),
              );
              break;
            case StreamEventType.Loaded:
              controller.refreshCompleted();
          }
          return bloc.listData.length == 0 ?  Container(
            height: 100,
            alignment: Alignment.center,
            child: Text(
              "Danh sách giao dịch trống!",
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
                  child:  ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: bloc.listData.length,
                      itemBuilder: (context, index){
                        var itemList = bloc.listData[index];
                        if (bloc.canLoadMore(index, bloc.getListLength())) {
                          bloc.getNotification(widget.type);
                          return customLoading;
                        }
                        return GestureDetector(
                          onTap: (){
                            showDetail(itemList.title??"", itemList.content??"");
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: setWidth(16), right: setWidth(16)),
                            padding: EdgeInsets.only(top: setHeight(8), bottom: setHeight(8)),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: ColorUtils.underlined,
                                  width: 2
                                )
                              )
                            ),
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: setWidth(10)),
                                    padding: EdgeInsets.all(9),
                                    decoration: BoxDecoration(
                                        color: ColorUtils.colorStatus,
                                        borderRadius: BorderRadius.circular(12)
                                    ),
                                    child:
                                    Image.asset(getAssetsIcon("readbook.png"), color: ColorUtils.BG_ICOn,width: setWidth(20),height: setHeight(14),)
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(itemList.title??"", style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE, fontSize: setSp(13)),),
                                    Container(
                                      margin: EdgeInsets.only(bottom: setHeight(3), top: setHeight(3)),
                                      width: setWidth(290),
                                      child: Text(itemList.content??"", style: FontUtils.NORMAL.copyWith(color: ColorUtils.TEXT_NAME, fontSize: setSp(12)),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text("${itemList.createdTimeStr??""}", style: FontUtils.NORMAL.copyWith(color: ColorUtils.TEXT_NAME, fontSize: setSp(12)),)
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                  }) ,
                ),
              );
        });
  }

  _refreshPage() {
    bloc.getNotification(widget.type, isRefresh: true);
  }
  showDetail(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        title: Row(
          children: [
            Text(
              (title.length < 21) ? title : title.substring(0, 18) + '...',
              style: FontUtils.BOLD.copyWith(
                color: ColorUtils.colorTextLogo,
                fontSize: setSp(13),
              ),
            ),
          ],
        ),
        content: Text(content,
            textAlign: TextAlign.justify,
            style: FontUtils.NORMAL.copyWith(color: ColorUtils.TEXT_NAME, fontSize: setSp(12))),
        actions: [
          FlatButton(
            child: Text('OK',
                style:
                FontUtils.MEDIUM.copyWith(color: ColorUtils.colorTextLogo, fontSize: setSp(14))),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
