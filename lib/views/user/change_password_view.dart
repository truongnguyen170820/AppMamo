import 'package:mamo/blocs/impl/api_result_listener.dart';
import 'package:mamo/blocs/user/change_pwd_user_bloc.dart';
import 'package:mamo/utils/font_utils.dart';
import 'package:mamo/utils/text_styles.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/utils/utilities.dart';
import 'package:mamo/views/user/signin_account_view.dart';
import 'package:mamo/views/user/user_profile_view.dart';
import 'package:mamo/widget/circle_avatar.dart';
import 'package:mamo/widget/custombutton.dart';
import 'package:mamo/widget/global.dart';
import 'package:mamo/widget/image_button.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:mamo/widget/common_appbar.dart';

class ChangePasswordView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChangePasswordViewState();
}

class ChangePasswordViewState extends State<ChangePasswordView>
    with ApiResultListener {
  TextEditingController _txtOldPwd = TextEditingController();
  TextEditingController _txtNewPwd = TextEditingController();
  TextEditingController _txtRepeatPwd = TextEditingController();
  ChangePwdUserBloc changePwdUserBloc = ChangePwdUserBloc();
  ProgressDialog progressDialog;

  @override
  void initState() {
    super.initState();
    progressDialog = ProgressDialog(context);
    progressDialog.style(
      message: 'Đổi mật khẩu...',
      messageTextStyle: TextStyles.progress_text,
      backgroundColor: ColorUtils.backgroundColor,
      progressWidget: Container(
        padding: EdgeInsets.all(setWidth(8)),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(ColorUtils.BG_COLOR),
        ),
      ),
    );
    changePwdUserBloc.onChangePwdListen(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarDefault(context, 'Thay đổi mật khẩu', bgColor: Colors.white24),
      body: SingleChildScrollView(
        child: Container(
          // height: double.negativeInfinity,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Mật khẩu hiện tại', style: FontUtils.NORMAL.copyWith(fontSize: setSp(12), color: ColorUtils.TEXT_NAME)),
              SizedBox(
                width: double.infinity,
                height: 10,
              ),
              Container(
                height: setHeight(40),
                decoration: BoxDecoration(
                    color: ColorUtils.underlined,
                    border: Border.all(width: 1, color: ColorUtils.gray6),
                    borderRadius: BorderRadius.circular(8)
                ),
                child: TextField(
                  controller: _txtOldPwd,
                  style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE),
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.bottom,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: '●●●●●●●',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 20,
              ),
              Text('Mật khẩu mới',  style: FontUtils.NORMAL.copyWith(fontSize: setSp(12), color: ColorUtils.TEXT_NAME)),
              SizedBox(
                width: double.infinity,
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: ColorUtils.underlined,
                    border: Border.all(width: 1, color: ColorUtils.gray6),
                    borderRadius: BorderRadius.circular(8)
                ),
                height: setHeight(40),
                child: TextField(
                  controller: _txtNewPwd,
                  style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE),
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.bottom,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: '●●●●●●●',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 20,
              ),
              Text('Nhập lại mật khẩu', style: FontUtils.NORMAL.copyWith(fontSize: setSp(12), color: ColorUtils.TEXT_NAME)),
              SizedBox(
                width: double.infinity,
                height: 10,
              ),
              Container(
                height: setHeight(40),
                decoration: BoxDecoration(
                    color: ColorUtils.underlined,
                    border: Border.all(width: 1, color: ColorUtils.gray6),
                    borderRadius: BorderRadius.circular(8)
                ),
                child: TextField(
                  controller: _txtRepeatPwd,
                  style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE),
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.bottom,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: '●●●●●●●',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 40,
              ),
              Center(
                child: ButtonCustom(
                  title: "XÁC NHẬN",
                  textStyle: FontUtils.MEDIUM.copyWith(color: ColorUtils.WHITE),
                  height: setHeight(42),
                  width: setWidth(200),
                  borderRadius: 12,
                  onTap: (){
                    changePwd();
                  },
                ),
              ),
              // ChangePass()
            ],
          ),
        ),
      ),
    );
  }

  void changePwd() {
    FocusScope.of(context).unfocus();
    if (_txtOldPwd.text.isEmpty) {
      Utilities.showToast(context, 'Bạn chưa nhập thông tin mật khẩu hiện tại');
      return;
    }
    if (_txtNewPwd.text.isEmpty) {
      Utilities.showToast(context, 'Bạn chưa nhập thông tin mật khẩu mới');
      return;
    }
    if (_txtRepeatPwd.text.isEmpty) {
      Utilities.showToast(context, 'Bạn chưa nhập thông tin mật khẩu nhập lại');
      return;
    }
    if (_txtNewPwd.text != _txtRepeatPwd.text) {
      Utilities.showToast(
          context, 'Mật khẩu mới và Mật khẩu nhập lại không giống nhau');
      return;
    }
    if (_txtNewPwd.text.length < 6) {
      Utilities.showToast(context, 'Độ dài mật khẩu cần lớn hơn 5 ký tự');
      return;
    }
    if (_txtOldPwd.text == _txtNewPwd.text) {
      Utilities.showToast(context, 'Mật khẩu mới bị trùng mật khẩu hiện tại');
      return;
    }
    progressDialog.show().whenComplete(() => changePwdUserBloc.executeChangePwd(_txtOldPwd.text, _txtNewPwd.text));
  }

  @override
  void onRequesting() async {
    await progressDialog.show();
    return;
  }

  @override
  void onSuccess(List<dynamic> response) async {
    await progressDialog.hide();
    Utilities.showToast1(context, 'Đổi mật khẩu thành công');
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => UserProfileView()), (route) => false);
  }

  Widget ChangePass(){
    return Container(
      padding: EdgeInsets.only(right: setWidth(24), left: setWidth(24)),
      height: setHeight(293),
      width: setWidth(311),
      decoration: BoxDecoration(
          color: ColorUtils.gray4,
          borderRadius: BorderRadius.circular(32)
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(radius: 45,
            backgroundColor: ColorUtils.colorTextLogo,
            child: Icon(
              Icons.check, size: setSp(45), color: ColorUtils.WHITE,),
          ),
          SizedBox(height: setHeight(20)),
          Text("mess", style: FontUtils.NORMAL.copyWith(
              color: ColorUtils.colorTextLogo, fontSize: setSp(16)),),
          SizedBox(height: setHeight(13)),
          Text("Chúc mừng bạn đã đăng ký tài khoản Mamo. Đăng nhập ngay để sử dụng app nhé", style: FontUtils.NORMAL.copyWith(
              color: ColorUtils.TEXT_NAME, fontSize: setSp(12)),textAlign: TextAlign.center,)
        ],
      ),
    );
  }

  @override
  void onError(String message) async {
    await progressDialog.hide();
    Utilities.showToast(context, message);
  }

  @override
  void dispose() {
    changePwdUserBloc.disposeChangePwdSubject();
    _txtNewPwd.dispose();
    _txtOldPwd.dispose();
    _txtRepeatPwd.dispose();
    super.dispose();
  }
}
