
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/utils/text_styles.dart';
import 'package:mamo/utils/utilities.dart';
import 'package:mamo/views/user/register_account_view.dart';
import 'package:mamo/views/user/reset_password_view.dart';
import 'package:mamo/widget/common_appbar.dart';
import 'package:mamo/widget/global.dart';
import 'package:mamo/widget/image_button.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ValidateOtpView extends StatefulWidget {
  final int type;
  final String mobile;
  ValidateOtpView(this.type, this.mobile);
  @override
  State<StatefulWidget> createState() => ValidateOtpViewState();
}

class ValidateOtpViewState extends State<ValidateOtpView> {
  TextEditingController _txtOtp = TextEditingController();
  ProgressDialog progressDialog;

  @override
  void initState() async {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context, 'Xác minh số điện thoại'),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: setHeight(40),
                ),
                Center(
                  child: Text(
                    'Nhập mã OTP',
                    style: TextStyle(
                        fontFamily: "SFUIText",
                        color: Colors.black54,
                        fontSize: setSp(14),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: setHeight(20),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: setWidth(100), right: setWidth(100)),
                  height: setHeight(30),
                  child: TextField(
                    style: TextStyle(
                        fontFamily: "SFUIText",
                        color: ColorUtils.MAIN_GRADIENT_2,
                        fontSize: setSp(16),
                        fontWeight: FontWeight.bold),
                    controller: _txtOtp,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.bottom,
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  height: setHeight(60),
                ),
                Center(
                  child: SimpleButton('Tiếp tục', validateOtp),
                ),
                SizedBox(
                  height: setHeight(30),
                ),
                // Center(
                //   child: Text(
                //     'Tôi không nhận được mã',
                //     style: TextStyle(
                //         fontFamily: "SFUIText",
                //         color: Colors.black54,
                //         fontSize: setSp(14),
                //         fontWeight: FontWeight.bold),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateOtp() {
    FocusScope.of(context).unfocus();
    if (_txtOtp.text.isEmpty) {
      Utilities.showToast(context, 'Bạn chưa nhập mã OTP!');
      return;
    }
  }

  @override
  void dispose() {
    _txtOtp.dispose();
    super.dispose();
  }

  void onSuccess(List response) async {
    await progressDialog.hide();
    if (widget.type == 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RegisterAccountView()));
    }
    if (widget.type == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ResetPasswordView(widget.mobile)));
    }
  }
}
