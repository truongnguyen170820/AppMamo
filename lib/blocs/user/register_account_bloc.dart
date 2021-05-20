import 'package:mamo/api/api_constants.dart';
import 'package:mamo/api/api_response.dart';
import 'package:mamo/api/api_service.dart';
import 'package:mamo/blocs/impl/api_result_listener.dart';
import 'package:mamo/model/request/base_response.dart';
import 'package:rxdart/subjects.dart';

class RegisterAccountBloc {
  ApiResultListener _listener;
  final response = BehaviorSubject<ApiResponse<JDIResponse>>();

  registerAccount(String phoneNumber, String passWord, String name, {String deviceId}) {
    ApiService(
            ApiConstants.REGISTER,
            {
              "UserName": phoneNumber,
              "Password": passWord,
              "FullName": name,
              "DeviceId": deviceId,
              "AppName": "mamo"
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
            _listener.onError(response.ErrorMessage??response.ErrorCode);
          }
        } else {
          _listener.onError("Có lỗi xảy ra, kiểm tra lại kết nối");
        }
      } else {
        _listener.onError("Có lỗi xảy ra, kiểm tra lại kết nối");
      }
    });
  }

  dispose() {
    response.close();
  }
}
