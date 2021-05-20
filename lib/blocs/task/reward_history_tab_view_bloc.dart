import 'dart:async';
import 'package:mamo/api/api_constants.dart';
import 'package:mamo/api/api_response.dart';
import 'package:mamo/api/api_service.dart';
import 'package:mamo/blocs/impl/base_list_bloc.dart';
import 'package:mamo/blocs/impl/bloc.dart';
import 'package:mamo/model/request/base_response.dart';
import 'package:mamo/model/user/transaction_history_model.dart';
import 'package:mamo/utils/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:mamo/utils/utilities.dart';
import 'package:rxdart/subjects.dart';

class RewardHistoryBloc extends BaseListBlock<TransactionHistoryModel> implements Bloc {
  Subject _subject = BehaviorSubject<ApiResponse<JDIResponse>>();
  StreamController _getRewardHistoryStreamCtrl =
      StreamController<List<TransactionHistoryModel>>();
  Stream<List<TransactionHistoryModel>> get getRewardHistoryStream =>
      _getRewardHistoryStreamCtrl.stream;

  getRewardHistory({bool isRefresh = false}) {
    if (isRequesting()) return;
    if (isRefresh) refreshPage();
    requestStarted();
    ApiService(ApiConstants.TRANSACTION_HIS,
        {"Type": 2, "PageIndex": pageIndex, "PageSize": AppConstants.PAGE_SIZE, }, _subject)
        .execute();
  }
  initListener(BuildContext context) {
    _subject.listen((response) {
      if (response != null && response.status == Status.SUCCESS) {
        requestFinished();
        JDIResponse jdiResponse = response.data;
        if (jdiResponse != null) {
          if (jdiResponse.ErrorCode == AppConstants.ERROR_CODE_SUCCESS) {
            List<TransactionHistoryModel> result =
                jdiResponse.Data.map((e) => TransactionHistoryModel.fromJson(e))
                    .toList();
            setList(result, AppConstants.PAGE_SIZE);
            increasePage();
            _getRewardHistoryStreamCtrl.sink.add(result);
          } else {
            Utilities.showToast(
                context, jdiResponse.ErrorMessage ?? jdiResponse.ErrorCode);
          }
        } else {
          requestFinished();
          Utilities.showToast(context, "Không có dữ liệu");
        }
      } else {

      }
    });
  }
  // fitterData(DateTime dateTimeNow, int period){
  //   String fromDate, toDate;
  //   DateTime pastDay;
  //   DateTime recentDay;
  //   switch (period) {
  //     case 0:
  //       {
  //         fromDate = "${dateTimeNow.day}/${dateTimeNow.month}/${dateTimeNow.year}";
  //         toDate = "${dateTimeNow.day}/${dateTimeNow.month}/${dateTimeNow.year}";
  //       }
  //       break;
  //     case 1:
  //       {
  //         {
  //           pastDay = dateTimeNow.subtract(Duration(days: dateTimeNow.weekday - 1));
  //           fromDate = "${pastDay.day}/${pastDay.month}/${pastDay.year}";
  //           recentDay = dateTimeNow.add(Duration(days: 7 - dateTimeNow.weekday));
  //           toDate = "${recentDay.day}/${recentDay.month}/${recentDay.year}";
  //         }
  //         break;
  //       }
  //     case 2:
  //       {
  //         {
  //           fromDate = FullMonthRequest(dateTimeNow.month, dateTimeNow.year)
  //               .toMap()["FromDateStr"];
  //           toDate = FullMonthRequest(dateTimeNow.month, dateTimeNow.year)
  //               .toMap()["ToDateStr"];
  //           // fromDate = "01/${currentDay.month}/${currentDay.year}";
  //           // toDate = "${currentDay.day}/${currentDay.month}/${currentDay.year}";
  //         }
  //         break;
  //       }
  //   }
  // }

  @override
  void dispose() {
    _getRewardHistoryStreamCtrl.close();
  }
}
