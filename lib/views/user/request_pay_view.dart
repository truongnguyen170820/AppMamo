import 'package:mamo/blocs/impl/api_result_listener.dart';
import 'package:mamo/blocs/user/request_pay_bloc.dart';
import 'package:mamo/utils/font_utils.dart';
import 'package:mamo/utils/text_styles.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/utils/global_cache.dart';
import 'package:mamo/utils/utilities.dart';
import 'package:mamo/views/user/request_pay_error_view.dart';
import 'package:mamo/views/user/request_pay_success_view.dart';
import 'package:mamo/views/user/user_profile_view.dart';
import 'package:mamo/widget/custombutton.dart';
import 'package:mamo/widget/global.dart';
import 'package:mamo/widget/image_button.dart';
import 'package:mamo/widget/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:mamo/widget/common_appbar.dart';

class RequestPayView extends StatefulWidget {
  final double balance;
  int payType;
  RequestPayView({this.balance, this.payType});
  @override
  State<StatefulWidget> createState() => RequestPayViewState();
}

class RequestPayViewState extends State<RequestPayView> with ApiResultListener {
  TextEditingController _txtBalance = TextEditingController();
  TextEditingController _txtAmount = TextEditingController();
  TextEditingController _txtMomoAccount = TextEditingController();
  TextEditingController _passController = TextEditingController();
  bool _isShowPassword = true;
  RequestPayBloc requestPayBloc = RequestPayBloc();
  ProgressDialog progressDialog;
  NumberFormat nf = NumberFormat("###,###,###", "en_US");
  List<String> telcoListLabel = [
    'Vinaphone',
    'Mobifone',
    'Viettel',
  ];
  List<String> gameCardListLabel = [
    'Garena',
    'Zing',
    'V-coin',
  ];
  String gameCardName;
  int gameCardValue;
  String telcoName;
  int amount;
  int cardValue;
  // int payType = 1;

  @override
  void initState() {
    super.initState();
    progressDialog = progDialog(context, message: "Đang xử lý");
    _txtBalance.text = nf.format(widget.balance);
    _txtMomoAccount.text = GlobalCache().loginData.momoMobile;
    requestPayBloc.init(this);
    gameCardName = gameCardListLabel[0];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: appbarDefault(context, 'Yêu cầu rút tiền', bgColor: ColorUtils.WHITE),
        backgroundColor: ColorUtils.WHITE,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: setWidth(16), right: setWidth(16)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: setWidth(16), right: setWidth(16)),
                    decoration: BoxDecoration(
                        border: Border(top: BorderSide(width: 1, color: ColorUtils.underlined))
                    )),
                Container(
                  margin: EdgeInsets.only(top: setHeight(16), bottom: setHeight(16)),
                  padding: EdgeInsets.only(left: setWidth(16), right: setWidth(19),top: setHeight(20), bottom: setHeight(19)),
                  height: setHeight(65),
                  decoration: BoxDecoration(
                      color: ColorUtils.colorStatus,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Row(
                    children: [
                      Text("Số tiền trong ví", style: FontUtils.MEDIUM.copyWith(fontSize: setSp(13), color: ColorUtils.colorTextLogo)),
                      Spacer(),
                      Text(Utilities.formatMoney(widget.balance??"", suffix: 'đ'),
                        style: FontUtils.BOLD.copyWith(color: ColorUtils.TEXT_PRICE, fontSize: setSp(20)),)
                    ],
                  ),
                ),
                SizedBox(
                  height: setHeight(15),
                ),
                Text(
                  'Hình thức rút tiền',
                  style: FontUtils.NORMAL.copyWith(fontSize: setSp(12), color: ColorUtils.TEXT_NAME),
                ),
                SizedBox(
                  height: setHeight(5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonCustom(
                      title: "RÚT MOMO",
                      width: setWidth(163),
                      height: setHeight(42),
                      borderRadius: 12,
                      bgColor: widget.payType == 1 ? ColorUtils.TEXT_PRICE : ColorUtils.bt1,
                      textStyle: FontUtils.MEDIUM.copyWith(color: widget.payType == 1 ? ColorUtils.WHITE :ColorUtils.TEXT_NAME),
                      onTap: (){
                        setState(() {
                          widget.payType =1;
                        });
                      },
                    ),
                    ButtonCustom(
                      title: "RÚT THẺ ĐT",
                      width: setWidth(163),
                      height: setHeight(42),
                      borderRadius: 12,
                      bgColor: widget.payType != 2 ? ColorUtils.bt1 : ColorUtils.TEXT_PRICE,
                      textStyle: FontUtils.MEDIUM.copyWith(color: widget.payType ==2 ? ColorUtils.WHITE : ColorUtils.TEXT_NAME),
                      onTap: (){
                        setState(() {
                          widget.payType = 2;
                        });
                      },
                    )
                  ],
                ),
                if (widget.payType == 1)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: setHeight(22),
                      ),
                      Text(
                        'Tài khoản Momo',
                        style: FontUtils.NORMAL.copyWith(fontSize: setSp(12), color: ColorUtils.TEXT_NAME),
                      ),
                      SizedBox(
                        height: setHeight(10),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: setWidth(16), right: setWidth(16), ),
                        height: setHeight(35),
                        decoration: BoxDecoration(
                          color: ColorUtils.underlined,
                          border: Border.all(color: ColorUtils.TEXT_NAME, width: setWidth(1)),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: TextField(
                          controller: _txtMomoAccount,
                          style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE),
                          // textAlignVertical: TextAlignVertical.bottom,
                          decoration: InputDecoration(
                            hintText: "Nhập tài khoản Momo",
                            suffixText: GlobalCache().loginData.momoName??"",
                            suffixStyle: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE),
                            hintStyle: TextStyles.hint,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: setHeight(15),
                      ),
                      Text(
                        'Số tiền rút',
                        style: FontUtils.NORMAL.copyWith(fontSize: setSp(12), color: ColorUtils.TEXT_NAME),
                      ),
                      SizedBox(
                        height: setHeight(10),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: setWidth(10)),
                        decoration: BoxDecoration(
                          color: ColorUtils.underlined,
                          border: Border.all(color: ColorUtils.TEXT_NAME, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        height: setHeight(36),
                        child: TextField(
                          controller: _txtAmount,
                          style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE),
                          textAlignVertical: TextAlignVertical.center,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            CurrencyInputFormatter(maxDigits: 6),
                          ],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Nhập số tiền rút',
                            hintStyle: TextStyles.hint,

                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                if (widget.payType == 2)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: setHeight(22),
                      ),
                      Text(
                        'Chọn nhà mạng',
                        style: FontUtils.NORMAL.copyWith(fontSize: setSp(12), color: ColorUtils.TEXT_NAME),
                      ),
                      SizedBox(
                        height: setHeight(10),
                      ),
                      Container(
                        height: setHeight(35),
                        width: double.infinity,
                        padding: EdgeInsets.only(left: setWidth(10)),
                        decoration: BoxDecoration(
                          color: ColorUtils.underlined,
                          border: Border.all(
                            color: ColorUtils.TEXT_NAME,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: telcoName,
                            icon: Icon(Icons.keyboard_arrow_down, color: ColorUtils.TEXT_NAME,),
                            onChanged: (String newValue) {
                              setState(() {
                                telcoName = newValue;
                              });
                            },
                            items: [0, 1, 2]
                                .map<DropdownMenuItem<String>>((int value) {
                              return DropdownMenuItem<String>(
                                value: telcoListLabel[value],
                                child: Text(
                                  telcoListLabel[value],
                                  style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),


                      SizedBox(
                        height: setHeight(15),
                      ),
                      Text(
                        'Mệnh giá thẻ',
                        style: FontUtils.NORMAL.copyWith(fontSize: setSp(12), color: ColorUtils.TEXT_NAME),
                      ),
                      SizedBox(
                        height: setHeight(10),
                      ),
                      Container(
                        height: setHeight(35),
                        width: double.infinity,
                        padding: EdgeInsets.only(left: setWidth(10)),
                        decoration: BoxDecoration(
                          color: ColorUtils.underlined,
                          border: Border.all(
                            color: ColorUtils.TEXT_NAME,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: cardValue,
                            icon: Icon(Icons.keyboard_arrow_down, color: ColorUtils.TEXT_NAME,),
                            onChanged: (int newValue) {
                              setState(() {
                                cardValue = newValue;
                              });
                            },
                            items: [
                              DropdownMenuItem<int>(
                                value: 10000,
                                child: Text(
                                  '10,000',
                                  style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE),
                                ),
                              ),
                              DropdownMenuItem<int>(
                                value: 20000,
                                child: Text(
                                  '20,000',
                                  style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE),
                                ),
                              ),
                              DropdownMenuItem<int>(
                                value: 50000,
                                child: Text(
                                  '50,000',
                                  style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                // if (payType == 3)
                //   Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         'Chọn thẻ game',
                //         style: TextStyles.common_text,
                //       ),
                //       SizedBox(
                //         height: setHeight(10),
                //       ),
                //       Container(
                //         height: setHeight(35),
                //         width: double.infinity,
                //         padding: EdgeInsets.only(left: setWidth(10)),
                //         decoration: BoxDecoration(
                //           border: Border.all(
                //             color: ColorUtils.BG_COLOR,
                //           ),
                //           borderRadius: BorderRadius.all(Radius.circular(10.0)),
                //         ),
                //         child: DropdownButtonHideUnderline(
                //           child: DropdownButton(
                //             value: gameCardName,
                //             icon: Icon(Icons.keyboard_arrow_down),
                //             onChanged: (String newValue) {
                //               setState(() {
                //                 gameCardName = newValue;
                //                 gameCardValue= null;
                //               });
                //             },
                //             items: [0, 1, 2]
                //                 .map<DropdownMenuItem<String>>((int value) {
                //               return DropdownMenuItem<String>(
                //                 value: gameCardListLabel[value],
                //                 child: Text(
                //                   gameCardListLabel[value],
                //                   style: TextStyles.common_text,
                //                 ),
                //               );
                //             }).toList(),
                //           ),
                //         ),
                //       ),
                //       SizedBox(
                //         height: setHeight(15),
                //       ),
                //       Text(
                //         'Mệnh giá thẻ',
                //         style: TextStyles.common_text,
                //       ),
                //       SizedBox(
                //         height: setHeight(10),
                //       ),
                //       Container(
                //         height: setHeight(35),
                //         width: double.infinity,
                //         padding: EdgeInsets.only(left: setWidth(10)),
                //         decoration: BoxDecoration(
                //           border: Border.all(
                //             color: ColorUtils.BG_COLOR,
                //           ),
                //           borderRadius: BorderRadius.all(Radius.circular(10.0)),
                //         ),
                //         child: DropdownButtonHideUnderline(
                //           child: DropdownButton(
                //             value: gameCardValue,
                //             icon: Icon(Icons.keyboard_arrow_down),
                //             onChanged: (int newValue) {
                //               setState(() {
                //                 gameCardValue = newValue;
                //               });
                //             },
                //             items: (gameCardName == "Garena")
                //                 ? [
                //                     DropdownMenuItem<int>(
                //                       value: 20000,
                //                       child: Text(
                //                         '20,000',
                //                         style: TextStyles.common_text,
                //                       ),
                //                     ),
                //                   ]
                //                 : (gameCardName == "Zing")
                //                     ? [
                //                         DropdownMenuItem<int>(
                //                           value: 20000,
                //                           child: Text(
                //                             '20,000',
                //                             style: TextStyles.common_text,
                //                           ),
                //                         ),
                //                       ]
                //                     : [
                //                         DropdownMenuItem<int>(
                //                           value: 10000,
                //                           child: Text(
                //                             '10,000',
                //                             style: TextStyles.common_text,
                //                           ),
                //                         ),
                //                         DropdownMenuItem<int>(
                //                           value: 20000,
                //                           child: Text(
                //                             '20,000',
                //                             style: TextStyles.common_text,
                //                           ),
                //                         ),
                //                       ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                SizedBox(
                  height: setHeight(15),
                ),
                Text(
                  'Mật khẩu App Mamo',
                  style: FontUtils.NORMAL.copyWith(fontSize: setSp(12), color: ColorUtils.TEXT_NAME),
                ),
                SizedBox(
                  height: setHeight(10),
                ),
                Container(
                  height: setHeight(36),
                  decoration: BoxDecoration(
                    color: ColorUtils.underlined,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: TextField(
                    controller: _passController,
                    textAlignVertical: TextAlignVertical.bottom,
                    style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE),
                    obscureText: _isShowPassword,
                    decoration: InputDecoration(
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
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: ColorUtils.TEXT_NAME),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: setHeight(20),
                ),
                if (widget.payType == 1)
                  Text(
                    'Số tiền mỗi lần rút phải là bội số của 10000đ, ví dụ: 10000đ, 20000đ, 30000đ... Số tiền rút tối đa mỗi lần là 200000đ.',
                    style: FontUtils.NORMAL.copyWith(color: ColorUtils.NUMBER_PAGE),
                    textAlign: TextAlign.justify,
                  ),
                if (widget.payType == 2)
                  Text(
                    "Mã thẻ điện thoại sẽ được chúng tôi gửi tới ứng dụng ở trong mục Thông báo/Giao dịch và Lịch sử giao dịch/Rút tiền",
                    style: FontUtils.NORMAL.copyWith(color: ColorUtils.NUMBER_PAGE),
                    textAlign: TextAlign.justify,
                  ),
                // if (payType == 3)
                //   Text(
                //     "Mã thẻ game sẽ được chúng tôi gửi tới ứng dụng ở trong mục Thông báo/Giao dịch và Lịch sử giao dịch/Rút tiền",
                //     style: FontUtils.NORMAL.copyWith(color: ColorUtils.NUMBER_PAGE),
                //     textAlign: TextAlign.justify,
                //   ),
                SizedBox(
                  height: setHeight(20),
                ),

                Center(
                  child:
                  ButtonCustom(
                    onTap: (){requestPay();},
                    height: setHeight(42),
                    width: setWidth(200),
                     borderRadius: 12,
                    bgColor: ColorUtils.colorTextLogo,
                    title: "GỬI YÊU CẦU",
                    textStyle: FontUtils.MEDIUM.copyWith(color: ColorUtils.WHITE),
                  ),


                  // SimpleButton('Gửi yêu cầu', requestPay),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void requestPay() {
    // Navigator.pushReplacement(context,
    //     MaterialPageRoute(builder: (context) => RequestPaySuccess(amount)));
    if (widget.payType == 1) {
      if (GlobalCache().loginData.momoMobile == null ||
          GlobalCache().loginData.momoMobile.isEmpty ||
          GlobalCache().loginData.momoName == null ||
          GlobalCache().loginData.momoName.isEmpty) {
        updateMomoInfo();
        return;
      }
      if (_txtAmount.text.isEmpty) {
        Utilities.showToast(context, 'Bạn chưa nhập số tiền rút');
        return;
      }
      amount = int.parse(_txtAmount.text.replaceAll(',', ''));
      if ((amount % 10000) != 0) {
        Utilities.showToast(context, 'Số tiền rút phải là bội của 10,000đ');
        return;
      }
      if (amount < 10000 || amount > 200000 || amount > widget.balance) {
        Utilities.showToast(context, 'Số tiền rút không hợp lệ');
        return;
      }
      if (_passController.text.isEmpty) {
        Utilities.showToast(context, 'Bạn chưa nhập mật khẩu');
        return;
      }
      if (_passController.text != GlobalCache().userPassword) {
        Utilities.showToast(context, "Mật khẩu không đúng");
        return;
      }
      progressDialog.show().whenComplete(() => requestPayBloc.requestPay(
          amount: amount,
          dayRequest: DateTime.now().toString(),
          payType: widget.payType,
          telcoName: ""));
    }
    if (widget.payType == 2) {
      if (telcoName == null || telcoName.isEmpty) {
        Utilities.showToast(context, 'Bạn chưa chọn nhà mạng');
        return;
      }
      if (cardValue == null) {
        Utilities.showToast(context, 'Bạn chưa chọn mệnh giá thẻ');
        return;
      }
      if (cardValue > widget.balance) {
        Utilities.showToast(context, 'Mệnh giá thẻ không hợp lệ');
        return;
      }
      if (_passController.text != GlobalCache().userPassword) {
        Utilities.showToast(context, "Mật khẩu không đúng");
        return;
      }
      progressDialog.show().whenComplete(() => requestPayBloc.requestPay(
          amount: cardValue,
          dayRequest: DateTime.now().toString(),
          payType: widget.payType,
          telcoName: telcoName));
    }
    // if (payType == 3) {
    //   if (gameCardName == null || gameCardName.isEmpty) {
    //     Utilities.showToast(context, 'Bạn chưa chọn loại thẻ game');
    //     return;
    //   }
    //   if (gameCardValue == null) {
    //     Utilities.showToast(context, 'Bạn chưa chọn mệnh giá thẻ');
    //     return;
    //   }
    //   if (gameCardValue > widget.balance) {
    //     Utilities.showToast(context, 'Mệnh giá thẻ không hợp lệ');
    //     return;
    //   }
    //   if (_passController.text != GlobalCache().userPassword) {
    //     Utilities.showToast(context, "Mật khẩu không đúng");
    //     return;
    //   }
    //   progressDialog.show().whenComplete(() => requestPayBloc.requestPay(
    //       amount: gameCardValue,
    //       dayRequest: DateTime.now().toString(),
    //       payType: payType,
    //       telcoName: gameCardName));
    // }
  }

  void updateMomoInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        title: Text(' Cập nhật thông tin',
            style:
                FontUtils.MEDIUM.copyWith(color: ColorUtils.colorTextLogo, fontSize: setSp(15))),
        content: Text(
            'Bạn chưa nhập số điện thoại và tên tài khoản ví Momo, hãy cập nhật ngay để rút tiền hoặc chọn nhận thẻ cào điện thoại.',
            textAlign: TextAlign.justify,
            style: FontUtils.MEDIUM.copyWith(color: ColorUtils.TEXT_NAME, fontSize: setSp(14))),
        actions: [
          FlatButton(
            child: Text('Đóng',
                style:
                    FontUtils.BOLD.copyWith(color: ColorUtils.colorTextLogo, fontSize: setSp(14))),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Cập nhật',
                style:
                FontUtils.BOLD.copyWith(color: ColorUtils.colorTextLogo, fontSize: setSp(14))),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => UserProfileView()));
            },
          ),
        ],
      ),
    );
  }

  @override
  void onRequesting() async {
    await progressDialog.show();
    return;
  }

  @override
  void onSuccess(List<dynamic> response) async {
    await progressDialog.hide();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => RequestPaySuccess(amount: amount,telcoName: telcoName, payType: widget.payType, dayRequest: DateTime.now().toString(),)));
  }

  @override
  void onError(String message) async {
    await progressDialog.hide();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => RequestPayError(message)));
  }

  @override
  void dispose() {
    requestPayBloc.dispose();
    _txtAmount.dispose();
    _txtBalance.dispose();
    super.dispose();
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  CurrencyInputFormatter({this.maxDigits});
  final int maxDigits;

  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    if (maxDigits != null && newValue.selection.baseOffset > maxDigits) {
      return oldValue;
    }

    final formatter = NumberFormat.simpleCurrency(
        locale: "en_US", decimalDigits: 0, name: "");
    String newText = formatter.format(int.parse(newValue.text));
    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}
