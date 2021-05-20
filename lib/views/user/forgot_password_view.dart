import 'package:mamo/blocs/impl/api_result_listener.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/utils/font_utils.dart';
import 'package:mamo/utils/utilities.dart';
import 'package:mamo/utils/validator_utils.dart';
import 'package:mamo/views/user/reset_password_view.dart';
import 'package:mamo/widget/custombutton.dart';
import 'package:mamo/widget/global.dart';
import 'package:mamo/widget/image_button.dart';
import 'package:mamo/widget/progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mamo/widget/common_appbar.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPasswordView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ForgotPasswordViewState();
}

class ForgotPasswordViewState extends State<ForgotPasswordView>
    implements ApiResultListener {
  // CheckOtpBloc checkOtpBloc = CheckOtpBloc();
  TextEditingController _txtPhoneNumber = TextEditingController();
  TextEditingController _txtOtp = TextEditingController();
  ProgressDialog progressDialog;
  FirebaseAuth auth;
  String verifyId;
  bool isOtpSent = false;
  SharedPreferences prefs;

  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    progressDialog = progDialog(context, message: "Đang xử lý...");
    // checkOtpBloc.init(this);
    // checkOtpBloc.checkOtp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarDefault(context, 'Nhập số điện thoại', bgColor: ColorUtils.WHITE),
      backgroundColor: ColorUtils.WHITE,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.only(left: setWidth(16), right: setWidth(16)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: setHeight(40),
                ),
                isOtpSent
                    ? Center(
                        child: Text(
                          'Vui lòng kiểm tra tin nhắn\ntìm và nhập mã OTP',
                          textAlign: TextAlign.center,
                          style: FontUtils.BOLD.copyWith(color: ColorUtils.NUMBER_PAGE),
                        ),
                      )
                    : Text(
                      'Nhập số điện thoại',
                      textAlign: TextAlign.center,
                      style: FontUtils.NORMAL.copyWith(color: ColorUtils.TEXT_NAME, fontSize: setSp(12)),
                    ),
                SizedBox(
                  height: setHeight(20),
                ),
                isOtpSent
                    ? Container(
                        padding: EdgeInsets.only(
                            left: setWidth(16), right: setWidth(16)),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: ColorUtils.TEXT_NAME)
                        ),
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
                      )
                    : Container(
                  height: setHeight(36),
                    padding: EdgeInsets.only(
                        left: setWidth(16), right: setWidth(16), bottom: setHeight(9), top: setHeight(9)),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: ColorUtils.TEXT_NAME),
                    borderRadius: BorderRadius.circular(8)
                  ),
                        // height: setHeight(36),
                        child: TextField(
                          style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE),
                          controller: _txtPhoneNumber,
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                               borderSide: BorderSide.none
                            )
                          ),
                        ),
                      ),
                SizedBox(
                  height: setHeight(60),
                ),
                isOtpSent
                    ? Center(
                        child:
                        ButtonCustom(
                          height: setHeight(42),
                          width: setWidth(200),
                          title: 'TIẾP TỤC',
                          borderRadius: 12,
                          textStyle: FontUtils.MEDIUM.copyWith(color: ColorUtils.WHITE),
                          onTap: (){sendOtp();},
                        ))
                    : Center(
                        child:  ButtonCustom(
                          height: setHeight(42),
                          width: setWidth(200),
                          borderRadius: 12,
                          title: 'TIẾP TỤC',
                          textStyle: FontUtils.MEDIUM.copyWith(color: ColorUtils.WHITE),
                          onTap: (){requireOtp();},
                        )
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future authenListen(String phone, BuildContext context) {
    auth = FirebaseAuth.instance;
    try {
      auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {
          // progressDialog.hide();
          // Auto-resolution timed out...
        },
        verificationCompleted: (PhoneAuthCredential credential) async {
          progressDialog.hide();
          UserCredential result = await auth.signInWithCredential(credential);
          User user = result.user;
          if (user != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ResetPasswordView(user.phoneNumber)));
          } else {
            print("Lỗi khi tự động xác nhận OTP");
          }
          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (FirebaseAuthException exception) {
          progressDialog.hide();
          print(exception);
          if (exception.code == 'invalid-phone-number') {
            Utilities.showToast(context, "Số điện thoại không hợp lệ");
          } else {
            Utilities.showToast(context, "Có lỗi xảy ra, hãy thử lại sau");
          }
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          progressDialog.hide();
          setState(() {
            isOtpSent = true;
            verifyId = verificationId;
          });
        },
      );
    } on FirebaseAuthException catch (e) {
      progressDialog.hide();
      print("Error: ${e.code}");
      Utilities.showToast(context, "Có lỗi xảy ra");
    }
  }

  void requireOtp() async {
    FocusScope.of(context).unfocus();
    if (_txtPhoneNumber.text.isEmpty) {
      Utilities.showToast(context, 'Bạn chưa nhập số điện thoại');
      return;
    }
    if (!Validator.instance.IsPhoneNumber(_txtPhoneNumber.text)) {
      Utilities.showToast(context, 'Số điện thoại không hợp lệ');
      return;
    }

    prefs = await SharedPreferences.getInstance();
    String currentDate = DateTime.now().toString().substring(0, 10);
    // print(currentDate);
    String requireCounter = prefs.getString(currentDate);
    // print(requireCounter);
    if (requireCounter == null || int.parse(requireCounter) < 3) {
      progressDialog.show();
      // print("hello");
      authenListen(
          '+84' + _txtPhoneNumber.text.trim().substring(1, 10), context);
      prefs.setString(
          currentDate, (int.parse(requireCounter ?? "0") + 1).toString());
    } else {
      Utilities.showToast(context, "Bạn đã yêu cầu OTP quá 3 lần/ngày");
    }
  }

  void sendOtp() async {
    UserCredential result;
    FocusScope.of(context).unfocus();
    if (_txtOtp.text == null || _txtOtp.text.isEmpty) {
      Utilities.showToast(context, 'Bạn chưa nhập mã OTP');
      return;
    }
    progressDialog.show();
    String code = _txtOtp.text.trim();
    try {
      AuthCredential credential =
          PhoneAuthProvider.credential(verificationId: verifyId, smsCode: code);
      result = await auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      progressDialog.hide();
      print("Error: ${e.code}");
      Utilities.showToast(
          context, "Mã OTP không đúng hoặc quá hạn, hãy thử lại");
    }
    if (result != null) {
      User user = result.user;
      if (user != null) {
        progressDialog.hide();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ResetPasswordView(user.phoneNumber)));
      } else {
        progressDialog.hide();
        Utilities.showToast(context, "Có lỗi xảy ra, hãy thử lại");
        print("Lỗi user không đúng");
      }
    } else {
      progressDialog.hide();
      Utilities.showToast(context, "Có lỗi xảy ra, hãy thử lại");
      print("Lỗi khi xác nhận OTP");
    }
  }

  @override
  void onError(String message) {
    // TODO: implement onError
  }

  @override
  void onRequesting() {
    // TODO: implement onRequesting
  }

  @override
  void onSuccess(List response) {
    // TODO: implement onSuccess
  }
}
