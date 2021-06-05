import 'dart:convert';
import 'package:mamo/api/api_constants.dart';
import 'package:mamo/api/api_response.dart';
import 'package:mamo/api/api_service.dart';
import 'package:mamo/blocs/impl/bloc.dart';
import 'package:mamo/model/notification/device_model.dart';
import 'package:mamo/model/request/base_response.dart';
import 'package:mamo/utils/app_constant.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManageDeviceBloc implements Bloc {
  Subject _updateTokenSbj = BehaviorSubject<ApiResponse<JDIResponse>>();
  SharedPreferences prefs;

  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    _updateTokenSbj.close();
  }

  sendDeviceID(DeviceIDModel deviceID) {
    _updateTokenSbj.listen((data) {
      if (data == null || data.status == Status.LOADING) {
      } else if (data.status == Status.SUCCESS) {
        JDIResponse response = data.data;
        if (response != null &&
            response.ErrorCode == AppConstants.API_UPDATE_DEVICE_SUCCESS) {
          prefs.setString(
              AppConstants.PREF_DEVICE_ID, json.encode(deviceID.toJson()));
        } else {
          // String a=  response.ErrorCode;
          // String b = response.ErrorMessage;
        }
      } else {
        // String a="";
      }
    });
    ApiService(ApiConstants.UPDATE_DEVICE_ID, deviceID.toJson(),
            _updateTokenSbj)
        .execute();
  }

  checkIDSaved(double lat, double long, String token, int platformOS) {
    if (token != null && token.isNotEmpty) {
      String storeToken = prefs.get(AppConstants.PREF_DEVICE_TOKEN);
      if (storeToken != null && storeToken.isNotEmpty) {
        var tokenInfo = DeviceIDModel.fromJson(json.decode(storeToken));
        if (tokenInfo.devicePushId != token) {
          prefs.remove(AppConstants.PREF_DEVICE_ID);
          sendDeviceID(DeviceIDModel(lat, long, token, platformOS));
        }
      } else {
        sendDeviceID(DeviceIDModel(lat, long, token, platformOS));
      }
    }
  }
}
