import 'dart:async';
import 'package:mamo/api/api_constants.dart';
import 'package:mamo/api/api_response.dart';
import 'package:mamo/api/api_service.dart';
import 'package:mamo/blocs/impl/bloc.dart';
import 'package:mamo/model/request/base_response.dart';
import 'package:mamo/model/user/top_hunter_model.dart';
import 'package:mamo/utils/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:mamo/utils/utilities.dart';
import 'package:rxdart/subjects.dart';

class GetTopHunterBloc implements Bloc {
  Subject _subject = BehaviorSubject<ApiResponse<JDIResponse>>();
  StreamController _getTopHunterStreamCtrl =
      StreamController<List<TopHunterModel>>();
  Stream<List<TopHunterModel>> get getTopHunterStream =>
      _getTopHunterStreamCtrl.stream;

  getTopHunter(int type, String dateStr) {
    ApiService(ApiConstants.GET_TOP_HUNTER,
        {"Type": type, "DateStr": dateStr}, _subject)
        .execute();
  }
  initListener(BuildContext context) {
    _subject.listen((response) {
      if (response != null && response.status == Status.SUCCESS) {
        JDIResponse jdiResponse = response.data;
        if (jdiResponse != null) {
          if (jdiResponse.ErrorCode == AppConstants.ERROR_CODE_SUCCESS) {
            List<TopHunterModel> result =
                jdiResponse.Data.map((e) => TopHunterModel.fromJson(e))
                    .toList();
            _getTopHunterStreamCtrl.sink.add(result);
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
    _getTopHunterStreamCtrl.close();
  }
}
