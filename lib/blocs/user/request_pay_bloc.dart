import 'package:mamo/api/api_constants.dart';
import 'package:mamo/api/api_response.dart';
import 'package:mamo/api/api_service.dart';
import 'package:mamo/blocs/impl/api_result_listener.dart';
import 'package:mamo/model/request/base_response.dart';
import 'package:rxdart/subjects.dart';

class RequestPayBloc {
  ApiResultListener _listener;
  final response = BehaviorSubject<ApiResponse<JDIResponse>>();

  requestPay(
      {int amount,
      String dayRequest,
      int payType,
      String telcoName,
      }) {
    ApiService(
            ApiConstants.REQUEST_PAY,
            {
              "Amount": amount,
              "DateStr": dayRequest,
              "PayType": payType,
              "TelcoName": telcoName,
            },
            response)
        .execute();
  }

  void init(ApiResultListener impl) {
    _listener = impl;
    response.listen((data) {
      if (data == null || data.status == Status.LOADING) {
        // _listener.onRequesting();
      } else if (data.status == Status.SUCCESS) {
        JDIResponse response = data.data;
        if (response != null) {
          if (response.ErrorCode == "000000") {
            List<dynamic> result =
                response.Data.map((e) => JDIResponse.fromJson(e)).toList();
            _listener.onSuccess(result);
          } else {
            _listener.onError(response.ErrorMessage ?? response.ErrorCode);
          }
        } else {
          _listener.onError("Có lỗi xảy ra");
        }
      } else {
        _listener.onError("Có lỗi xảy ra");
      }
    });
  }

  dispose() {
    response.close();
  }
}
