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
import 'package:mamo/model/user/recent_reward_model.dart';
import 'package:mamo/utils/app_constant.dart';

class ReadersBloc extends BaseListBlock<RecentReward> implements Bloc {

  StreamController<StreamEvent<RecentReward>> _getReadersStream = StreamController.broadcast();

  Stream<StreamEvent<RecentReward>> get getReaderStream => _getReadersStream.stream;
  getReaderList({bool isRefresh = false}) {
    if (isRefresh) refreshPage();
    requestStarted();
    ApiService(
        ApiConstants.GET_RECENT_REWARDS,
        {
          // "PageIndex": pageIndex,
          // "PageSize": AppConstants.PAGE_SIZE
        },
        null)
        .getResponse()
        .then((data) {
      requestFinished(); //todo
      var error = "Có lỗi khi lấy dữ liệu";
      JDIResponse response = data.data;
      if (data.status == Status.SUCCESS) {
        if (response != null && response.ErrorCode == "000000") {
          List<RecentReward> data = response.Data.map((e) => RecentReward.fromJson(e)).toList();
          //todo
          setList(data, AppConstants.PAGE_SIZE);
          increasePage();

          _getReadersStream.sink
              .add(StreamEvent(eventType: StreamEventType.Loaded));
        } else {
          if (response != null)
            error = response.ErrorMessage.isNotEmpty
                ? response.ErrorMessage
                : response.ErrorCode;
          _getReadersStream.sink.add(
              StreamEvent(eventType: StreamEventType.Error, message: error));
        }
      } else if (data.status == Status.LOADING) {
        _getReadersStream.sink.add(StreamEvent(
          eventType: StreamEventType.Loading,
        ));
      } else {
        if (data != null)
          error = response.ErrorMessage.isNotEmpty
              ? response.ErrorMessage
              : response.ErrorCode;
        _getReadersStream.sink
            .add(StreamEvent(eventType: StreamEventType.Error, message: error));
      }
    });
  }

  @override
  void dispose() {
    _getReadersStream.close();
  }
}
