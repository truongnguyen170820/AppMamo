import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mamo/blocs/impl/event_type.dart';
import 'package:mamo/blocs/impl/stream_event.dart';
import 'package:mamo/blocs/user/member_bloc.dart';
import 'package:mamo/model/user/my_member_model.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/utils/font_utils.dart';
import 'package:mamo/widget/circle_avatar.dart';
import 'package:mamo/widget/common_appbar.dart';
import 'package:mamo/widget/custom_loading.dart';
import 'package:mamo/widget/fail_widget.dart';
import 'package:mamo/widget/global.dart';
import 'package:mamo/widget/loading_widget.dart';

class ListMemberPage extends StatefulWidget {
  @override
  _ListMemberPageState createState() => _ListMemberPageState();
}

class _ListMemberPageState extends State<ListMemberPage> {
  MemberBloc bloc = MemberBloc();
  List<MyMemberModel> listData;
  NumberFormat nf = NumberFormat("###,###,###", "en_US");
  List<MyMemberModel> listMember;
  @override
  void initState() {
    // bloc.getListHistoryBooking();
    // bloc.requestListener();
    bloc.getMemberList();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarDefault(context, "Thành viên cấp dưới", bgColor: ColorUtils.WHITE),
      backgroundColor: ColorUtils.WHITE,
      body: StreamBuilder(
        stream: bloc.getMemberStream,
          initialData: StreamEvent(eventType: StreamEventType.Loading),
          builder: (context, snapshot){
         if(snapshot.hasData){
           StreamEvent recentRewardList = snapshot.data;
           switch (recentRewardList.eventType) {
             case StreamEventType.Loading:
               return LoadingWidget();
               break;
             case StreamEventType.Error:
               return InkWell(
                 child: FailWidget(mess: recentRewardList.message),
                 onTap: () => bloc.getMemberList(),
               );
               break;
             case StreamEventType.Loaded:
               listData = bloc.listData;
               return Column(
                 children: [
                   Container(
                     margin: EdgeInsets.only(left: setWidth(16), right: setWidth(16), bottom: setHeight(15)),
                     padding: EdgeInsets.only(top: setHeight(17)),
                     decoration: BoxDecoration(
                         border: Border(top: BorderSide(
                             width: 1, color: ColorUtils.gray
                         ))
                     ),
                     child:
                     Row(
                       children: [
                         Text("Tổng: ${bloc.listData.length} thành viên", style: FontUtils.MEDIUM.copyWith(color: ColorUtils.TEXT_PRICE),),
                       ],
                     ),
                   ),
                   Expanded(
                     child: RefreshIndicator(
                       onRefresh: _refreshPage,
                       child: ListView.builder(
                           itemCount: bloc.getListLength(),
                           itemBuilder: (context, index) {
                             if (bloc.canLoadMore(index, bloc.getListLength())) {
                               bloc.getMemberList();
                               return customLoading;
                             }
                             return buildMemberTitle(listData[index]);
                           }),
                     ),
                   ),
                 ],
               );
               break;
           }
           return Center(
               child: CupertinoActivityIndicator(
                 radius: 15,
               ));
         } else {
           return Center(
             child: Text('Không có thành viên cấp dưới'),
           );
         }
      }),
    );
  }
  Future<Null> _refreshPage() async {
    bloc.getMemberList(isRefresh: true);
  }
  Widget buildMemberTitle(MyMemberModel member) {
    return Container(
      margin: EdgeInsets.only(left: setWidth(16),right: setWidth(16), top: setHeight(9), bottom: setHeight(9)),
      child: Row(
        children: [
          circleAvatar(member.userAvatar??"",member.fullName??"", radius: 25),
          SizedBox(
            width: setWidth(10),
          ),
          Container(
            width: setWidth(220),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.fullName??"",
                  style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE, fontSize: setSp(12)),
                  overflow: TextOverflow.clip,
                ),
                Text(member.dateAffiliateStr??"", style: FontUtils.NORMAL.copyWith(color: ColorUtils.TEXT_NAME, fontSize: setSp(11)),)
              ],
            ),
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("Đã đọc", style: FontUtils.NORMAL.copyWith(color: ColorUtils.TEXT_NAME, fontSize: setSp(11))),

              Text(
                "${nf.format(member.totalPageReadNews + member.totalPageReadStory??"")} trang", style: FontUtils.BOLD.copyWith(fontSize: setSp(12), color: ColorUtils.colorTextLogo),)
            ],
          )
        ],
      ),
    );
  }
}
