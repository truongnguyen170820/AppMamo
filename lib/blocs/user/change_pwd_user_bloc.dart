import 'package:mamo/api/api_constants.dart';
import 'package:mamo/api/api_response.dart';
import 'package:mamo/api/api_service.dart';
import 'package:mamo/blocs/impl/api_result_listener.dart';
import 'package:mamo/model/request/base_response.dart';
import 'package:mamo/model/request/user/change_pwd_user_request.dart';
import 'package:rxdart/subjects.dart';

class ChangePwdUserBloc {
  ApiResultListener _listener;
  final response = BehaviorSubject<ApiResponse<JDIResponse>>();

  executeChangePwd(String oldPwd, String newPwd) {
    ApiService(ApiConstants.CHANGE_PWD_USER,
            ChangePwdRequest(oldPwd, newPwd).toMap(), response)
        .execute();
  }

  void onChangePwdListen(ApiResultListener impl) {
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
            _listener.onError(response.ErrorMessage);
          }
        } else {
          _listener.onError("Có lỗi xảy ra, kiểm tra lại kết nối.");
        }
      } else {
        _listener.onError("Có lỗi xảy ra, kiểm tra lại kết nối.");
      }
    });
  }

  disposeChangePwdSubject() {
    response.close();
  }
}
