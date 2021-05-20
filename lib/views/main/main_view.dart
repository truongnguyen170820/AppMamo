import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mamo/blocs/impl/event_type.dart';
import 'package:mamo/blocs/impl/stream_event.dart';
import 'package:mamo/blocs/notifications/get_notification_count_blog.dart';
import 'package:mamo/blocs/task/get_recent_rewward_bloc1.dart';
import 'package:mamo/blocs/task/reading/get_home_bloc.dart';
import 'package:mamo/blocs/task/reading/taskReadBloc.dart';
import 'package:mamo/model/user/home_statistic_model.dart';
import 'package:mamo/model/user/recent_reward_model.dart';
import 'package:mamo/utils/font_utils.dart';
import 'package:mamo/utils/global_cache.dart';
import 'package:mamo/utils/text_styles.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/utils/utilities.dart';
import 'package:mamo/views/user/notification_view.dart';
import 'package:mamo/views/user/task/help_view/help_view.dart';
import 'package:mamo/views/user/task/task_view_page.dart';
import 'package:mamo/widget/circle_avatar.dart';
import 'package:mamo/widget/custom_loading.dart';
import 'package:mamo/widget/custombutton.dart';
import 'package:mamo/widget/fail_widget.dart';
import 'package:mamo/widget/global.dart';
import 'package:mamo/widget/loading_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'main_drawer.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  GetRecentRewardBloc1 bloc = GetRecentRewardBloc1();
  GetHomeBloc blocHome = GetHomeBloc();
  TaskReadBloc taskReadBloc = TaskReadBloc();
  dynamic data;
  double maxWidth;
  NumberFormat nf = NumberFormat("###,###,###", "en_US");
  RefreshController controller = RefreshController();
  bool isReading = false;
  int type = 1;
  List<RecentReward> rewardList = [];

  @override
  void initState() {
    super.initState();
    NotificationCountBloc().connect();
    NotificationCountBloc().checkMQTTDisconnect();
    taskReadBloc.getTaskModel(type);
    taskReadBloc.init();
    bloc.getListHistoryBooking();
    bloc.requestListener();
    blocHome.getHome();
    blocHome.requestListener();
  }

  @override
  Widget build(BuildContext context) {
    maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Trang chủ',
          style: FontUtils.MEDIUM
              .copyWith(fontSize: setSp(16), color: ColorUtils.NUMBER_PAGE),
        ),
        centerTitle: true,
        actions: [
          Container(
            padding: EdgeInsets.only(right: setWidth(8)),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  // MaterialPageRoute(builder: (context) => RequestPaySuccess(telcoName: "Viettel",payType: 1, dayRequest: DateTime.now().toString(),amount: 10000,)),
                  MaterialPageRoute(builder: (context) => NotificationView()),
                );
              },
              child: Stack(
                children: [
                  IconButton(
                    icon: Image.asset(
                      getAssetsIcon("hp_notify.png"),
                      width: setWidth(45),
                      height: setHeight(49),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: StreamBuilder(
                      stream:
                          NotificationCountBloc().notifyCounterStream.stream,
                      initialData: 0,
                      builder: (context, snapshot) {
                        int notificationUnread;
                        if (snapshot.hasData) {
                          notificationUnread = snapshot.data;
                          if (notificationUnread == 0) {
                            return Container();
                          } else
                            return Container(
                              constraints: BoxConstraints(
                                minWidth: setWidth(18),
                                minHeight: setHeight(18),
                              ),
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorUtils.RED_BUTTON),
                              alignment: Alignment.center,
                              child: notificationUnread > 99
                                  ? Text(
                                      '99+',
                                      style: TextStyle(
                                          fontFamily: 'SFUIText',
                                          fontWeight: FontWeight.bold,
                                          fontSize: setSp(10),
                                          color: Colors.white),
                                      textAlign: TextAlign.center,
                                    )
                                  : Text(
                                      '$notificationUnread',
                                      style: TextStyle(
                                          fontFamily: 'SFUIText',
                                          fontWeight: FontWeight.bold,
                                          fontSize: setSp(12),
                                          color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                            );
                        } else
                          return Container();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        leading: Builder(builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.only(left: setWidth(8)),
            child: IconButton(
              icon: Image.asset(
                getAssetsIcon("hp_drawer.png"),
                width: setWidth(24),
                height: setWidth(24),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          );
        }),
        backgroundColor: ColorUtils.WHITE,
        elevation: 0.0,
      ),
      backgroundColor: ColorUtils.WHITE,
      drawer: Theme(
        data: Theme.of(context).copyWith(),
        child: MainDrawer(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBody(),
              Container(
                margin: EdgeInsets.only(
                    left: setWidth(16),
                    right: setWidth(16),
                    top: setHeight(9),
                    bottom: setHeight(9)),
                child: Text(
                  "Cộng động độc giả",
                  style: FontUtils.MEDIUM.copyWith(fontSize: setSp(16)),
                ),
              ),
              _buildPeople()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatus1(String status) {
    return Container(
      height: setHeight(58),
      padding: EdgeInsets.only(left: setWidth(16), right: setWidth(16)),
      decoration: BoxDecoration(
        color: isReading ? ColorUtils.colorStatus : ColorUtils.bg1,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color:
                      isReading ? ColorUtils.BG_ICOn : ColorUtils.TEXT_PRICE),
              child: Image.asset(getAssetsIcon("loading .png"), height: 18)),
          SizedBox(width: setWidth(8)),
          Text("Trạng thái",
              style: FontUtils.MEDIUM.copyWith(
                  fontSize: setSp(12), color: ColorUtils.NUMBER_PAGE)),
          Spacer(),
          Text(status,
              style: FontUtils.BOLD.copyWith(
                  color: isReading
                      ? ColorUtils.colorTextLogo
                      : ColorUtils.TEXT_PRICE))
        ],
      ),
    );
  }
  Widget _buildItemViewRead(String read, String money, String page) {
    return Container(
      height: setHeight(165),
      width: setWidth(165),
      padding: EdgeInsets.only(
          top: setHeight(27),
          left: setWidth(46),
          right: setWidth(45),
          bottom: setHeight(25)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ColorUtils.underlined, width: 2)),
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: ColorUtils.BG_ICOn,
                  borderRadius: BorderRadius.circular(15)),
              child: Image.asset(
                getAssetsIcon("readbook.png"),
                height: setHeight(24),
                width: setWidth(24),
              )),
          SizedBox(height: setHeight(9)),
          Text(read,
              style: FontUtils.NORMAL
                  .copyWith(color: ColorUtils.TEXT_NAME, fontSize: setSp(12))),
          Text(money,
              style: FontUtils.BOLD
                  .copyWith(fontSize: setSp(18), color: ColorUtils.TEXT_PRICE)),
          Text(page,
              style: FontUtils.BOLD
                  .copyWith(fontSize: setSp(12), color: ColorUtils.NUMBER_PAGE))
        ],
      ),
    );
  }
  Widget _buildItemTutorial(String nameRead, {Function ontap, Function ontap1}) {
    return Container(
      height: setHeight(58),
      child: Row(
        children: [
          Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ColorUtils.colorStatus),
              child: Image.asset(
                getAssetsIcon("readbook.png"),
                height: setHeight(18),
                color: ColorUtils.colorTextLogo,
              )),
          SizedBox(width: setWidth(11)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(nameRead, style: FontUtils.BOLD),
              SizedBox(height: setHeight(3)),
              GestureDetector(
                  onTap: ontap1,
                  child: Text("Hướng dẫn >>",
                      style: FontUtils.NORMAL.copyWith(
                          fontSize: setSp(12),
                          color: ColorUtils.colorTextLogo)))
            ],
          ),
          Spacer(),
          ButtonCustom(
            onTap: ontap,
            height: setHeight(36),
            width: setWidth(90),
            title: "Đọc",
            textStyle: FontUtils.MEDIUM.copyWith(color: ColorUtils.WHITE),
            borderRadius: 12,
            bgColor: ColorUtils.TEXT_PRICE,
          )
        ],
      ),
    );
  }
  Widget _buildBody() {
    return StreamBuilder(
        stream: blocHome.getEventStream,
        initialData: StreamEvent(eventType: StreamEventType.Loading),
        builder: (context, snapshot) {
          var home = snapshot.data;
          if (home.data == null) return LoadingWidget();
          switch (home.eventType) {
            case StreamEventType.Loading:
              return LoadingWidget();
              break;
            case StreamEventType.Error:
              return InkWell(
                child: FailWidget(mess: home.message),
                onTap: () => blocHome.getHome(),
              );
              break;
            case StreamEventType.Loaded:
              controller.refreshCompleted();
          }
          return Container(
              height: setWidth(382),
              width: double.infinity,
              child: SmartRefresher(
                  onRefresh: _refreshPage,
                  controller: controller,
                  child: _buildBodyPage(context,
                      homeStatisticModel: blocHome.listData.first)));
        });
  }
  Widget _buildBodyPage(BuildContext context, {HomeStatisticModel homeStatisticModel}) {
    return Container(
      decoration: BoxDecoration(
          color: ColorUtils.WHITE,
          border: Border(top: BorderSide(color: ColorUtils.underlined))),
      width: double.infinity,
      margin: EdgeInsets.only(left: setWidth(16), right: setWidth(16)),
      // padding: EdgeInsets.only(left: setWidth(16), right: setWidth(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: setHeight(16)),
          Text(
            "Hôm nay",
            style: FontUtils.MEDIUM.copyWith(fontSize: setSp(16)),
          ),
          SizedBox(height: setHeight(15)),
          Row(
            children: [
              _buildItemViewRead(
                  "Đọc truyện",
                  Utilities.formatMoney(
                      homeStatisticModel.totalMoneyReadStory ?? "",
                      suffix: 'đ'),
                  homeStatisticModel == null
                      ? "(0 trang)"
                      : "( ${homeStatisticModel.numPageReadStory ?? ""} trang)"),
              SizedBox(width: setWidth(13)),
              _buildItemViewRead(
                  "Đọc báo",
                  Utilities.formatMoney(
                      homeStatisticModel.totalMoneyReadNews ?? "",
                      suffix: 'đ'),
                  homeStatisticModel == null
                      ? "(0 trang)"
                      : "( ${homeStatisticModel.numPageReadNews ?? ""} trang)")
            ],
          ),
          Column(
            children: [
              SizedBox(height: setHeight(10)),
              SizedBox(
                height: 12,
              ),
              _buildItemTutorial("Đọc truyện", ontap1: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HelpView()));
              }, ontap: () {
                pushTo(context, TaskViewPage(type: type = 1));
              }),
              Container(
                height: setHeight(1),
                width: 343,
                color: ColorUtils.gray,
              ),
              _buildItemTutorial("Đọc báo", ontap: () {
                pushTo(context, TaskViewPage(type: type = 2));
              }, ontap1: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HelpView()));
              }),
              Container(
                margin: EdgeInsets.only(top: setHeight(8)),
                height: setHeight(1),
                width: 343,
                color: ColorUtils.gray,
              ),
              SizedBox(height: setHeight(16)),
            ],
          )
        ],
      ),
    );
  }
  Widget _buildPeople() {
    return StreamBuilder(
      // stream: getRecentRewardBloc.getRecentRewardStream,
      stream: bloc.getEventStream,
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
              onTap: () => bloc.getListHistoryBooking(),
            );
            break;
          case StreamEventType.Loaded:
            controller.refreshCompleted();
        }
        return bloc.listData.length == 0
            ? Container(
                height: 100,
                alignment: Alignment.center,
                child: Text(
                  "Lịch sử độc giả trống!",
                  style: FontUtils.MEDIUM.copyWith(fontSize: setSp(14)),
                ),
              )
            : Container(
                width: double.infinity,
                height: setHeight(180),
                child: SmartRefresher(
                  controller: controller,
                  enablePullDown: true,
                  header: CustomHeader(
                    builder: (context, mode) {
                      return customLoading;
                    },
                  ),
                  // onRefresh: _refreshPage,
                  onRefresh: () {
                    _refreshPage();
                  },
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: bloc.listData.length,
                      itemBuilder: (context, index) {
                        var itemList = bloc.listData[index];
                        if (bloc.canLoadMore(index, bloc.getListLength())) {
                          bloc.getListHistoryBooking();
                          return customLoading;
                        }
                        return Container(
                          margin: EdgeInsets.only(
                              left: setWidth(16),
                              right: setWidth(16),
                              top: setHeight(9),
                              bottom: setHeight(9)),
                          height: setHeight(48),
                          color: ColorUtils.WHITE,
                          width: double.infinity,
                          child: Row(
                            children: [
                              circleAvatar("", itemList.fullName ?? "",
                                  radius: 25),
                              SizedBox(width: setWidth(8)),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
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
                                        itemList.transationTimeStr ?? ""),
                                    style: FontUtils.NORMAL.copyWith(
                                        fontSize: setSp(11),
                                        color: ColorUtils.TEXT_NAME),
                                  )
                                ],
                              ),
                              Spacer(),
                              Text("+ ${nf.format(itemList.amount ?? "")}đ",
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

  Widget statisticItem(String iconPath, int value, int today, int limit) {
    return GestureDetector(
      onTap: () {
        if (today >= limit) {
          // if (today ==0) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              title: Row(
                children: [
                  Image.asset(
                    'assets/icons/dialog/dialog_notice.png',
                    width: setWidth(20),
                    height: setHeight(22),
                  ),
                  Text(' Thông báo',
                      style: TextStyle(
                          color: ColorUtils.BG_COLOR, fontSize: setSp(15))),
                ],
              ),
              content: Text(
                  'Bạn đã làm đủ số nhiệm vụ trong ngày. Xin vui lòng chọn loại nhiệm vụ khế khác hoặc chờ sang ngày khác.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.black54, fontSize: setSp(14))),
              actions: [
                FlatButton(
                  child: Text('OK',
                      style: TextStyle(
                          color: ColorUtils.BG_COLOR, fontSize: setSp(14))),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        } else {
          //todo
        }
      },
      child: Column(
        children: [
          Image.asset(
            iconPath,
            width: 74,
            height: setWidth(100),
          ),
          Container(
            width: setWidth(50),
            height: setHeight(20),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(today < limit
                    ? "assets/icons/homepage/con_nhiem_vu.png"
                    : "assets/icons/homepage/het_nhiem_vu.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Text(
              "$today/$limit",
              style: TextStyles.common_text.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  Future<Null> _refreshPage() async {
    bloc.getListHistoryBooking(isRefresh: true);
    blocHome.getHome(isRefresh: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
