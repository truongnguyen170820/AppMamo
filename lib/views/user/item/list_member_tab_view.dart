
import 'package:intl/intl.dart';
import 'package:mamo/blocs/user/get_my_member_bloc.dart';
import 'package:mamo/model/user/my_member_model.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/utils/font_utils.dart';
import 'package:mamo/widget/circle_avatar.dart';
import 'package:mamo/widget/common_appbar.dart';
import 'package:mamo/widget/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListMemberTabView extends StatefulWidget {
  @override
  _ListMemberTabViewState createState() => _ListMemberTabViewState();
}

class _ListMemberTabViewState extends State<ListMemberTabView> {
  NumberFormat nf = NumberFormat("###,###,###", "en_US");
  MyMemberBloc bloc = MyMemberBloc();
  final int pageSize = 20;
  int pageIndex = 1;
  bool isLoading = false;
  List<MyMemberModel> memberList = [];
bool canLoadMore = true;
  @override
  void initState() {
    super.initState();
    bloc.init(context);
    bloc.getMemberList( pageIndex, pageSize);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarDefault(context, "Thành viên cấp dưới", bgColor: ColorUtils.WHITE),
backgroundColor: ColorUtils.WHITE,
      body:
       StreamBuilder(
          stream: bloc.getMyMemberStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              isLoading = true;
              if (snapshot.data.length > 0) {
                if (pageIndex == 1) memberList.clear();
                memberList.addAll(snapshot.data);
              }
              if (memberList.length == 0) {
                return Center(
                    child: Text(
                  'Chưa có thành viên',
                  style: TextStyle(color: Colors.black54),
                ));
              } else
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
                      // Text("Tổng: ${memberList[1].childrenLevel1??""} thành viên"),
                      Row(
                        children: [
                          Text("Tổng: ${memberList.length} thành viên", style: FontUtils.MEDIUM.copyWith(color: ColorUtils.TEXT_PRICE),),
                        ],
                      ),
                    ),
                    NotificationListener(
                      // ignore: missing_return
                      onNotification: (ScrollNotification scrollInfo) {
                        if (!isLoading &&
                            scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                          pageIndex = pageIndex + 1;
                          isLoading = true;
                          bloc.getMemberList(pageIndex, pageSize);
                        }
                      },
                      child: Expanded(
                        child: ListView.builder(
                            itemCount: memberList.length,
                            itemBuilder: (context, index) {
                              return buildMemberTitle(memberList[index]);
                            }),
                      ),
                    ),
                    // Container(
                    //   height: isLoading ? 50.0 : 0,
                    //   color: Colors.transparent,
                    //   child: Center(
                    //     child: CircularProgressIndicator(
                    //       valueColor: AlwaysStoppedAnimation(ColorUtils.colorTextLogo),
                    //     ),
                    //   ),
                    // ),
                  ],
                );
            } else
              return Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(ColorUtils.colorTextLogo),
              ));
          }),
    );
  }
  // MyMemberModel member
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

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
