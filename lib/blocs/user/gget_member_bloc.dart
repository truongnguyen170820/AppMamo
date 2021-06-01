

import 'dart:async';

import 'package:mamo/api/api_constants.dart';
import 'package:mamo/api/api_response.dart';
import 'package:mamo/api/api_service.dart';
import 'package:mamo/blocs/impl/base_list_bloc.dart';
import 'package:mamo/blocs/impl/bloc.dart';
import 'package:mamo/blocs/impl/event_type.dart';
import 'package:mamo/blocs/impl/stream_event.dart';
import 'package:mamo/model/request/base_response.dart';
import 'package:mamo/model/user/my_member_model.dart';
import 'package:mamo/utils/app_constant.dart';
import 'package:rxdart/rxdart.dart';

class GetMemberBloc extends BaseListBlock<MyMemberModel> implements Bloc{
  StreamController<StreamEvent<MyMemberModel>> _eventControllers =
  StreamController.broadcast();

  Stream<StreamEvent<MyMemberModel>> get getEventStream =>
      _eventControllers.stream;

  Subject _subjectMember =
  BehaviorSubject<ApiResponse<JDIResponse>>();

  requestListener() {
    _subjectMember.listen((data) {
      if (data.status == Status.SUCCESS) {
        requestFinished();

        JDIResponse response = data.data;
        if (response != null && response.ErrorCode == "000000") {
          List<MyMemberModel> result =
          response.Data.map((e) => MyMemberModel.fromJson(e)).toList();
          setList(result, AppConstants.PAGE_SIZE);
          increasePage();
          _eventControllers.sink
              .add(StreamEvent(eventType: StreamEventType.Loaded, data: result));
        } else {
          var error = "";
          if (response != null && response.ErrorMessage != null)
            error = response.ErrorMessage != null
                ? response.ErrorMessage
                : response.ErrorCode;
          _eventControllers.sink.add(
              StreamEvent(eventType: StreamEventType.Error, message: error));
        }
      }
      else if (data.status == Status.LOADING) {
        _eventControllers.sink.add(StreamEvent(
          eventType: StreamEventType.Loading,
        ));
      }
      else {
        requestFinished();

        _eventControllers.sink.add(StreamEvent(
            eventType: StreamEventType.Error,
            message: "Có lỗi khi lấy dữ liệu"));
      }
    });
  }
  getListHistoryBooking({bool isRefresh = false}) {
    if (isRequesting()) return;
    if (isRefresh) refreshPage();
    requestStarted();
    ApiService(
        ApiConstants.GET_MY_MEMBER,
      {"PageIndex": pageIndex, "PageSize": AppConstants.PAGE_SIZE,
    }, _subjectMember)
        .execute();
    // requestFinished();
  }
  @override
  void dispose() {
    _eventControllers.close();
    _subjectMember.close();
    // TODO: implement dispose
  }

}