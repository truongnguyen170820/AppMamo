import 'package:flutter/widgets.dart';
import 'package:mamo/blocs/impl/api_result_listener.dart';
import 'package:mamo/blocs/user/register_account_bloc.dart';
import 'package:mamo/utils/font_utils.dart';
import 'package:mamo/utils/text_styles.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/utils/utilities.dart';
import 'package:mamo/views/user/signin_account_view.dart';
import 'package:mamo/widget/custombutton.dart';
import 'package:mamo/widget/global.dart';
import 'package:mamo/widget/image_button.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:mamo/widget/common_appbar.dart';
import 'package:device_info/device_info.dart';
import 'dart:io';
class RegisterAccountView extends StatefulWidget {
  // final String mobile;
  // RegisterAccountView(this.mobile);
  @override
  State<StatefulWidget> createState() => RegisterAccountViewState();
}

class RegisterAccountViewState extends State<RegisterAccountView>
    with ApiResultListener {
  TextEditingController _txtMobile = TextEditingController();
  TextEditingController _txtName = TextEditingController();
  TextEditingController _txtNewPwd = TextEditingController();
  TextEditingController _txtRepeatPwd = TextEditingController();
  RegisterAccountBloc registerAccountBloc = RegisterAccountBloc();
  ProgressDialog progressDialog;

  bool checkPass  = false;
  bool checkRetypePass  = false;
  bool checkIcon = false;

  @override
  void initState() {
    super.initState();
    progressDialog = ProgressDialog(context);
    progressDialog.style(
      message: 'Đăng ký tài khoản...',
      messageTextStyle: TextStyles.progress_text,
      backgroundColor: ColorUtils.backgroundColor,
      progressWidget: Container(
        padding: EdgeInsets.all(setWidth(8)),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(ColorUtils.BG_COLOR),
        ),
      ),
    );
    registerAccountBloc.init(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarDefault(context, 'Đăng ký tài khoản', bgColor: ColorUtils.WHITE),
      backgroundColor: ColorUtils.WHITE,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.only(right: setWidth(16), left: setWidth(16), ),
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(width: 1, color: ColorUtils.gray))
              ),
            // padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: setHeight(74),
                  width: setWidth(343),
                  padding: EdgeInsets.only(left: setWidth(16), top: setHeight(12), right: setWidth(16), bottom: setHeight(12)),
                  margin: EdgeInsets.only(bottom: setHeight(18), top: setHeight(16)),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
                      color: ColorUtils.lg,
                  ),
                  child: Text(
                    "Bạn phải dùng chính xác số điện thoại của mình để tạo tài khoản. Nếu không khi tài khoản bị khóa bạn sẽ không nhận được OTP để khôi phục.",
                    style: FontUtils.NORMAL.copyWith(color: ColorUtils.bt, fontSize: setSp(12)),
                    textAlign: TextAlign.justify,
                    textScaleFactor: 1,
                    overflow: TextOverflow.clip,
                  ),
                ),
                Text(
                  'Số điện thoại',
                  style: FontUtils.NORMAL.copyWith(color: ColorUtils.TEXT_NAME, fontSize: setSp(12)),
                ),
                Container(
                  margin: EdgeInsets.only(top: setHeight(8)),
                  height: setHeight(45),
                  decoration: BoxDecoration(
                    color: ColorUtils.underlined,
                    border: Border.all(color: ColorUtils.TEXT_NAME),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: TextField(
                    controller: _txtMobile,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.top,
                    style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    // enabled: false,
                  ),
                ),

                SizedBox(
                  height: setHeight(20),
                ),
                Text('Họ tên',
                  style: FontUtils.NORMAL.copyWith(color: ColorUtils.TEXT_NAME, fontSize: setSp(12)),
                ),
                Container(
                  margin: EdgeInsets.only(top: setHeight(8)),
                  decoration: BoxDecoration(
                      color: ColorUtils.underlined,
                      border: Border.all(color: ColorUtils.TEXT_NAME),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  height: setHeight(45),
                  child: TextField(
                    style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE),
                    controller:  _txtName,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: setHeight(20),
                ),
                Text('Nhập mật khẩu',
                  style: FontUtils.NORMAL.copyWith(color: ColorUtils.TEXT_NAME, fontSize: setSp(12)),
                ),
                Container(
                  margin: EdgeInsets.only(top: setHeight(8)),
                  decoration: BoxDecoration(
                      color: ColorUtils.underlined,
                      border: Border.all(color: ColorUtils.TEXT_NAME),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  height: setHeight(45),
                  child: Row(
                    children: [
                      Container(
                        width: setWidth(310),
                        child: TextField(
                          onChanged: (data){
                            checkPassword(_txtNewPwd, _txtRepeatPwd);
                          },
                          controller: _txtNewPwd,
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.bottom,
                          obscureText: true,
                          style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE),
                          decoration: InputDecoration(
                            hintText: '●●●●●●●',
                            suffix: checkPass ? Icon(Icons.check,color: ColorUtils.colorTextLogo) : SizedBox(),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                      // checkTicker()
                    ],
                  ),
                ),
                SizedBox(
                  height: setHeight(20),
                ),
                Text('Nhập lại mật khẩu',
                  style: FontUtils.NORMAL.copyWith(color: ColorUtils.TEXT_NAME, fontSize: setSp(12)),
                ),
                Container(
                  margin: EdgeInsets.only(top: setHeight(8)),
                  decoration: BoxDecoration(
                      color: ColorUtils.underlined,
                      border: Border.all(color: ColorUtils.TEXT_NAME),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  height: setHeight(45),
                  child: Row(
                    children: [
                      Container(
                        width: setWidth(310),
                        child: TextField(
                          onChanged: (data){
                            checkRetypePassword(_txtRepeatPwd, _txtNewPwd);
                          },
                          style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE),
                          controller: _txtRepeatPwd,
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.bottom,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: '●●●●●●●',
                            suffix: checkRetypePass ? Icon(Icons.check,color: ColorUtils.colorTextLogo,) : SizedBox(),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                      // checkTick()
                    ],
                  ),
                ),
                SizedBox(
                  height: setHeight(40),
                ),
                Center(
                  child: ButtonCustom(
                    width: setWidth(200),
                    height: setHeight(42),
                    textStyle: FontUtils.MEDIUM.copyWith(color: ColorUtils.WHITE),
                    title: "ĐĂNG KÝ",
                    borderRadius: 12,
                    onTap: (){registerAccount();},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  checkPassword(TextEditingController controller, TextEditingController subCtrl) {
    if (subCtrl.text.length == 0 || subCtrl.text == null) {
      if (controller.text.length >= 6) {
        setState(() {
          checkPass = true;
        });
      } else {
        setState(() {
          checkPass = false;
        });
      };
    }
    else {
      if (controller.text.length >= 6) {
        if(controller.text == subCtrl.text){
          setState(() {
            checkPass = true;
            checkRetypePass = true;
          });
        } else {
          setState(() {
            checkPass = true;
            checkRetypePass = false;
          });
        }

      } else {
        setState(() {
          checkPass = false;
        });
      };
    }
  }
  checkRetypePassword(TextEditingController controller,TextEditingController subCtrl){
    if(controller.text == subCtrl.text && controller.text.length >5){
      setState(() {
        checkRetypePass = true;
      });
    } else {
      setState(() {
        checkRetypePass = false;
      });
    };
  }
  Future<String> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  void registerAccount() async{
    FocusScope.of(context).requestFocus(FocusNode());
    if (_txtNewPwd.text.isEmpty) {
      Utilities.showToast(context, 'Bạn chưa nhập mật khẩu');
      return;
    }
    if (_txtNewPwd.text.length < 6) {
      Utilities.showToast(context, 'Độ dài mật khẩu cần lớn hơn 6 ký tự');
      return;
    }
    if(_txtName.text.trim()?.isEmpty){
      Utilities.showToast(context, 'Bạn chưa nhập họ tên');
      return;
    }
    if (_txtRepeatPwd.text.isEmpty) {
      Utilities.showToast(context, 'Bạn chưa nhập lại mật khẩu');
      return;
    }
    if (_txtNewPwd.text != _txtRepeatPwd.text) {
      Utilities.showToast(
          context, 'Mật khẩu và Mật khẩu nhập lại không giống nhau');
      return;
    }
    String deviceId = await _getId();
    print("deviceId:    "+ deviceId);
    progressDialog.show().whenComplete(() =>
        registerAccountBloc.  registerAccount(_txtMobile.text, _txtNewPwd.text,_txtName.text,
            deviceId: deviceId,
        ));
  }

  @override
  void onRequesting() async {
    await progressDialog.show();
    return;
  }

  @override
  void onSuccess(List<dynamic> response) async {
    await progressDialog.hide();
    Utilities.showToast1(context, 'Đăng ký tài khoản thành công', mess1: "Chúc mừng bạn đã đăng ký tài khoản Mamo. Đăng nhập ngay để sử dụng app nhé.");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) =>
                SigninAccountView()),
            (route) => false);
  }

  @override
  void onError(String message) async {
    await progressDialog.hide();
    Utilities.showToast(context, message);
  }

  @override
  void dispose() {
    registerAccountBloc.dispose();
    _txtNewPwd.dispose();
    _txtMobile.dispose();
    _txtName.dispose();
    _txtRepeatPwd.dispose();
    super.dispose();
  }
}
