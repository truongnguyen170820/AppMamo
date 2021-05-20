import 'package:mamo/utils/text_styles.dart';
import 'package:mamo/views/user/item/list_member_tab_view.dart';
import 'package:mamo/views/user/item/notification_tab_view.dart';
import 'package:mamo/widget/global.dart';
import 'package:flutter/material.dart';

class ListMemberView extends StatefulWidget {
  @override
  _ListMemberViewState createState() => _ListMemberViewState();
}

class _ListMemberViewState extends State<ListMemberView>
    with SingleTickerProviderStateMixin {
  TabController _memberTabController;

  @override
  void initState() {
    super.initState();
    _memberTabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            size: 30,
          ),
        ),
        title: Text(
          "Thành viên",
          style: TextStyles.appbar_text,
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/appbar_bg.png"),
              fit: BoxFit.fill,
            ),
          ),
        ),
        elevation: 0.0,
        bottom: TabBar(
          indicatorColor: Colors.green,
          indicatorWeight: 3.0,
          tabs: [
            Container(
                alignment: Alignment.topCenter,
                height: setHeight(30),
                child: Text('Cấp 1',
                    style: TextStyle(color: Colors.white, fontSize: setSp(13)),
                    textAlign: TextAlign.center)),
            Container(
                alignment: Alignment.topCenter,
                height: setHeight(30),
                child: Text('Cấp 2',
                    style: TextStyle(color: Colors.white, fontSize: setSp(13)),
                    textAlign: TextAlign.center)),
            Container(
                alignment: Alignment.topCenter,
                height: setHeight(30),
                child: Text('Hoa hồng',
                    style: TextStyle(color: Colors.white, fontSize: setSp(13)),
                    textAlign: TextAlign.center)),
          ],
          controller: _memberTabController,
        ),
      ),
      body: TabBarView(
        children: [
          // ListMemberTabView(1),
          // ListMemberTabView(2),
          NotificationTabView(3),
        ],
        controller: _memberTabController,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _memberTabController.dispose();
  }
}
