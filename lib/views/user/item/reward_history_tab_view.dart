import 'package:mamo/blocs/task/reward_history_tab_view_bloc.dart';
import 'package:mamo/model/user/transaction_history_model.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/widget/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RewardHistoryTabView extends StatefulWidget {
  @override
  _RewardHistoryTabViewState createState() => _RewardHistoryTabViewState();
}

class _RewardHistoryTabViewState extends State<RewardHistoryTabView> {
  RewardHistoryBloc bloc = RewardHistoryBloc();
  final int pageSize = 20;
  int pageIndex = 1;
  bool isLoading = false;
  List<TransactionHistoryModel> rewardList = [];
  NumberFormat nf = NumberFormat("###,###,###", "en_US");
  @override
  void initState() {
    super.initState();
    bloc.initListener(context);
    bloc.getRewardHistory();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.getRewardHistoryStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            isLoading = false;
            if (snapshot.data.length > 0) {
              rewardList.addAll(snapshot.data);
            }
            if (rewardList.length == 0) {
              return Center(
                  child: Text(
                'Không có dữ liệu',
                style: TextStyle(color: Colors.black54),
              ));
            } else
              return Column(
                children: [
                  NotificationListener(
                    // ignore: missing_return
                    onNotification: (ScrollNotification scrollInfo) {
                      if (!isLoading &&
                          scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent) {
                        pageIndex = pageIndex + 1;
                        isLoading = true;
                        bloc.getRewardHistory();
                      }
                    },
                    child: Expanded(
                      child: ListView.builder(
                          itemCount: rewardList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: ColorUtils.READED_COLOR,
                                border: Border(
                                  bottom: BorderSide(
                                    width: 2,
                                    color: ColorUtils.gray6,
                                  ),
                                ),
                              ),
                              child: ListTile(
                                onTap: () {},
                                leading: Container(
                                  width: setWidth(50),
                                  height: setHeight(50),
                                  child: getRewardIcon(
                                      rewardList[index].rewardType??""
                                  ),
                                ),
                                // title: getRewardTitle(rewardList[index]),
                                subtitle: Text(
                                  (rewardList[index].createdDateStr == null ||
                                          rewardList[index]
                                              .createdDateStr
                                              .isEmpty)
                                      ? ''
                                      : rewardList[index]
                                          .createdDateStr
                                          .substring(0, 16),
                                  style: TextStyle(
                                      fontFamily: 'SFUIText',
                                      color: Colors.black26,
                                      fontSize: setSp(12),
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
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              );
          } else
            return Center(child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(ColorUtils.BG_COLOR),
            ));
        });
  }

  // ignore: missing_return
  Widget getRewardIcon(int rewardType) {
    switch (rewardType) {
      case 1:
        {
          return Image.asset(getAssetsIcon("readbook.png"));
        }
      case 2:
        {
          return Image.asset(getAssetsIcon("news.png"));
        }
      default:
        {
          return Image.asset(getAssetsIcon("video.png"));
        }
    }
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

  // ignore: missing_return
  // Widget getRewardTitle(TransactionHistoryModel reward) {
  //   switch (reward.rewardType) {
  //     case 1:
  //       {
  //         return Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text("Vòng quay may mắn",
  //                 style: TextStyle(
  //                     fontFamily: 'SFUIText',
  //                     color: ColorUtils.BG_COLOR,
  //                     fontSize: setSp(14),
  //                     fontWeight: FontWeight.bold)),
  //             Text(
  //                 "Bạn nhận được ${nf.format(reward.rewardBalance)}đ từ vòng quay may mắn.",
  //                 style: TextStyle(
  //                     fontFamily: 'SFUIText',
  //                     color: Colors.black54,
  //                     fontSize: setSp(12),
  //                     fontWeight: FontWeight.bold)),
  //           ],
  //         );
  //       }
  //     case 2:
  //       {
  //         return Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text("Thợ săn Top 1",
  //                 style: TextStyle(
  //                     fontFamily: 'SFUIText',
  //                     color: ColorUtils.BG_COLOR,
  //                     fontSize: setSp(14),
  //                     fontWeight: FontWeight.bold)),
  //             Text("Bạn được tặng ${nf.format(reward.amount)}đ.",
  //                 style: TextStyle(
  //                     fontFamily: 'SFUIText',
  //                     color: Colors.black54,
  //                     fontSize: setSp(12),
  //                     fontWeight: FontWeight.bold)),
  //           ],
  //         );
  //       }
  //     default:
  //       {
  //         return Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text("Bạn nhận được quà tặng",
  //                 style: TextStyle(
  //                     fontFamily: 'SFUIText',
  //                     color: ColorUtils.BG_COLOR,
  //                     fontSize: setSp(14),
  //                     fontWeight: FontWeight.bold)),
  //             Text("Quà tặng từ Cây Khế ${nf.format(reward.amount)}đ",
  //                 style: TextStyle(
  //                     fontFamily: 'SFUIText',
  //                     color: Colors.black54,
  //                     fontSize: setSp(12),
  //                     fontWeight: FontWeight.bold)),
  //           ],
  //         );
  //       }
  //   }
  // }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
