import 'package:mamo/api/api_constants.dart';
import 'package:mamo/api/api_response.dart';
import 'package:mamo/api/api_service.dart';
import 'package:mamo/blocs/impl/api_result_listener.dart';
import 'package:mamo/blocs/impl/bloc.dart';
import 'package:mamo/model/request/base_response.dart';
import 'package:mamo/model/request/user/signin_account_request.dart';
import 'package:mamo/model/user/user_login_model.dart';
import 'package:mamo/utils/global_cache.dart';
import 'package:rxdart/subjects.dart';
import '../impl/bloc.dart';

class AuthenBloc implements Bloc {
  SignInListener _signinAccountImpl;
  final _subjectSigninAccount = BehaviorSubject<ApiResponse<JDIResponse>>();
  // final _subjectAuthenData = BehaviorSubject<ApiResponse<UserLogInModel>>();

  executeSigninAccount(String user, String pass, String appname, {String deviceId}) {
    final request = SigninAccountRequest(user, pass, appname, deviceId);
    ApiService(
            ApiConstants.SIGNIN_ACCOUNT, request.toMap(), _subjectSigninAccount)
        .execute();
  }

  // BehaviorSubject<ApiResponse<UserLogInModel>> get subjectAuthenData =>
  //     _subjectAuthenData;

  void onSigninAccountListen(SignInListener impl) {
    _signinAccountImpl = impl;
    _subjectSigninAccount.listen((data) {
      if (data == null || data.status == Status.LOADING) {
        // _signinAccountImpl.onSigninAccountRequesting();
      } else if (data.status == Status.SUCCESS) {
        JDIResponse response = data.data;
        if (response != null) {
          if (response.ErrorCode == "000000") {
            List<UserLogInModel> result =
                response.Data.map((e) => UserLogInModel.fromJson(e)).toList();
            //thiết lập cache thông tin cơ bản của member
            GlobalCache().setData(result.first);
            // Hive.box(AppConstants.HIVE_USER_BOX).put(
            //     AppConstants.HIVE_MEMBER_DATA, jsonEncode(result[0].toJson()));
            _signinAccountImpl.onSuccess(result);
          } else {
            //todo onNeedUpdateApp
            if (response.ErrorCode == "10101"){
              _signinAccountImpl.onNeedUpdate();
            } else
            _signinAccountImpl.onError(response.ErrorMessage??response.ErrorCode);
          }
        } else {
          _signinAccountImpl.onError("Có lỗi xảy ra");
        }
      } else {
        _signinAccountImpl.onError("Có lỗi xảy ra");
      }
    });
  }

  // loadData() async {
  //   final data =
  //       Hive.box(AppConstants.HIVE_USER_BOX).get(AppConstants.HIVE_MEMBER_DATA);
  //   if (data == null) {
  //     _subjectAuthenData.sink
  //         .add(ApiResponse<UserLogInModel>(Status.SUCCESS, null, null));
  //     return;
  //   } else {
  //     final memberData = UserLogInModel.fromJson(jsonDecode(data));
  //     GlobalCache().setData(memberData);
  //     _subjectAuthenData.sink
  //         .add(ApiResponse<UserLogInModel>(Status.SUCCESS, memberData, null));
  //     return;
  //   }
  // }

  @override
  void dispose() {
    // _subjectAuthenData.close();
    _subjectSigninAccount.close();
  }
}
