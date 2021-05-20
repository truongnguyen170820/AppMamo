import 'dart:async';
import 'package:mamo/api/api_constants.dart';
import 'package:mamo/api/api_response.dart';
import 'package:mamo/api/api_service.dart';
import 'package:mamo/blocs/impl/bloc.dart';
import 'package:mamo/model/request/base_response.dart';
import 'package:mamo/model/user/transaction_history_model.dart';
import 'package:mamo/utils/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:mamo/utils/utilities.dart';
import 'package:rxdart/subjects.dart';

class RequestHistoryBloc implements Bloc {
  Subject _subject = BehaviorSubject<ApiResponse<JDIResponse>>();
  StreamController _getRequestHistoryStreamCtrl =
      StreamController<List<TransactionHistoryModel>>();
  Stream<List<TransactionHistoryModel>> get getRequestHistoryStream =>
      _getRequestHistoryStreamCtrl.stream;

  getRequestHistory(int pageIndex, int pageSize) {
    ApiService(ApiConstants.TRANSACTION_HIS,
        {"Type": 1, "PageIndex": pageIndex, "PageSize": pageSize}, _subject)
        .execute();
  }
  initListener(BuildContext context) {
    _subject.listen((response) {
      if (response != null && response.status == Status.SUCCESS) {
        JDIResponse jdiResponse = response.data;
        if (jdiResponse != null) {
          if (jdiResponse.ErrorCode == AppConstants.ERROR_CODE_SUCCESS) {
            List<TransactionHistoryModel> result =
                jdiResponse.Data.map((e) => TransactionHistoryModel.fromJson(e))
                    .toList();
            _getRequestHistoryStreamCtrl.sink.add(result);
          } else {
            Utilities.showToast(
                context, jdiResponse.ErrorMessage ?? jdiResponse.ErrorCode);
          }
        } else {
          Utilities.showToast(context, "Không có dữ liệu");
        }
      } else {

      }
    });
  }

  @override
  void dispose() {
    _getRequestHistoryStreamCtrl.close();
  }
}
