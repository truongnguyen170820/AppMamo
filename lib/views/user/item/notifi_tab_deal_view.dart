import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mamo/blocs/impl/event_type.dart';
import 'package:mamo/blocs/impl/notifications/noti_bloc.dart';
import 'package:mamo/blocs/impl/stream_event.dart';
import 'package:mamo/model/notification/notification_model.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/utils/font_utils.dart';
import 'package:mamo/widget/custom_loading.dart';
import 'package:mamo/widget/fail_widget.dart';
import 'package:mamo/widget/global.dart';
import 'package:mamo/widget/loading_widget.dart';

class NotifiTabDealPage extends StatefulWidget {
  final int type;
  NotifiTabDealPage(this.type);

  @override
  _NotifiTabDealPageState createState() => _NotifiTabDealPageState();
}

class _NotifiTabDealPageState extends State<NotifiTabDealPage> {
  // NotificationBloc1 bloc = NotificationBloc1();
  NotifiBloc bloc = NotifiBloc();
  NumberFormat nf = NumberFormat("###,###,###", "en_US");
  List<NotificationModel> notifiList = [];

  @override
  void initState() {
    bloc.getNotification(widget.type);
    // bloc.requestListener();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.getNotifiStream,
        initialData: StreamEvent(eventType: StreamEventType.Loading),
        builder: (context, snapshot){
         if(snapshot.hasData){
           StreamEvent notifi = snapshot.data;
           switch (notifi.eventType) {
             case StreamEventType.Loading:
               return LoadingWidget();
               break;
             case StreamEventType.Error:
               return InkWell(
                 child: FailWidget(mess: notifi.message),
                 onTap: () => bloc.getNotification(widget.type),
               );
               break;
             case StreamEventType.Loaded:
               notifiList = bloc.listData;
               return RefreshIndicator(
                 onRefresh: _refreshPage,
                 child: ListView.builder(
                     physics: BouncingScrollPhysics(),
                     itemCount: bloc.getListLength(),
                     itemBuilder: (context, index){
                       if (bloc.canLoadMore(index, bloc.getListLength())) {
                         bloc.getNotification(widget.type);
                         return customLoading;
                       }
                       return GestureDetector(
                         onTap: (){
                           showDetail(notifiList[index].title??"", notifiList[index].content??"");
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
                                   Text(notifiList[index].title??"", style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE, fontSize: setSp(13)),),
                                   Container(
                                     margin: EdgeInsets.only(bottom: setHeight(3), top: setHeight(3)),
                                     width: setWidth(290),
                                     child: Text(notifiList[index].content??"", style: FontUtils.NORMAL.copyWith(color: ColorUtils.TEXT_NAME, fontSize: setSp(12)),
                                       maxLines: 2,
                                       overflow: TextOverflow.ellipsis,
                                     ),
                                   ),
                                   Text("${notifiList[index].createdTimeStr??""}", style: FontUtils.NORMAL.copyWith(color: ColorUtils.TEXT_NAME, fontSize: setSp(12)),)
                                 ],
                               )
                             ],
                           ),
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
             child: Text('Không thưởng nhiệm vụ'),
           );
         }

        });
  }

  Future<Null> _refreshPage() async{
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
