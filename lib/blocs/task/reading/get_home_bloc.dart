import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mamo/api/api_constants.dart';
import 'package:mamo/api/api_response.dart';
import 'package:mamo/api/api_service.dart';
import 'package:mamo/blocs/impl/base_list_bloc.dart';
import 'package:mamo/blocs/impl/bloc.dart';
import 'package:mamo/blocs/impl/event_type.dart';
import 'package:mamo/blocs/impl/stream_event.dart';
import 'package:mamo/model/request/base_response.dart';
import 'package:mamo/model/user/home_statistic_model.dart';
import 'package:mamo/utils/app_constant.dart';
import 'package:rxdart/rxdart.dart';

// class GetHomeBloc extends BaseListBlock<HomeStatisticModel>  implements Bloc {
//
//   StreamController<StreamEvent<HomeStatisticModel>> _eventControllers =
//   StreamController.broadcast();
//
//   Stream<StreamEvent<HomeStatisticModel>> get getEventStream =>
//       _eventControllers.stream;
//
//   Subject requestListHistoryBooking =
//   BehaviorSubject<ApiResponse<JDIResponse>>();
//
//   requestListener() {
//     requestListHistoryBooking.listen((data) {
//       if (data.status == Status.SUCCESS) {
//         requestFinished();
//
//         JDIResponse response = data.data;
//         if (response != null && response.ErrorCode == "000000") {
//           List<HomeStatisticModel> result =
//           response.Data.map((e) => HomeStatisticModel.fromJson(e)).toList();
//           setList(result, AppConstants.PAGE_SIZE);
//           increasePage();
//           _eventControllers.sink
//               .add(StreamEvent(eventType: StreamEventType.Loaded, data: result));
//         } else {
//           var error = "";
//           if (response != null && response.ErrorMessage != null)
//             error = response.ErrorMessage != null
//                 ? response.ErrorMessage
//                 : response.ErrorCode;
//           _eventControllers.sink.add(
//               StreamEvent(eventType: StreamEventType.Error, message: error));
//         }
//       } else if (data.status == Status.LOADING) {
//         _eventControllers.sink.add(StreamEvent(
//           eventType: StreamEventType.Loading,
//         ));
//       } else {
//         requestFinished();
//         _eventControllers.sink.add(StreamEvent(
//             eventType: StreamEventType.Error,
//             message: "Có lỗi khi lấy dữ liệu"));
//       }
//     });
//   }
//
//   getHome(
//       {bool isRefresh = false}) {
//     if (isRequesting()) return;
//     if (isRefresh) refreshPage();
//     // var data = Map<String, dynamic>();
//     // data["DepartmentIdStr"] =
//     //     AppCache().memberData.departmentDefaultInfo.departmentIdStr;
//     // data["PageIndex"] = pageIndex;
//     // data["PageSize"] = AppConstants.PAGE_SIZE;
//     requestStarted();
//     ApiService(
//         ApiConstants.GET_HOME_STATISTIC,{}, requestListHistoryBooking)
//         .execute();
//   }
//   @override
//   void dispose() {
//     _eventControllers.close();
//     requestListHistoryBooking.close();
//     // TODO: implement dispose
//   }
// }
//

class HomeBloc extends BaseListBlock<HomeStatisticModel> implements Bloc {

  StreamController<StreamEvent<HomeStatisticModel>> _getHomeStream = StreamController.broadcast();

  Stream<StreamEvent<HomeStatisticModel>> get getHomeStream => _getHomeStream.stream;
  getHomeList({bool isRefresh = false}) {
    if (isRefresh) refreshPage();
    requestStarted();
    ApiService(
        ApiConstants.GET_HOME_STATISTIC,
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
          List<HomeStatisticModel> data = response.Data.map((e) => HomeStatisticModel.fromJson(e)).toList();
          //todo
          setList(data, AppConstants.PAGE_SIZE);
          increasePage();

          _getHomeStream.sink
              .add(StreamEvent(eventType: StreamEventType.Loaded));
        } else {
          if (response != null)
            error = response.ErrorMessage.isNotEmpty
                ? response.ErrorMessage
                : response.ErrorCode;
          _getHomeStream.sink.add(
              StreamEvent(eventType: StreamEventType.Error, message: error));
        }
      } else if (data.status == Status.LOADING) {
        _getHomeStream.sink.add(StreamEvent(
          eventType: StreamEventType.Loading,
        ));
      } else {
        if (data != null)
          error = response.ErrorMessage.isNotEmpty
              ? response.ErrorMessage
              : response.ErrorCode;
        _getHomeStream.sink
            .add(StreamEvent(eventType: StreamEventType.Error, message: error));
      }
    });
  }

  @override
  void dispose() {
    _getHomeStream.close();
  }
}
