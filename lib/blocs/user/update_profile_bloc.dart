import 'package:mamo/api/api_constants.dart';
import 'package:mamo/api/api_response.dart';
import 'package:mamo/api/api_service.dart';
import 'package:mamo/blocs/impl/api_result_listener.dart';
import 'package:mamo/model/request/base_response.dart';
import 'package:mamo/model/user/update_profile_request.dart';
import 'package:rxdart/subjects.dart';
import '../impl/bloc.dart';

class UpdateProfileBloc implements Bloc {
  ApiResultListener _updateProfileImpl;
  final _subjectUpdateProfile = BehaviorSubject<ApiResponse<JDIResponse>>();

  onUpdateProfile(String fullName, String address, String gender,
      String birthDay, String email, String momoMoblie, String momoName) {
    if (fullName.length > 23) fullName = fullName.substring(0, 23);
    ApiService(
            ApiConstants.UPDATE_PROFILE,
            UpdateProfileRequest(fullName, address, gender, birthDay, email,
                    momoMoblie, momoName)
                .toJson(),
            _subjectUpdateProfile)
        .execute();
  }

  void onUpdateProfileListen(ApiResultListener impl) {
    _updateProfileImpl = impl;
    _subjectUpdateProfile.listen((data) {
      if (data == null || data.status == Status.LOADING) {
        // _signinAccountImpl.onSigninAccountRequesting();
      } else if (data.status == Status.SUCCESS) {
        JDIResponse response = data.data;
        if (response != null) {
          if (response.ErrorCode == "000000") {
            List<dynamic> result =
                response.Data.map((e) => JDIResponse.fromJson(e)).toList();
            _updateProfileImpl.onSuccess(result);
          } else {
            _updateProfileImpl
                .onError(response.ErrorMessage ?? response.ErrorCode);
          }
        } else {
          _updateProfileImpl.onError('Có lỗi xảy ra.');
        }
      } else {
        _updateProfileImpl.onError("Có lỗi xảy ra.");
      }
    });
  }

  @override
  void dispose() {
    _subjectUpdateProfile.close();
  }
}
