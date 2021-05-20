import 'dart:async';
import 'package:mamo/api/api_constants.dart';
import 'package:mamo/api/api_response.dart';
import 'package:mamo/api/api_service.dart';
import 'package:mamo/blocs/impl/bloc.dart';
import 'package:mamo/model/request/base_response.dart';
import 'package:mamo/model/user/my_member_model.dart';
import 'package:mamo/utils/app_constant.dart';
import 'package:mamo/utils/utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class MyMemberBloc implements Bloc {
  Subject _subject = BehaviorSubject<ApiResponse<JDIResponse>>();
  StreamController _getMyMemberStreamCtrl =
      StreamController<List<MyMemberModel>>();
  Stream<List<MyMemberModel>> get getMyMemberStream =>
      _getMyMemberStreamCtrl.stream;

  getMemberList( int pageIndex, int pageSize) {
    ApiService(
        ApiConstants.GET_MY_MEMBER,
        {"PageIndex": pageIndex, "PageSize": pageSize},
        _subject).execute();
  }
  init(BuildContext context) {
    _subject.listen((response) {
      if (response != null && response.status == Status.SUCCESS) {
        JDIResponse jdiResponse = response.data;
        if (jdiResponse != null) {
          if (jdiResponse.ErrorCode == AppConstants.ERROR_CODE_SUCCESS) {
            List<MyMemberModel> result =
                jdiResponse.Data.map((e) => MyMemberModel.fromJson(e)).toList();
            _getMyMemberStreamCtrl.sink.add(result);
          } else {
            Utilities.showToast(
                context, jdiResponse.ErrorMessage ?? jdiResponse.ErrorCode);
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _getMyMemberStreamCtrl.close();
  }
}
