import 'package:mamo/blocs/impl/api_result_listener.dart';
import 'package:mamo/blocs/user/reset_password_bloc.dart';
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

class ResetPasswordView extends StatefulWidget {
  final String mobile;
  ResetPasswordView(this.mobile);
  @override
  State<StatefulWidget> createState() => ResetPasswordViewState();
}

class ResetPasswordViewState extends State<ResetPasswordView>
    with ApiResultListener {
  TextEditingController _txtNewPwd = TextEditingController();
  TextEditingController _txtRepeatPwd = TextEditingController();
  ResetPasswordBloc resetPasswordBloc = ResetPasswordBloc();
  ProgressDialog progressDialog;

  @override
  void initState() {
    super.initState();
    progressDialog = ProgressDialog(context);
    progressDialog.style(
      message: 'Đang gửi...',
      messageTextStyle: TextStyles.progress_text,
      backgroundColor: ColorUtils.backgroundColor,
      progressWidget: Container(
        padding: EdgeInsets.all(setWidth(8)),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(ColorUtils.BG_COLOR),
        ),
      ),
    );
    resetPasswordBloc.init(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarDefault(context, 'Đổi mật khẩu', bgColor: ColorUtils.WHITE),
      backgroundColor: ColorUtils.WHITE,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.only(left: setWidth(16), right: setWidth(16)),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: ColorUtils.gray
                )
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: setHeight(20),
                ),
                Text('Mật khẩu mới',
                    style: FontUtils.NORMAL.copyWith(color: ColorUtils.TEXT_NAME, fontSize: setSp(12))
                ),
                SizedBox(
                  width: double.infinity,
                  height: 10,
                ),
               Container(
                 height: setHeight(36),
                 padding: EdgeInsets.only(top: setHeight(8), bottom: setHeight(8)),
                 decoration: BoxDecoration(
                   color: ColorUtils.underlined,
                   borderRadius: BorderRadius.circular(8),
                   border: Border.all(width: 1, color: ColorUtils.TEXT_NAME),
                 ),
                 child: TextField(
                   textAlignVertical: TextAlignVertical.center,
                   decoration: InputDecoration(
                     border: OutlineInputBorder(
                       borderSide: BorderSide.none,
                     )
                   ),
                   controller: _txtNewPwd,
                 ),
               ),
                SizedBox(
                  height: setHeight(20),
                ),
                Text('Nhập lại mật khẩu',
                    style:FontUtils.NORMAL.copyWith(color: ColorUtils.TEXT_NAME, fontSize: setSp(12))),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: setHeight(36),
                  padding: EdgeInsets.only(top: setHeight(8), bottom: setHeight(8)),
                  decoration: BoxDecoration(
                    color: ColorUtils.underlined,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1, color: ColorUtils.TEXT_NAME),
                  ),
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        )
                    ),
                    controller: _txtRepeatPwd,
                  ),
                ),
                SizedBox(
                  height: setHeight(40),
                ),
                Center(
                  child: ButtonCustom(
                    title: "XÁC NHẬN",
                    borderRadius: 12,
                    textStyle: FontUtils.MEDIUM.copyWith(color: ColorUtils.WHITE),
                    height: setHeight(42),
                    width: setWidth(200),
                    onTap: (){
                      resetPassword();
                    },

                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void resetPassword() {
    FocusScope.of(context).unfocus();
    if (_txtNewPwd.text.isEmpty) {
      Utilities.showToast(context, 'Bạn chưa nhập mật khẩu');
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
    if (_txtNewPwd.text.length < 6) {
      Utilities.showToast(context, 'Độ dài mật khẩu cần lớn hơn 5 ký tự');
      return;
    }
  //   progressDialog.show().whenComplete(() => resetPasswordBloc.resetPassword(
  //       '0' + widget.mobile.substring(3, 12), _txtNewPwd.text));
  }

  @override
  void onRequesting() async {
    await progressDialog.show();
    return;
  }

  @override
  void onSuccess(List<dynamic> response) async {
    await progressDialog.hide();
    Utilities.showToast(context, 'Đổi mật khẩu thành công');
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SigninAccountView()),
        (route) => false);
  }

  @override
  void onError(String message) async {
    await progressDialog.hide();
    Utilities.showToast(context, message);
  }

  @override
  void dispose() {
    resetPasswordBloc.dispose();
    _txtNewPwd.dispose();
    _txtRepeatPwd.dispose();
    super.dispose();
  }
}
