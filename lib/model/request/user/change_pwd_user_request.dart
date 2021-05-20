import '../base_request.dart';

class ChangePwdRequest extends BaseRequest {
  String oldPwd;
  String newPwd;

  ChangePwdRequest(this.oldPwd, this.newPwd);

  Map<String, String> toMap() {
    Map<String, String> map = new Map();
    map["Password"] = oldPwd;
    map["NewPassword"] = newPwd;
    return map;
  }
}