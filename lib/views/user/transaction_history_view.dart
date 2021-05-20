import 'package:mamo/utils/text_styles.dart';
import 'package:mamo/views/user/item/request_history_tab_view.dart';
import 'package:mamo/views/user/item/reward_history_tab_view.dart';
import 'package:mamo/views/user/item/withdrawal_history_tab_view.dart';
import 'package:mamo/widget/global.dart';
import 'package:flutter/material.dart';

class TransactionHistoryView extends StatefulWidget {
  @override
  _TransactionHistoryViewState createState() => _TransactionHistoryViewState();
}

class _TransactionHistoryViewState extends State<TransactionHistoryView>
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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            size: 30,
          ),
        ),
        title: Text(
          "Lịch sử giao dịch",
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
                child: Text('Yêu cầu',
                    style: TextStyle(color: Colors.white, fontSize: setSp(13)),
                    textAlign: TextAlign.center)),
            Container(
                alignment: Alignment.topCenter,
                height: setHeight(30),
                child: Text('Thưởng',
                    style: TextStyle(color: Colors.white, fontSize: setSp(13)),
                    textAlign: TextAlign.center)),
            Container(
                alignment: Alignment.topCenter,
                height: setHeight(30),
                child: Text('Rút tiền',
                    style: TextStyle(color: Colors.white, fontSize: setSp(13)),
                    textAlign: TextAlign.center))
          ],
          controller: _transactionTabController,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              children: [
                RequestHistoryTabView(),
                RewardHistoryTabView(),
                WithdrawalHistoryTabView(),
              ],
              controller: _transactionTabController,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _transactionTabController.dispose();
  }
}
