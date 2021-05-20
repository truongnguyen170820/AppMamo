import 'package:mamo/blocs/notifications/notification_social_bloc.dart';
import 'package:mamo/model/user/recent_reward_model.dart';
import 'package:mamo/utils/font_utils.dart';
import 'package:mamo/utils/text_styles.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/utils/utilities.dart';
import 'package:mamo/widget/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationSocialTabView extends StatefulWidget {
  @override
  _NotificationSocialTabViewState createState() => _NotificationSocialTabViewState();
}

class _NotificationSocialTabViewState extends State<NotificationSocialTabView> {
  SocialNotificationBloc bloc = SocialNotificationBloc();
  NumberFormat nf = NumberFormat("###,###,###", "en_US");
  final int pageSize = 20;
  int pageIndex = 1;
  bool isLoading = false;
  List<RecentReward> notifyList = [];

  @override
  void initState() {
    super.initState();
    bloc.initListener(context);
    bloc.getSocialNotification(pageIndex, pageSize);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.getSocialNotificationStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            isLoading = false;
            if (snapshot.data.length > 0) {
              notifyList.addAll(snapshot.data);
            }
            if (notifyList.length > 0) {
              return Column(
                children: [
                  NotificationListener(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (!isLoading &&
                          scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent) {
                        pageIndex = pageIndex + 1;
                        isLoading = true;
                        bloc.getSocialNotification(pageIndex, pageSize);
                      }
                      return;
                    },
                    child: Expanded(
                      child: ListView.builder(
                          itemCount: notifyList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.only(bottom: setHeight(3)),
                              decoration: BoxDecoration(
                                // color: ColorUtils.READED_COLOR,
                                border: Border(
                                  bottom: BorderSide(
                                    width: 2,
                                    color: ColorUtils.gray6,
                                  ),
                                ),
                              ),
                              child: ListTile(
                                leading: Container(
                                  width: setWidth(50),
                                  height: setHeight(50),
                                  child: Image.asset(
                                      getAssetsIcon("sharepeople.png")),
                                ),
                                title: getNotifyTitle(notifyList[index]),
                                subtitle: Text(
                                  notifyList[index]
                                      .transationTimeStr
                                      .substring(0, 16),
                                  style: TextStyle(
                                      fontFamily: 'SFUIText',
                                      color: Colors.black26,
                                      fontSize: setSp(11),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  Container(
                    height: isLoading ? 50.0 : 0,
                    color: Colors.transparent,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(ColorUtils.BG_COLOR),
                      ),
                    ),
                  ),
                ],
              );
            } else
              return Center(
                  child: Text(
                'Không có dữ liệu',
                      style: FontUtils.NORMAL.copyWith(color: ColorUtils.TEXT_NAME,)
              ));
          } else
            return Center(
                child: Text(
                  'Không có dữ liệu',
                  style: FontUtils.NORMAL.copyWith(color: ColorUtils.TEXT_NAME),
                ));
        });
  }

  // ignore: missing_return
  Widget getNotifyTitle(RecentReward notify) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Giới thiệu bạn bè thành công!',
            style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE, fontSize: setSp(13))
        ),
        SizedBox(height: setHeight(3),),
        Row(
          children: [
            Text("Bạn đã giới thiệu ${notify.userName??notify.fullName} và nhận ${Utilities.formatMoney(notify.amount??"", suffix: 'đ')}",
            style: FontUtils.NORMAL.copyWith(color: ColorUtils.TEXT_NAME, fontSize: setSp(11)),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios_outlined, color: ColorUtils.TEXT_NAME, size: 15,)
          ],
        ),
        Text(getDifferentTimeFromNow(notify.transationTimeStr??"") + "."),
        SizedBox(height: setHeight(3),),
      ],
    );
  }
  // Widget getNotifyTitle(RecentReward notify) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text('Nhận thưởng quay số',
  //           style: TextStyle(
  //               fontFamily: 'SFUIText',
  //               color: ColorUtils.BG_COLOR,
  //               fontSize: setSp(13),
  //               fontWeight: FontWeight.bold)),
  //       SizedBox(height: setHeight(3),),
  //       RichText(
  //         textAlign: TextAlign.justify,
  //         text: TextSpan(
  //           text: 'Thợ săn ',
  //           style: TextStyles.common_text.copyWith(fontWeight: FontWeight.normal),
  //           children: [
  //             TextSpan(
  //                 text: notify.fullName ?? notify.userName + ' ',
  //                 style: TextStyle(
  //                     // fontWeight: FontWeight.bold,
  //                     fontFamily: 'SFUIText',
  //                     color: ColorUtils.BG_COLOR,
  //                     fontSize: setSp(12))),
  //             TextSpan(text: ' đã quay được ', style: TextStyles.common_text.copyWith(fontWeight: FontWeight.normal)),
  //             TextSpan(
  //                 text: nf.format(notify.amount) + 'đ ',
  //                 style: TextStyle(
  //                     // fontWeight: FontWeight.bold,
  //                     fontFamily: 'SFUIText',
  //                     color: ColorUtils.BG_COLOR,
  //                     fontSize: setSp(12))),
  //             TextSpan(
  //                 text: getDifferentTimeFromNow(notify.transationTimeStr) + '.',
  //                 style: TextStyles.common_text.copyWith(fontWeight: FontWeight.normal)),
  //           ],
  //         ),
  //       ),
  //       SizedBox(height: setHeight(3),),
  //     ],
  //   );
  // }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
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
