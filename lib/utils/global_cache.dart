
import 'package:mamo/model/user/user_login_model.dart';


class GlobalCache {
  static GlobalCache _instance;


  factory GlobalCache() => _instance ??= new GlobalCache._();
  GlobalCache._();
  String userPassword;
  String errorMessage;

  UserLogInModel loginData;
  UserLogInModel getUser() {
    return loginData;
  }

  void setData(UserLogInModel _user) {
    this.loginData = _user;
  }
}
