import 'package:mamo/blocs/task/request_history_tab_view_bloc.dart';
import 'package:mamo/model/user/transaction_history_model.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/utils/font_utils.dart';
import 'package:mamo/utils/utilities.dart';
import 'package:mamo/widget/common_appbar.dart';
import 'package:mamo/widget/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RequestHistoryTabView extends StatefulWidget {
  @override
  _RequestHistoryTabViewState createState() => _RequestHistoryTabViewState();
}

class _RequestHistoryTabViewState extends State<RequestHistoryTabView> {
  RequestHistoryBloc bloc = RequestHistoryBloc();
  final int pageSize = 20;
  int pageIndex = 1;
  bool isLoading = false;
  List<TransactionHistoryModel> requestList = [];
  NumberFormat nf = NumberFormat("###,###,###", "en_US");

  @override
  void initState() {
    super.initState();
    bloc.initListener(context);
    bloc.getRequestHistory(pageIndex, pageSize);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.WHITE,
      appBar:
          appbarDefault(context, "Lịch sử rút tiền", bgColor: ColorUtils.WHITE),
      body: StreamBuilder(
          stream: bloc.getRequestHistoryStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              isLoading = false;
              if (snapshot.data.length > 0) {
                requestList.addAll(snapshot.data);
              }
              if (requestList.length == 0) {
                return Center(
                    child: Text(
                  'Chưa có lịch sử rút tiền',
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
                          bloc.getRequestHistory(pageIndex, pageSize);
                        }
                      },
                      child: Expanded(
                        child: ListView.builder(
                            itemCount: requestList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(
                                    left: setWidth(16), right: setWidth(16)),
                                padding: EdgeInsets.only(
                                    top: setHeight(8), bottom: setHeight(8)),
                                decoration: BoxDecoration(
                                  color: ColorUtils.WHITE,
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 2,
                                      color: ColorUtils.underlined,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getRequestIcon(
                                        requestList[index].reqStatus ??
                                            ""),
                                    SizedBox(width: setWidth(10)),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        getRequestTitle(requestList[index]),
                                      ],
                                    )
                                  ],
                                ),
                                // child: ListTile(
                                //   onTap: () {},
                                //   leading: Container(
                                //     width: setWidth(50),
                                //     height: setHeight(50),
                                //     child: getRequestIcon(
                                //         requestList[index].reqStatus),
                                //   ),
                                //   title: getRequestTitle(requestList[index]),
                                //   subtitle: Text(
                                //     requestList[index]
                                //         .createdDateStr
                                //         .substring(0, 16),
                                //     style: TextStyle(
                                //         fontFamily: 'SFUIText',
                                //         color: Colors.black26,
                                //         fontSize: setSp(12),
                                //         fontWeight: FontWeight.bold),
                                //   ),
                                // ),
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
                valueColor: AlwaysStoppedAnimation(ColorUtils.colorTextLogo),
              ));
          }),
    );
  }

  // ignore: missing_return
  Widget getRequestIcon(int reqstatus) {
    switch (reqstatus) {
      case 1:
        {
          return
            Container(
                // margin: EdgeInsets.only(left: setWidth(16)),
                padding: EdgeInsets.all(9),
                decoration: BoxDecoration(
                    color: ColorUtils.colorStatus,
                    borderRadius: BorderRadius.circular(12)
                ),
                child:
                Image.asset(
                  getAssetsIcon("time.png"), color: ColorUtils.BG_ICOn,
                  width: setWidth(20),
                  height: setHeight(14),)
            );
        }
      case 2:
        {
          return  Container(
              // margin: EdgeInsets.only(left: setWidth(16)),
              padding: EdgeInsets.all(9),
              decoration: BoxDecoration(
                  color: ColorUtils.colorStatus,
                  borderRadius: BorderRadius.circular(12)
              ),
              child:
              Image.asset(getAssetsIcon("check.png"), color: ColorUtils.BG_ICOn,width: setWidth(20),height: setHeight(14),)
          );
        }
      case 3:
        {
          return  Container(
              // margin: EdgeInsets.only(left: setWidth(16)),
              padding: EdgeInsets.all(9),
              decoration: BoxDecoration(
                  color: ColorUtils.colorStatus,
                  borderRadius: BorderRadius.circular(12)
              ),
              child:
              Image.asset(getAssetsIcon("tuchoi.png"), color: ColorUtils.BG_ICOn,width: setWidth(20),height: setHeight(14),)
          );
        }
    }
  }

  // ignore: missing_return
  Widget getRequestTitle(TransactionHistoryModel request) {
    switch (request.reqStatus) {
      case 1:
        {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(request.rejectContent??"", style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE),),
              Row(
                children: [
                  Text("Bạn đã yêu cầu rút ",
                    style: FontUtils.NORMAL.copyWith(
                        color: ColorUtils.TEXT_NAME,
                        fontSize: setSp(11)),),
                  Text(Utilities.formatMoney(request.amount??"", suffix: 'đ'),
                    style: FontUtils.NORMAL.copyWith(
                        color: ColorUtils.colorTextLogo,
                        fontSize: setSp(11)),),
                ],
              ),
              SizedBox(height: setHeight(3)),
              if (request.payType == 1)
                Text("Hình thức: Chuyển khoản Momo",
                  style: FontUtils.NORMAL.copyWith(
                      color: ColorUtils.TEXT_NAME,
                      fontSize: setSp(11)),),
              if (request.payType == 2)
                Text("Hình thức: Thẻ điện thoại",
                  style: FontUtils.NORMAL.copyWith(
                      color: ColorUtils.TEXT_NAME,
                      fontSize: setSp(11)),),
              // if (request.payType == 3)
              //   Text("Hình thức: Thẻ game",
              //       style: TextStyle(
              //           fontFamily: 'SFUIText',
              //           color: Colors.black54,
              //           fontSize: setSp(12),
              //           fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Text("Trạng thái: ",
                      style: FontUtils.NORMAL.copyWith(
                          color: ColorUtils.TEXT_NAME, fontSize: setSp(12))
                  ),
                  Text(" Đang xử lý",
                      style: FontUtils.MEDIUM.copyWith(
                          color: ColorUtils.YELLOW_TEXT, fontSize: setSp(12))),
                ],
              ),
              SizedBox(height: setHeight(3)),
              Text(
                "${request.createdDateStr ?? ""}",
                style: FontUtils.NORMAL.copyWith(
                    color: ColorUtils.TEXT_NAME,
                    fontSize: setSp(11)),
              )
            ],
          );
        }
      case 2:
        {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(request.rejectContent??"", style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE),),
              Row(
                children: [
                  Text("Bạn đã yêu cầu rút ",
                    style: FontUtils.NORMAL.copyWith(
                        color: ColorUtils.TEXT_NAME,
                        fontSize: setSp(11)),),
                  Text(Utilities.formatMoney(request.amount??"", suffix: 'đ'),
                    style: FontUtils.NORMAL.copyWith(
                        color: ColorUtils.colorTextLogo,
                        fontSize: setSp(11)),),
                ],
              ),
              SizedBox(height: setHeight(3)),
              if (request.payType == 1)
                Text("Hình thức: Chuyển khoản Momo",
                  style: FontUtils.NORMAL.copyWith(
                      color: ColorUtils.TEXT_NAME,
                      fontSize: setSp(11)),
                ),
              if (request.payType == 2)
                Text("Hình thức: Thẻ điện thoại",
                  style: FontUtils.NORMAL.copyWith(
                      color: ColorUtils.TEXT_NAME,
                      fontSize: setSp(11)),
                ),
              // if (request.payType == 3)
              //   Text("Hình thức: Thẻ game",
              //       style: TextStyle(
              //           fontFamily: 'SFUIText',
              //           color: Colors.black54,
              //           fontSize: setSp(12),
              //           fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Text("Trạng thái: ",
                      style: FontUtils.NORMAL.copyWith(
                          color: ColorUtils.TEXT_NAME, fontSize: setSp(12))),
                  Text(" Đã duyệt",
                      style: FontUtils.MEDIUM.copyWith(
                          color: ColorUtils.colorTextLogo, fontSize: setSp(12))),
                ],
              ),
              SizedBox(height: setHeight(3)),
              Text(
                "${request.acceptDateStr ?? ""}",
                style: FontUtils.NORMAL.copyWith(
                    color: ColorUtils.TEXT_NAME,
                    fontSize: setSp(11)),
              )
            ],
          );
        }
      case 3:
        {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(request.rejectContent??"", style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE),),
              Row(
                children: [
                  Text("Bạn đã yêu cầu rút ",
                    style: FontUtils.NORMAL.copyWith(
                        color: ColorUtils.TEXT_NAME,
                        fontSize: setSp(11)),),
                  Text(Utilities.formatMoney(request.amount??"", suffix: 'đ'),
                    style: FontUtils.NORMAL.copyWith(
                        color: ColorUtils.colorTextLogo,
                        fontSize: setSp(11)),),
                ],
              ),
              SizedBox(height: setHeight(3)),
              if (request.payType == 1)
                Text("Hình thức: Chuyển khoản Momo",
                  style: FontUtils.NORMAL.copyWith(
                      color: ColorUtils.TEXT_NAME,
                      fontSize: setSp(11)),
                ),
              if (request.payType == 2)
                Text("Hình thức: Thẻ điện thoại",
                  style: FontUtils.NORMAL.copyWith(
                      color: ColorUtils.TEXT_NAME,
                      fontSize: setSp(11)),
                ),
              // if (request.payType == 3)
              //   Text("Hình thức: Thẻ game",
              //       style: TextStyle(
              //           fontFamily: 'SFUIText',
              //           color: Colors.black54,
              //           fontSize: setSp(12),
              //           fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Text("Trạng thái: ",
                      style: FontUtils.NORMAL.copyWith(
                          color: ColorUtils.TEXT_NAME, fontSize: setSp(12))),
                  Text("Từ chối",
                      style: FontUtils.MEDIUM
                          .copyWith(color: ColorUtils.bt, fontSize: setSp(12))),
                ],
              ),
              SizedBox(height: setHeight(3)),
              Text(
                "${request.rejectDateStr ?? ""}",
                style: FontUtils.NORMAL.copyWith(
                    color: ColorUtils.TEXT_NAME,
                    fontSize: setSp(11)),
              )
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
