

import 'dart:async';

import 'package:mamo/api/api_constants.dart';
import 'package:mamo/api/api_response.dart';
import 'package:mamo/api/api_service.dart';
import 'package:mamo/blocs/impl/base_list_bloc.dart';
import 'package:mamo/blocs/impl/bloc.dart';
import 'package:mamo/blocs/impl/event_type.dart';
import 'package:mamo/blocs/impl/stream_event.dart';
import 'package:mamo/model/request/base_response.dart';
import 'package:mamo/model/user/transaction_history_model.dart';
import 'package:mamo/utils/app_constant.dart';
import 'package:rxdart/rxdart.dart';

class HistoryWithdrawalBloc extends BaseListBlock<TransactionHistoryModel>
implements Bloc{
  StreamController<StreamEvent<TransactionHistoryModel>> _eventWithDrawaCtrl = StreamController.broadcast();

  Stream<StreamEvent<TransactionHistoryModel>> get getEventStream =>
      _eventWithDrawaCtrl.stream;

  Subject requestListHistoryWithDrawa =
  BehaviorSubject<ApiResponse<JDIResponse>>();
  getWithdrawalHistory(int pageIndex, int pageSize) {
    ApiService(ApiConstants.TRANSACTION_HIS,
        {"Type": 3, "PageIndex": pageIndex, "PageSize": pageSize}, requestListHistoryWithDrawa)
        .execute();
  }
  init(){
    requestListHistoryWithDrawa.listen((data){
      if(data.status == Status.SUCCESS){
        JDIResponse response = data.data;
        if(response != null && response.ErrorCode =="000000"){
          List<TransactionHistoryModel> result =
          response.Data.map((e) => TransactionHistoryModel.fromJson(e)).toList();
          setList(result, AppConstants.PAGE_SIZE);
          increasePage();
          _eventWithDrawaCtrl.sink.add(StreamEvent(eventType: StreamEventType.Loaded));
        }else{
          var error = "";
          if(response != null && response.ErrorMessage != null)
            error = response.ErrorMessage != null ?
                response.ErrorMessage :
                response.ErrorCode;
          _eventWithDrawaCtrl.sink.add(StreamEvent(eventType: StreamEventType.Error, message: error));
        }
      }else if(data.status == Status.LOADING){
        _eventWithDrawaCtrl.sink.add(StreamEvent(
          eventType: StreamEventType.Loading,
        ));
      }else{
        requestFinished();

        _eventWithDrawaCtrl.sink.add(StreamEvent(
          eventType: StreamEventType.Error,
          message: "Có lỗi khi lấy dữ liệu"
        ));
      }
    });
  }


  @override
  void dispose() {
    _eventWithDrawaCtrl.close();
    requestListHistoryWithDrawa.close();
    // TODO: implement dispose
  }

}