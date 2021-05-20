import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/utils/font_utils.dart';
import 'package:mamo/utils/text_styles.dart';
import 'package:mamo/widget/global.dart';
import 'package:flutter/material.dart';

import 'item/get_top_hunter_tab_view.dart';

class TopHunterView extends StatefulWidget {
  @override
  _TopHunterViewState createState() => _TopHunterViewState();
}

class _TopHunterViewState extends State<TopHunterView>
    with SingleTickerProviderStateMixin {
  TabController _transactionTabController;

  @override
  void initState() {
    super.initState();
    _transactionTabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.WHITE,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_outlined,
            size: 30,
            color: ColorUtils.NUMBER_PAGE,
          ),
        ),
        title: Text(
          "Top độc giả",
          style: FontUtils.MEDIUM.copyWith(fontSize: setSp(16), color: ColorUtils.NUMBER_PAGE),
        ),
        backgroundColor: ColorUtils.WHITE,
        centerTitle: true,
        // flexibleSpace: Container(
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage("assets/images/appbar_bg.png"),
        //       fit: BoxFit.fill,
        //     ),
        //   ),
        // ),
        textTheme: TextTheme(
            headline6: TextStyle(color: Colors.white, fontSize: setSp(17))),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
        bottom: TabBar(
          indicatorColor: Colors.green,
          indicatorWeight: 3.0,
          tabs: [
            Container(
                alignment: Alignment.topCenter,
                height: setHeight(30),
                child: Text('Ngày',
                    style: FontUtils.NORMAL.copyWith(color: ColorUtils.TEXT_NAME, fontSize: setSp(15)),
                    textAlign: TextAlign.center)),
            // Container(
            //     alignment: Alignment.topCenter,
            //     height: setHeight(30),
            //     child: Text('Tuần',
            //         style: FontUtils.NORMAL.copyWith(color: ColorUtils.TEXT_NAME, fontSize: setSp(15)),
            //         textAlign: TextAlign.center)),
            Container(
                alignment: Alignment.topCenter,
                height: setHeight(30),
                child: Text('Tháng',
                    style: FontUtils.NORMAL.copyWith(color: ColorUtils.TEXT_NAME, fontSize: setSp(15)),
                    textAlign: TextAlign.center)),
            Container(
                alignment: Alignment.topCenter,
                height: setHeight(30),
                child: Text('Năm',
                    style: FontUtils.NORMAL.copyWith(color: ColorUtils.TEXT_NAME, fontSize: setSp(15)),
                    textAlign: TextAlign.center))
          ],
          controller: _transactionTabController,
        ),
      ),
      body: TabBarView(
        children: [
          TopHunterTabView(1),
          // TopHunterTabView(4),
          TopHunterTabView(2),
          TopHunterTabView(3),
        ],
        controller: _transactionTabController,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _transactionTabController.dispose();
  }
}
