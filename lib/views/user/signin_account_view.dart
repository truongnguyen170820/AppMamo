import "dart:io";
import 'package:mamo/blocs/impl/api_result_listener.dart';
import 'package:mamo/blocs/impl/notifications/manage_token_bloc.dart';
import 'package:mamo/blocs/user/authen_bloc.dart';
import 'package:mamo/utils/font_utils.dart';
import 'package:mamo/utils/global_cache.dart';
import 'package:mamo/views/user/register_account_view.dart';
import 'package:mamo/views/user/register_phone_number_view.dart';
import 'package:mamo/views/user/forgot_password_view.dart';
import 'package:mamo/widget/custombutton.dart';
import 'package:mamo/widget/global.dart';
import 'package:mamo/utils/text_styles.dart';
import 'package:mamo/utils/app_constant.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/utils/utilities.dart';
import 'package:mamo/views/main/main_view.dart';
import 'package:mamo/widget/notification_global.dart';
import 'package:mamo/widget/progress_dialog.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    as passwordStore;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class SigninAccountView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SigninAccountViewState();
}

class SigninAccountViewState extends State<SigninAccountView>
    with SignInListener {
  final storage = passwordStore.FlutterSecureStorage();
  final authenBloc = AuthenBloc();
  ProgressDialog progressDialog;
  final _accountController = TextEditingController();
  final _passController = TextEditingController();
  bool _isRememberMe = false;
  bool _isShowPassword = true;

  @override
  void initState() {
    super.initState();
    authenBloc.onSigninAccountListen(this);
    progressDialog = progDialog(context, message: "Đăng nhập...");
    storage.read(key: AppConstants.KEY_USER_NAME).then((value) {
      setState(() {
        if (value != null && value.isNotEmpty) _isRememberMe = true;
        _accountController.text = value;
      });
    });
    storage.read(key: AppConstants.KEY_PASSWORD).then((value) {
      setState(() {
        _passController.text = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: ColorUtils.WHITE),
          height: double.infinity,
          padding: EdgeInsets.only(left: setWidth(32), right: setWidth(32)),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: setWidth(70),
                      top: setHeight(100)),
                  child: Center(
                    child: Row(
                      children: [
                        Image.asset(
                          getAssetsImage("logo.png"),
                          width: setWidth(68),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: setHeight(40)),
                          child: Image.asset(
                            getAssetsImage("nameLogo.png"),
                            width: setWidth(100),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Text("Kiếm tiền mỗi ngày", style: FontUtils.MEDIUM.copyWith(color: ColorUtils.colorTextLogo, fontSize: setSp(16))),
                SizedBox(height: setHeight(76)),
                Container(
                  margin: EdgeInsets.only(bottom: setHeight(18)),
                  height: setHeight(45),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: ColorUtils.gray6),
                    borderRadius: BorderRadius.circular(6)
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    style: FontUtils.MEDIUM.copyWith(fontSize: setSp(15)),
                    controller: _accountController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ColorUtils.gray,
                      hintText: 'Nhập tên tài khoản',
                      hintStyle: TextStyles.hint,
                      prefixIcon: Icon(
                        Icons.person_outline,
                        size: 22,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 0),
                  height: setHeight(45),
                  decoration: BoxDecoration(
                    color: ColorUtils.gray,
                      border: Border.all(width: 2, color: ColorUtils.gray6),
                      borderRadius: BorderRadius.circular(6)
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: setWidth(16),),
                      Image.asset(getAssetsIcon("key.png"), width: setWidth(20),height: setHeight(20),),
                      Container(
                        width: setWidth(270),
                        child: TextField(
                          // textAlignVertical: TextAlignVertical.bottom,
                          style: FontUtils.MEDIUM.copyWith(fontSize: setSp(15)),
                          controller: _passController,
                          obscureText: _isShowPassword,
                          maxLengthEnforced: true,

                          decoration: InputDecoration(
                            filled: true,
                            fillColor: ColorUtils.gray,
                            hintText: 'Nhập mật khẩu',
                            hintStyle: TextStyles.hint,
                            suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    alignment: Alignment.centerRight,
                                    icon: Icon(
                                      Icons.cancel,
                                      size: 16,
                                      color: ColorUtils.gray6,
                                    ),
                                    onPressed: () => _passController.clear(),
                                  ),
                                  IconButton(
                                    alignment: Alignment.centerLeft,
                                    icon: Icon(
                                      _isShowPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      size: 18,
                                      color: ColorUtils.gray6,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isShowPassword = !_isShowPassword;
                                      });
                                    },
                                  ),
                                ]),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 0, bottom: setHeight(5)),
                  height: setHeight(45),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Checkbox(
                        value: _isRememberMe,
                        activeColor: ColorUtils.colorTextLogo,
                        checkColor: ColorUtils.WHITE,
                        onChanged: (bool newValue) {
                          setState(() {
                            _isRememberMe = newValue;
                          });
                        },
                      ),
                      Text(
                        'Lưu mật khẩu',
                        style:
                            FontUtils.MEDIUM.copyWith(color: ColorUtils.gray8),
                      ),
                    ],
                  ),
                ),
                ButtonCustom(
                  margin: EdgeInsets.only(top: setHeight(23)),
                  onTap: (){ signInAccount();},
                  height: setHeight(42),
                  width: setWidth(200),
                  title: "Đăng nhập",
                  textStyle: FontUtils.MEDIUM.copyWith(color: ColorUtils.WHITE),
                  borderRadius: 12,
                ),
                SizedBox(height: setHeight(32)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          'Quên mật khẩu?',
                          style: TextStyle(
                              color: ColorUtils.colorTextLogo),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPasswordView()));
                      },
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          'Chưa có tài khoản?',
                          style: TextStyle(
                              color: ColorUtils.colorTextLogo),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterAccountView()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }


  void signInAccount() async {
    if (_accountController.text == '') {
      Utilities.showToast(context, 'Bạn chưa nhập tài khoản');
      return;
    }
    if (_passController.text == '') {
      Utilities.showToast(context, 'Bạn chưa nhập mật khẩu');
      return;
    }
    // String deviceId = await "fb3393177ee13e7uc";
    String deviceId = await _getId();

    // print("deviceId: " + deviceId);
    progressDialog.show().whenComplete(() => authenBloc.executeSigninAccount(
          _accountController.text,
          _passController.text,
          'mamo',
          // //todo đổi lại deviceID thật sau khi test
          deviceId: deviceId,
          // // "deviceIdtest",
          // "1.1.2"
        ));
    //todo cập nhật phiên bản hiện tại
  }

  @override
  void dispose() {
    authenBloc.dispose();
    _passController.dispose();
    _accountController.dispose();
    super.dispose();
  }

  @override
  void onError(String message) async {
    await progressDialog.hide();
    Utilities.showToast(context, message);
  }

  @override
  void onSuccess(List response) async {
    await progressDialog.hide();
    if (_isRememberMe) {
      storage.write(
          key: AppConstants.KEY_USER_NAME, value: _accountController.text);
      storage.write(
          key: AppConstants.KEY_PASSWORD, value: _passController.text);
    }
    GlobalCache().userPassword = _passController.text;
    firebaseMessaging.getToken().then((String token) async {
      if (token != null) {
        print("token:");
        print(token);
        final updateTokenBloc = ManageTokenBloc();
        await updateTokenBloc.init();
        updateTokenBloc.checkTokenSaved(token, Platform.isAndroid ? 0 : 1);
      }
    });

    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => MainView()), (route) => false);
  }

  @override
  void onNeedUpdate() async {
    // TODO: implement onNeedUpdate
    await progressDialog.hide();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        title: Row(
          children: [
            Image.asset(
              'assets/icons/dialog/dialog_notice.png',
              width: setWidth(20),
              height: setHeight(22),
            ),
            Text(' Cập nhật ứng dụng',
                style:
                    TextStyle(color: ColorUtils.BG_COLOR, fontSize: setSp(15))),
          ],
        ),
        //todo cập nhật phiên bản  sắp tới
        content: Text(
            'Hiện tại app Cây Khế đã nâng cấp lên phiên bản 1.1.3, bạn phải cập nhật ứng dụng để có thể thực hiện các nhiệm vụ mới.',
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.black54, fontSize: setSp(14))),
        actions: [
          FlatButton(
            child: Text('Không',
                style:
                    TextStyle(color: ColorUtils.BG_COLOR, fontSize: setSp(14))),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Cập nhật',
                style:
                    TextStyle(color: ColorUtils.BG_COLOR, fontSize: setSp(14))),
            onPressed: () {
              Navigator.pop(context);
              launchURL();
            },
          ),
        ],
      ),
    );
  }

  launchURL() async {
    const url =
        'https://play.google.com/store/apps/details?id=com.share4seo.caykhe';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Không thể mở trang $url';
    }
  }
}
