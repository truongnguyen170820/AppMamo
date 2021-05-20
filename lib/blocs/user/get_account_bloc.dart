import 'dart:async';
import 'package:mamo/api/api_constants.dart';
import 'package:mamo/api/api_response.dart';
import 'package:mamo/api/api_service.dart';
import 'package:mamo/blocs/impl/bloc.dart';
import 'package:mamo/model/request/base_response.dart';
import 'package:mamo/model/user/user_login_model.dart';
import 'package:mamo/utils/app_constant.dart';
import 'package:mamo/utils/utilities.dart';
import 'package:flutter/cupertino.dart';

class GetAccountBloc implements Bloc {
  StreamController _getAccountStreamCtrl = StreamController<Account>();
  Stream<Account> get getAccountStream => _getAccountStreamCtrl.stream;

  getAccount(BuildContext context) {
    ApiService(ApiConstants.GET_ACCOUNT, {}, null)
        .getResponse()
        .then((response) {
      if (response == null || response.status == Status.LOADING) {
        // _listener.onRequesting();
      } else if (response.status == Status.SUCCESS) {
        JDIResponse jdiResponse = response.data;
        if (jdiResponse != null) {
          if (jdiResponse.ErrorCode == AppConstants.ERROR_CODE_SUCCESS) {
            List<Account> result =
                jdiResponse.Data.map((e) => Account.fromJson(e))
                    .toList();
            if (result != null && result.length > 0) {
              _getAccountStreamCtrl.sink.add(result[0]);
            }
          } else {
            Utilities.showToast(
                context, jdiResponse.ErrorMessage ?? jdiResponse.ErrorCode);
          }
        } else {
          Utilities.showToast(context, "Lỗi khi tải dữ liệu");
        }
      } else {
        Utilities.showToast(context, "Lỗi khi tải dữ liệu");
      }
    });
  }

  @override
  void dispose() {
    _getAccountStreamCtrl.close();
  }
}
