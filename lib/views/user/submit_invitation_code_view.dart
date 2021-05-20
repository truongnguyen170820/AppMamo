import 'package:mamo/blocs/impl/api_result_listener.dart';
import 'package:mamo/blocs/user/submit_invite_code_bloc.dart';
import 'package:mamo/utils/text_styles.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/utils/utilities.dart';
import 'package:mamo/widget/custombutton.dart';
import 'package:mamo/widget/global.dart';
import 'package:mamo/widget/image_button.dart';
import 'package:flutter/material.dart';
import 'package:mamo/widget/common_appbar.dart';
import 'package:progress_dialog/progress_dialog.dart';

class SubmitInvitationCodeView extends StatefulWidget {
  @override
  _SubmitInvitationCodeState createState() => _SubmitInvitationCodeState();
}

class _SubmitInvitationCodeState extends State<SubmitInvitationCodeView>
    with ApiResultListener {
  TextEditingController _txtInviteCode = TextEditingController();
  SubmitInviteCodeBloc submitInviteCodeBloc = SubmitInviteCodeBloc();
  ProgressDialog progressDialog;

  @override
  void initState() {
    super.initState();
    submitInviteCodeBloc.init(this);
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
      appBar: backAppBar(context, 'Nhập mã giới thiệu'),
      body: Container(
        padding: EdgeInsets.all(setWidth(16)),
        child: Column(
          children: [
            SizedBox(
              height: setHeight(40),
            ),
            Text(
              'Mã giới thiệu',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SFUIText',
                  color: Colors.green,
                  fontSize: setSp(16)),
            ),
            SizedBox(
              height: setHeight(30),
            ),
            Container(
              padding: EdgeInsets.only(left: setWidth(80), right: setWidth(80)),
              height: setHeight(30),
              child: TextField(
                style: TextStyle(
                    fontFamily: "SFUIText",
                    color: ColorUtils.MAIN_GRADIENT_2,
                    fontSize: setSp(16),
                    fontWeight: FontWeight.bold),
                controller: _txtInviteCode,
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.bottom,
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              height: setHeight(30),
            ),
            ButtonCustom(
              title: "Áp dụng",
              onTap: (){
                FocusScope.of(context).unfocus();
                if (_txtInviteCode.text.isEmpty) {
                  Utilities.showToast(context, 'Bạn chưa nhập mã giới thiệu!');
                } else
                  progressDialog.show().then((value) {
                    submitInviteCodeBloc
                        .submitInviteCode(_txtInviteCode.text);
                  });
              },
            ),
            SizedBox(
              height: setHeight(50),
            ),
            Container(
              width: double.infinity,
              child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  text: 'Chú ý: ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SFUIText',
                      color: ColorUtils.BG_COLOR,
                      fontSize: setSp(12)),
                  children: [
                    TextSpan(
                        text:
                            'Sau khi hoàn thành 05 nhiệm vụ đầu tiên thì bạn sẽ được thưởng 03 lần quay.',
                        style: TextStyles.common_text),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onError(String message) async {
    await progressDialog.hide();
    Utilities.showToast(context, message);
  }

  @override
  void onRequesting() {}

  @override
  void onSuccess(List response) async {
    await progressDialog.hide();
    Utilities.showToast(context, 'Nhập mã giới thiệu thành công');
    Navigator.pop(context);
  }
}
