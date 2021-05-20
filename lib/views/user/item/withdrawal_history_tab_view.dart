import 'package:mamo/blocs/user/withdrawal_history_tab_view_bloc.dart';
import 'package:mamo/model/user/transaction_history_model.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/widget/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WithdrawalHistoryTabView extends StatefulWidget {
  @override
  _WithdrawalHistoryTabViewState createState() =>
      _WithdrawalHistoryTabViewState();
}

class _WithdrawalHistoryTabViewState extends State<WithdrawalHistoryTabView> {
  WithdrawalHistoryBloc bloc = WithdrawalHistoryBloc();
  final int pageSize = 20;
  int pageIndex = 1;
  bool isLoading = false;
  List<TransactionHistoryModel> withdrawalList = [];
  NumberFormat nf = NumberFormat("###,###,###", "en_US");
  @override
  void initState() {
    super.initState();
    bloc.initListener(context);
    bloc.getWithdrawalHistory(pageIndex, pageSize);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.getWithdrawalHistoryStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            isLoading = false;
            if (snapshot.data.length > 0) {
              withdrawalList.addAll(snapshot.data);
            }
            if (withdrawalList.length == 0) {
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
                        bloc.getWithdrawalHistory(pageIndex, pageSize);
                      }
                    },
                    child: Expanded(
                      child: ListView.builder(
                          itemCount: withdrawalList.length,
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
                                  child: getPayStatusIcon(
                                      withdrawalList[index].payStatus),
                                ),
                                title: getPayStatusTitle(withdrawalList[index]),
                                subtitle: Text(
                                  (withdrawalList[index].createdDateStr ==
                                              null ||
                                          withdrawalList[index]
                                              .createdDateStr
                                              .isEmpty)
                                      ? ''
                                      : withdrawalList[index]
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
            return Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(ColorUtils.BG_COLOR),
            ));
        });
  }

  // ignore: missing_return
  Widget getPayStatusIcon(int type) {
    switch (type) {
      case 0:
        {
          return Image.asset('assets/icons/transaction/choxuly.png');
        }
      case 1:
        {
          return Image.asset('assets/icons/transaction/thanhcong.png');
        }
    }
  }

  // ignore: missing_return
  Widget getPayStatusTitle(TransactionHistoryModel request) {
    switch (request.payStatus) {
      case 0:
        {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Bạn yêu cầu rút ${nf.format(request.amount)}đ",
                  style: TextStyle(
                      fontFamily: 'SFUIText',
                      color: ColorUtils.BG_COLOR,
                      fontSize: setSp(14),
                      fontWeight: FontWeight.bold)),
              if (request.payType == 1)
                Text("Hình thức: Chuyển khoản Momo",
                    style: TextStyle(
                        fontFamily: 'SFUIText',
                        color: Colors.black54,
                        fontSize: setSp(12),
                        fontWeight: FontWeight.bold)),
              if (request.payType == 2)
                Text("Hình thức: Thẻ điện thoại",
                    style: TextStyle(
                        fontFamily: 'SFUIText',
                        color: Colors.black54,
                        fontSize: setSp(12),
                        fontWeight: FontWeight.bold)),
              if (request.payType == 3)
                Text("Hình thức: Thẻ game",
                    style: TextStyle(
                        fontFamily: 'SFUIText',
                        color: Colors.black54,
                        fontSize: setSp(12),
                        fontWeight: FontWeight.bold)),
              Text("Trạng thái: Chờ thanh toán",
                  style: TextStyle(
                      fontFamily: 'SFUIText',
                      color: Colors.black54,
                      fontSize: setSp(12),
                      fontWeight: FontWeight.bold)),
            ],
          );
        }
      case 1:
        {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Bạn yêu cầu rút ${nf.format(request.amount)}đ",
                  style: TextStyle(
                      fontFamily: 'SFUIText',
                      color: ColorUtils.BG_COLOR,
                      fontSize: setSp(14),
                      fontWeight: FontWeight.bold)),
              if (request.payType == 1)
                Text("Hình thức: Chuyển khoản Momo",
                    style: TextStyle(
                        fontFamily: 'SFUIText',
                        color: Colors.black54,
                        fontSize: setSp(12),
                        fontWeight: FontWeight.bold)),
              if (request.payType == 2)
                Text("Hình thức: Thẻ điện thoại",
                    style: TextStyle(
                        fontFamily: 'SFUIText',
                        color: Colors.black54,
                        fontSize: setSp(12),
                        fontWeight: FontWeight.bold)),
              if (request.payType == 3)
                Text("Hình thức: Thẻ game",
                    style: TextStyle(
                        fontFamily: 'SFUIText',
                        color: Colors.black54,
                        fontSize: setSp(12),
                        fontWeight: FontWeight.bold)),
              if (request.cardCode != null && request.cardCode.isNotEmpty)
                Text("Code: " + request.cardCode,
                    style: TextStyle(
                        fontFamily: 'SFUIText',
                        color: Colors.black54,
                        fontSize: setSp(12),
                        fontWeight: FontWeight.bold)),
              if (request.serial != null && request.serial.isNotEmpty)
              Text("Serial: " + request.serial,
                  style: TextStyle(
                      fontFamily: 'SFUIText',
                      color: Colors.black54,
                      fontSize: setSp(12),
                      fontWeight: FontWeight.bold)),
              Text("Trạng thái: Đã thanh toán",
                  style: TextStyle(
                      fontFamily: 'SFUIText',
                      color: Colors.black54,
                      fontSize: setSp(12),
                      fontWeight: FontWeight.bold)),
            ],
          );
        }
    }
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
