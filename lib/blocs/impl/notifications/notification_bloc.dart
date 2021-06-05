import 'dart:async';
import 'package:mamo/api/api_constants.dart';
import 'package:mamo/api/api_response.dart';
import 'package:mamo/api/api_service.dart';
import 'package:mamo/blocs/impl/bloc.dart';
import 'package:mamo/model/notification/notification_model.dart';
import 'package:mamo/model/request/base_response.dart';
import 'package:mamo/utils/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:mamo/utils/utilities.dart';
import 'package:rxdart/subjects.dart';

class NotificationBloc implements Bloc {
  Subject _subject = BehaviorSubject<ApiResponse<JDIResponse>>();
  StreamController _getNotificationStreamCtrl =
      StreamController<List<NotificationModel>>();
  Stream<List<NotificationModel>> get getNotificationStream =>
      _getNotificationStreamCtrl.stream;

  getNotification(int type, int pageIndex, int pageSize) {
    ApiService(
        ApiConstants.GET_NOTIFY,
        {"Type": type, "PageIndex": pageIndex, "PageSize": pageSize},
        _subject).execute();
  }
  initListener(BuildContext context) {
    _subject.listen((response) {
      if (response != null && response.status == Status.SUCCESS) {
        JDIResponse jdiResponse = response.data;
        if (jdiResponse != null) {
          if (jdiResponse.ErrorCode == AppConstants.ERROR_CODE_SUCCESS) {
            List<NotificationModel> result =
                jdiResponse.Data.map((e) => NotificationModel.fromJson(e))
                    .toList();
              _getNotificationStreamCtrl.sink.add(result);
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
    _getNotificationStreamCtrl.close();
  }
}
