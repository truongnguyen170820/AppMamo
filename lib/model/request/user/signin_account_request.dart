import '../base_request.dart';

class SigninAccountRequest extends BaseRequest {
  String userName;
  String passWord;
  String appName;
  String deviceId;
  // String versionId;

  SigninAccountRequest(this.userName, this.passWord,this.appName, this.deviceId);

  Map<String, String> toMap() {
    Map<String, String> map = new Map();
    map["UserName"] = userName;
    map["Password"] = passWord;
    map["AppName"] = appName;
    map["DeviceId"] = deviceId;

    return map;
  }
}