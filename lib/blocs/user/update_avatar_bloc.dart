import 'package:mamo/api/api_constants.dart';
import 'package:mamo/api/api_response.dart';
import 'package:mamo/api/api_service.dart';
import 'package:mamo/blocs/impl/api_result_listener.dart';
import 'package:mamo/blocs/impl/bloc.dart';
import 'package:mamo/model/request/base_response.dart';
import 'package:rxdart/rxdart.dart';


class ChangeAvatarBloc implements Bloc {
  final _subjectChangeAvatar = BehaviorSubject<ApiResponse<JDIResponse>>();
  ApiResultListener apiResultListener;

  void setListener(ApiResultListener listener) {
    apiResultListener = listener;
  }

  updateAvatar(String imgPath) {
    apiResultListener.onRequesting();
    ApiService(ApiConstants.UPDATE_IMAGE, {"AvatarUrl": imgPath},
            _subjectChangeAvatar)
        .getResponse()
        .then((data) {
      if (data.status == Status.SUCCESS) {
        JDIResponse response = data.data;
        if (response != null && response.ErrorCode == "000000") {
          apiResultListener.onSuccess(null);
        } else {
          apiResultListener.onError("Cập nhật hình đại diện thất bại");
        }
      } else {
        apiResultListener.onError("Cập nhật hình đại diện thất bại");
      }
    });
  }

  @override
  void dispose() {
    _subjectChangeAvatar.close();
  }
}
