import 'dart:async';

import 'package:mamo/api/api_constants.dart';
import 'package:mamo/api/api_response.dart';
import 'package:mamo/api/api_service.dart';
import 'package:mamo/blocs/impl/base_list_bloc.dart';
import 'package:mamo/blocs/impl/bloc.dart';
import 'package:mamo/blocs/impl/event_type.dart';
import 'package:mamo/blocs/impl/stream_event.dart';
import 'package:mamo/model/notification/notification_model.dart';
import 'package:mamo/model/request/base_response.dart';
import 'package:mamo/utils/app_constant.dart';
import 'package:rxdart/rxdart.dart';

class NotificationBloc1 extends BaseListBlock<NotificationModel> implements Bloc {
  Subject _subject = BehaviorSubject<ApiResponse<JDIResponse>>();
  StreamController _getNotifiStreamCtrl =
  StreamController<StreamEvent<NotificationModel>>();
  Stream<StreamEvent<NotificationModel>> get getNotificationStream =>
      _getNotifiStreamCtrl.stream;

  getNotification(int type,  {bool isRefresh = false}) {
    if (isRequesting()) return;
    if (isRefresh) refreshPage();
    requestStarted();
    ApiService(
        ApiConstants.GET_NOTIFY,
        {"Type": type, "PageIndex": pageIndex, "PageSize": AppConstants.PAGE_SIZE},
        _subject).execute();
  }

  requestListener() {
    _subject.listen((data) {
      if (data.status == Status.SUCCESS) {
        requestFinished();

        JDIResponse response = data.data;
        if (response != null && response.ErrorCode == "000000") {
          List<NotificationModel> result =
          response.Data.map((e) => NotificationModel.fromJson(e)).toList();
          setList(result, AppConstants.PAGE_SIZE);
          increasePage();
          _getNotifiStreamCtrl.sink
              .add(StreamEvent(eventType: StreamEventType.Loaded, data: result));
        } else {
          var error = "";
          if (response != null && response.ErrorMessage != null)
            error = response.ErrorMessage != null
                ? response.ErrorMessage
                : response.ErrorCode;
          _getNotifiStreamCtrl.sink.add(
              StreamEvent(eventType: StreamEventType.Error, message: error));
        }
      } else if (data.status == Status.LOADING) {
        _getNotifiStreamCtrl.sink.add(StreamEvent(
          eventType: StreamEventType.Loading,
        ));
      } else {
        requestFinished();
        _getNotifiStreamCtrl.sink.add(StreamEvent(
            eventType: StreamEventType.Error,
            message: "Có lỗi khi lấy dữ liệu"));
      }
    });
  }



  @override
  void dispose() {
    _getNotifiStreamCtrl.close();
    _subject.close();
    // TODO: implement dispose
  }

}