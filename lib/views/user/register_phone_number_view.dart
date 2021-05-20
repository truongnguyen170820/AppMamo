import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/utils/utilities.dart';
import 'package:mamo/utils/validator_utils.dart';
import 'package:mamo/views/user/register_account_view.dart';
import 'package:mamo/widget/global.dart';
import 'package:mamo/widget/image_button.dart';
import 'package:flutter/material.dart';
import 'package:mamo/widget/common_appbar.dart';


class RegisterPhoneView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegisterPhoneViewState();
}

class RegisterPhoneViewState extends State<RegisterPhoneView> {
  TextEditingController _txtPhoneNumber = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context, 'Xác minh số điện thoại'),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: setWidth(16),right: setWidth(16)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: setHeight(40),
                ),
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Nhập số điện thoại của bạn\nVí dụ: 0912345678',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "SFUIText",
                            color: Colors.black54,
                            fontSize: setSp(14),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: setHeight(20),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: setWidth(80), right: setWidth(80)),
                  height: setHeight(30),
                  child: TextField(
                    style: TextStyle(
                        fontFamily: "SFUIText",
                        color: ColorUtils.MAIN_GRADIENT_2,
                        fontSize: setSp(16),
                        fontWeight: FontWeight.bold),
                    controller: _txtPhoneNumber,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.bottom,
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  height: setHeight(30),
                ),
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Mỗi điện thoại chỉ được đăng nhập 1 tài khoản duy nhất. Đăng nhập nhiều tài khoản trên một máy sẽ bị khóa tài khoản.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "SFUIText",
                            color: Colors.black54,
                            fontSize: setSp(14),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: setHeight(30),
                ),
                Center(
                  child: SimpleButton('Tiếp tục', registerAccount),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void registerAccount() {
    FocusScope.of(context).unfocus();
    if (_txtPhoneNumber.text.isEmpty) {
      Utilities.showToast(context, 'Bạn chưa nhập số điện thoại');
      return;
    }
    if (!Validator.instance.IsPhoneNumber(_txtPhoneNumber.text)) {
      Utilities.showToast(context, 'Số điện thoại không hợp lệ');
      return;
    }
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => RegisterAccountView(
    //             _txtPhoneNumber.text.trim())));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
