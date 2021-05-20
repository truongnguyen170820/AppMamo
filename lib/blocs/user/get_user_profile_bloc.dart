import 'dart:async';
import 'package:mamo/api/api_constants.dart';
import 'package:mamo/api/api_response.dart';
import 'package:mamo/api/api_service.dart';
import 'package:mamo/blocs/impl/bloc.dart';
import 'package:mamo/model/request/base_response.dart';
import 'package:mamo/model/user/user_profile_model.dart';
import 'package:mamo/utils/app_constant.dart';
import 'package:mamo/utils/utilities.dart';
import 'package:flutter/cupertino.dart';

class GetUserProfileBloc implements Bloc {
  StreamController _getProfileStreamCtrl = StreamController<UserProfileModel>();
  Stream<UserProfileModel> get getProfileStream => _getProfileStreamCtrl.stream;

  getProfile(BuildContext context) {
    ApiService(ApiConstants.GET_PROFILE, {}, null)
        .getResponse()
        .then((response) {
      if (response != null && response.status == Status.SUCCESS) {
        JDIResponse jdiResponse = response.data;
        if (jdiResponse != null) {
          if (jdiResponse.ErrorCode == AppConstants.ERROR_CODE_SUCCESS) {
            List<UserProfileModel> result =
                jdiResponse.Data.map((e) => UserProfileModel.fromJson(e))
                    .toList();
            if (result != null && result.length > 0) {
              _getProfileStreamCtrl.sink.add(result[0]);
            }
          } else {
            Utilities.showToast(
                context, jdiResponse.ErrorMessage ?? jdiResponse.ErrorCode);
          }
        } else {
          Utilities.showToast(context, "Không có dữ liệu");
        }
      } else {

      }
    });
  }

  @override
  void dispose() {
    _getProfileStreamCtrl.close();
  }
}
