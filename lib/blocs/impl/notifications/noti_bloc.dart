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
import 'package:mamo/model/user/my_member_model.dart';
import 'package:mamo/model/user/recent_reward_model.dart';
import 'package:mamo/utils/app_constant.dart';

class NotifiBloc extends BaseListBlock<NotificationModel> implements Bloc {

  StreamController<StreamEvent<NotificationModel>> notifiCtrl = StreamController.broadcast();

  Stream<StreamEvent<NotificationModel>> get getNotifiStream => notifiCtrl.stream;
  getNotification(int type,{bool isRefresh = false}) {
    if (isRefresh) refreshPage();
    requestStarted();
    ApiService(
        ApiConstants.GET_NOTIFY,
        {
          "Type": type,
          "PageIndex": pageIndex,
          "PageSize": AppConstants.PAGE_SIZE
        },
        null)
        .getResponse()
        .then((data) {
      requestFinished(); //todo
      var error = "Có lỗi khi lấy dữ liệu";
      JDIResponse response = data.data;
      if (data.status == Status.SUCCESS) {
        if (response != null && response.ErrorCode == "000000") {
          List<NotificationModel> data = response.Data.map((e) => NotificationModel.fromJson(e)).toList();
          //todo
          setList(data, AppConstants.PAGE_SIZE);
          increasePage();

          notifiCtrl.sink
              .add(StreamEvent(eventType: StreamEventType.Loaded));
        } else {
          if (response != null)
            error = response.ErrorMessage.isNotEmpty
                ? response.ErrorMessage
                : response.ErrorCode;
          notifiCtrl.sink.add(
              StreamEvent(eventType: StreamEventType.Error, message: error));
        }
      } else if (data.status == Status.LOADING) {
        notifiCtrl.sink.add(StreamEvent(
          eventType: StreamEventType.Loading,
        ));
      } else {
        if (data != null)
          error = response.ErrorMessage.isNotEmpty
              ? response.ErrorMessage
              : response.ErrorCode;
        notifiCtrl.sink
            .add(StreamEvent(eventType: StreamEventType.Error, message: error));
      }
    });
  }

  @override
  void dispose() {
    notifiCtrl.close();
  }
}
