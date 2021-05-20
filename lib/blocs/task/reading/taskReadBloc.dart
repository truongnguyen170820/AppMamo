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
import 'package:mamo/model/user/task_model.dart';
import 'package:mamo/utils/app_constant.dart';
import 'package:mamo/utils/global_cache.dart';
import 'package:mamo/widget/global.dart';
import 'package:rxdart/rxdart.dart';

class TaskReadBloc extends BaseListBlock<TaskModel> implements Bloc{
  StreamController<List<TaskModel>> _eventTaskCtrl =
  StreamController<List<TaskModel>>();

  Stream<List<TaskModel>> get getEventStream =>
      _eventTaskCtrl.stream;

  Subject requestListTaskModel =
  BehaviorSubject<ApiResponse<JDIResponse>>();

  getTaskModel (int type, {bool isRefresh = false}){
    if (isRequesting()) return;
    if (isRefresh) refreshPage();
    ApiService(ApiConstants.GET_TASK,
    {"Type": type}, requestListTaskModel
    ).execute();
  }

  init(){
    requestListTaskModel.listen((data) {
      if(data.status == Status.SUCCESS){
        JDIResponse response = data.data;
        if(response != null && response.ErrorCode == "000000"){
          List<TaskModel> result =
              response.Data.map((e) => TaskModel.fromJson(e)).toList();
          if(result.length == 0){
            GlobalCache().errorMessage = response.ErrorMessage;
          }
          // setList(result, AppConstants.PAGE_SIZE);
          increasePage();
          _eventTaskCtrl.sink.add(result);
        }else{
          // var error = "";
          // if(response != null && response.ErrorMessage != null)
          //   error = response.ErrorMessage != null ?
          //       response.ErrorMessage :
          //       response.ErrorCode;
          // _eventTaskCtrl.sink.add(error);
        }
      }else if(data.status == Status.LOADING){
        // _eventTaskCtrl.sink.add(StreamEvent(eventType: StreamEventType.Loading));
      }else{
        requestFinished();
        // _eventTaskCtrl.sink.add(StreamEvent(
        //     eventType: StreamEventType.Error,
        //     message: "Có lỗi khi lấy dữ liệu"
        // ));
      }

    });
  }



  @override
  void dispose() {
    _eventTaskCtrl.close();
    requestListTaskModel.close();
    // TODO: implement dispose
  }

}