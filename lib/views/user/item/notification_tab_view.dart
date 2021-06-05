import 'package:mamo/api/api_constants.dart';
import 'package:mamo/api/api_service.dart';
import 'package:mamo/blocs/impl/notifications/notification_bloc.dart';
import 'package:mamo/model/notification/notification_model.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/widget/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationTabView extends StatefulWidget {
  final int type;
  NotificationTabView(this.type);

  @override
  _NotificationTabViewState createState() => _NotificationTabViewState();
}

class _NotificationTabViewState extends State<NotificationTabView> {
  NotificationBloc bloc = NotificationBloc();
  final int pageSize = 20;
  int pageIndex = 1;
  bool isLoading = false;
  List<NotificationModel> notifyList = [];
  @override
  void initState() {
    super.initState();
    bloc.initListener(context);
    bloc.getNotification(widget.type, pageIndex, pageSize);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.getNotificationStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            isLoading = false;
            if (snapshot.data.length > 0) {
              if (pageIndex == 1) notifyList.clear();
              notifyList.addAll(snapshot.data);
            }
            if (notifyList.length == 0) {
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
                        bloc.getNotification(widget.type, pageIndex, pageSize);
                      }
                    },
                    child: Expanded(
                      child: ListView.builder(
                          itemCount: notifyList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.only(bottom: setHeight(3)),
                              decoration: BoxDecoration(
                                color: notifyList[index].status == 0
                                    ? ColorUtils.gray7
                                    : ColorUtils.READED_COLOR,
                                border: Border(
                                  bottom: BorderSide(
                                    width: 2,
                                    color: ColorUtils.gray6,
                                  ),
                                ),
                              ),
                              child: ListTile(
                                onTap: () {
                                  if (notifyList[index].status == 0) {
                                    setState(() {
                                      notifyList[index].status = 1;
                                    });
                                    ApiService(
                                            ApiConstants.READ_NOTIFY,
                                            {"IdStr": notifyList[index].idStr},
                                            null)
                                        .getResponse();
                                  } else
                                    showDetail(notifyList[index].title,
                                        notifyList[index].content);
                                },
                                leading: Container(
                                  width: setWidth(50),
                                  height: setHeight(50),
                                  child: getNotifyIcon(
                                      notifyList[index].actionType),
                                ),
                                title: getNotifyTitle(notifyList[index]),
                                subtitle: Text(
                                  notifyList[index]
                                      .createdTimeStr
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
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(ColorUtils.BG_COLOR),
            ));
        });
  }

  showDetail(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        title: Row(
          children: [
            Image.asset(
              'assets/icons/dialog/dialog_detail.png',
              width: setWidth(20),
              height: setHeight(22),
            ),
            SizedBox(
              width: setWidth(5),
            ),
            Text(
              (title.length < 21) ? title : title.substring(0, 18) + '...',
              style: TextStyle(
                color: ColorUtils.BG_COLOR,
                fontSize: setSp(13),
              ),
            ),
          ],
        ),
        content: Text(content,
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.black54, fontSize: setSp(12))),
        actions: [
          FlatButton(
            child: Text('OK',
                style:
                    TextStyle(color: ColorUtils.BG_COLOR, fontSize: setSp(14))),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  // ignore: missing_return
  Widget getNotifyIcon(int actionType) {
    switch (actionType) {
      case 1:
        {
          return Image.asset('assets/icons/notify/thuongtienquay.png');
        }
      case 2:
        {
          return Image.asset('assets/icons/notify/thuongdiem.png');
        }
      case 3:
        {
          return Image.asset('assets/icons/notify/tophunter.png');
        }
      case 4:
        {
          return Image.asset('assets/icons/notify/tophunter.png');
        }
      case 5:
        {
          return Image.asset('assets/icons/notify/tophunter.png');
        }
      case 6:
        {
          return Image.asset('assets/icons/notify/yeucaurut.png');
        }
      case 7:
        {
          return Image.asset('assets/icons/notify/gioithieuapp.png');
        }
      case 8:
        {
          return Image.asset('assets/icons/notify/hoahong.png');
        }
      case 9:
        {
          return Image.asset('assets/icons/notify/hoahong.png');
        }
      default:
        {
          return Image.asset('assets/icons/achievement/ic_level3.png');
        }
    }
  }

  // ignore: missing_return
  Widget getNotifyTitle(NotificationModel notify) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(notify.title,
            style: TextStyle(
                fontFamily: 'SFUIText',
                color: ColorUtils.BG_COLOR,
                fontSize: setSp(13),
                fontWeight: FontWeight.bold)),
        SizedBox(
          height: setHeight(3),
        ),
        Text(
          notify.content,
          style: TextStyle(
            fontFamily: 'SFUIText',
            color: Colors.black54,
            fontSize: setSp(12),
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: setHeight(3),
        ),
      ],
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
