import 'package:mamo/api/api_constants.dart';
import 'package:mamo/api/api_service.dart';
import 'package:mamo/utils/font_utils.dart';
import 'package:mamo/utils/text_styles.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/views/user/item/notifi_tab.dart';
import 'package:mamo/views/user/item/notifi_tab_deal_view.dart';
import 'package:mamo/views/user/item/notification_social_tab_view.dart';
import 'package:mamo/views/user/item/notification_tab_view.dart';
import 'package:mamo/widget/global.dart';
import 'package:flutter/material.dart';

class NotificationView extends StatefulWidget {
  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView>
    with SingleTickerProviderStateMixin {
  TabController _notifyTabController;

  @override
  void initState() {
    super.initState();
    _notifyTabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.WHITE,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_outlined,
            size: 25,
            color: ColorUtils.NUMBER_PAGE,
          ),
        ),
        title: Text(
          "Thông báo",
          style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE),
        ),
        centerTitle: true,
        elevation: 0.0,
        bottom: TabBar(
          indicatorColor: ColorUtils.colorTextLogo,
          indicatorWeight: 3.0,
          tabs: [
            Container(
                alignment: Alignment.topCenter,
                height: setHeight(30),
                child: Text('Thưởng nhiệm vụ',
                    style: FontUtils.NORMAL.copyWith(color: ColorUtils.TEXT_NAME, fontSize: setSp(15)),
                    textAlign: TextAlign.center)),
            Container(
                alignment: Alignment.topCenter,
                height: setHeight(30),
                child: Text('Cộng đồng',
                    style: FontUtils.NORMAL.copyWith(color: ColorUtils.TEXT_NAME, fontSize: setSp(15)),
                    textAlign: TextAlign.center))
          ],
          controller: _notifyTabController,
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  title: Row(
                    children: [
                      Image.asset(
                        getAssetsIcon("ticked.png"),
                        width: setWidth(20),
                        height: setHeight(22),
                      ),
                      Text(' Đánh dấu đã đọc',
                          style: FontUtils.MEDIUM.copyWith(
                              color: ColorUtils.colorTextLogo, fontSize: setSp(15))),
                    ],
                  ),
                  content: Text(
                      'Bạn có muốn đánh dấu đã đọc hết tất cả thông báo?',
                      textAlign: TextAlign.justify,
                      style: FontUtils.NORMAL.copyWith(
                          color: ColorUtils.NUMBER_PAGE)),
                  actions: [
                    FlatButton(
                      child: Text('Không',
                          style: FontUtils.MEDIUM.copyWith(
                              color: ColorUtils.colorTextLogo)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text('Đồng ý',
                          style: FontUtils.MEDIUM.copyWith(
                              color: ColorUtils.colorTextLogo, fontSize: setSp(14))),
                      onPressed: () {
                        Navigator.pop(context);
                        ApiService(ApiConstants.READ_ALL_NOTIFY, {}, null)
                            .getResponse()
                            .then((value) {
                          setState(() {
                            if (_notifyTabController.index == 0)
                              _notifyTabController.index = 1;
                            else
                              _notifyTabController.index = 0;
                          });
                        });
                      },
                    ),
                  ],
                ),
              );
            },
            icon: Image.asset(getAssetsIcon("ticked.png"), height: setHeight(16), width: setWidth(16),),
          ),
        ],
      ),
      body: TabBarView(
        children: [
          NotifiTabDealPage(1),
          NotificationTab(),

        ],
        controller: _notifyTabController,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _notifyTabController.dispose();
  }
}
