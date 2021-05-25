import 'package:mamo/blocs/impl/api_result_listener.dart';
import 'package:mamo/blocs/user/update_profile_bloc.dart';
import 'package:mamo/utils/font_utils.dart';
import 'package:mamo/utils/text_styles.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/utils/utilities.dart';
import 'package:mamo/utils/validator_utils.dart';
import 'package:mamo/widget/common_appbar.dart';
import 'package:mamo/widget/custombutton.dart';
import 'package:mamo/widget/global.dart';
import 'package:mamo/utils/global_cache.dart';
import 'package:mamo/widget/image_button.dart';
import 'package:mamo/widget/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

class UpdateProfileView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UpdateProfileViewState();
}

class UpdateProfileViewState extends State<UpdateProfileView>
    with ApiResultListener {
  UpdateProfileBloc updateProfileBloc = UpdateProfileBloc();
  ProgressDialog progressDialog;
  String _radioValue;

  TextEditingController _txtName = TextEditingController();
  TextEditingController _txtEmail = TextEditingController();
  TextEditingController _txtBirthdayStr = TextEditingController();
  TextEditingController _txtAddress = TextEditingController();
  TextEditingController _txtMomoMobile = TextEditingController();
  TextEditingController _txtMomoName = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    var userInfo = GlobalCache().loginData;
    _txtName.text = userInfo.fullName;
    _txtEmail.text = userInfo.email;
    _txtBirthdayStr.text = userInfo.birthday;
    _txtAddress.text = userInfo.address;
    _txtMomoMobile.text = userInfo.momoMobile;
    _txtMomoName.text = userInfo.momoName;
    progressDialog = progDialog(context, message: "Cập nhật...");
    updateProfileBloc.onUpdateProfileListen(this);
    if (userInfo.gender != null && userInfo.gender.isNotEmpty)
      _radioValue = userInfo.gender;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarDefault(context, 'Chỉnh sửa thông tin', bgColor: ColorUtils.WHITE, ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: Container(
              color: ColorUtils.WHITE,
              padding: EdgeInsets.all(setWidth(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: setWidth(0)),
                    child: Text(
                      'Họ tên',
                      style: FontUtils.NORMAL.copyWith(fontSize: setSp(12), color: ColorUtils.TEXT_NAME),
                    ),
                  ),
                  SizedBox(height: setHeight(8)),
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                      color: ColorUtils.underlined,
                        border: Border.all(width: 1, color: ColorUtils.gray6),
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: TextField(
                      controller: _txtName,
                      style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE),
                      // textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Nhập họ và tên tại đây',
                        hintStyle: TextStyles.hint,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: setWidth(22)),
                    child: Text(
                      'Ngày sinh',
                      style: FontUtils.NORMAL.copyWith(fontSize: setSp(12), color: ColorUtils.TEXT_NAME),
                    ),
                  ),
                  SizedBox(height: setHeight(8)),
                  Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 16),
                        decoration: BoxDecoration(
                            color: ColorUtils.underlined,
                            border: Border.all(width: 1, color: ColorUtils.gray6),
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: TextField(
                          controller: _txtBirthdayStr,
                          style: TextStyles.common_black,
                          // textAlign: TextAlign.start,
                          // textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'dd/mm/yyyy',
                            hintStyle: TextStyles.hint,
                          ),
                        ),
                      ),
                      Positioned(
                        right: setWidth(14),
                        child: InkWell(
                          onTap: (){
                            _selectDate(context, _txtBirthdayStr);
                          },
                          child: Image.asset(getAssetsIcon("datebirth.png"), height: setHeight(19),),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: setHeight(22)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Giới tính',
                        style: FontUtils.NORMAL.copyWith(fontSize: setSp(12), color: ColorUtils.TEXT_NAME)),
                      Row(
                        children: <Widget>[
                          Container(
                            // alignment: Alignment.centerRight,
                            child: Radio(
                                activeColor: ColorUtils.BG_ICOn,
                                value: 'Nam',
                                groupValue: _radioValue,
                                onChanged: (value) {
                                  setState(() {
                                    _radioValue = value;
                                  });
                                }),
                          ),
                          Text('Nam', style: TextStyles.common_black),
                          Radio(
                              activeColor: ColorUtils.BG_ICOn,
                              value: 'Nữ',
                              groupValue: _radioValue,
                              onChanged: (value) {
                                setState(() {
                                  _radioValue = value;
                                });
                              }),
                          Text('Nữ', style: TextStyles.common_black)
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: setWidth(20)),
                    child: Text(
                      'Địa chỉ',
                      style: FontUtils.NORMAL.copyWith(fontSize: setSp(12), color: ColorUtils.TEXT_NAME),
                    ),
                  ),
                  SizedBox(height: setHeight(8)),
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                        color: ColorUtils.underlined,
                        border: Border.all(width: 1, color: ColorUtils.gray6),
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: TextField(
                      controller: _txtAddress,
                      style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE),
                      textAlign: TextAlign.start,
                      // textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Nhập địa chỉ tại đây',
                        hintStyle: TextStyles.hint,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: setWidth(20)),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Email',
                          style: FontUtils.NORMAL.copyWith(fontSize: setSp(12), color: ColorUtils.TEXT_NAME),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: setHeight(8)),
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                        color: ColorUtils.underlined,
                        border: Border.all(width: 1, color: ColorUtils.gray6),
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: TextField(
                      controller: _txtEmail,
                      style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE),
                      textAlign: TextAlign.start,
                      // textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Nhập địa chỉ email tại đây',
                        hintStyle: TextStyles.hint,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: setWidth(20)),
                    child: Text(
                      'SĐT Momo',
                      style: FontUtils.NORMAL.copyWith(fontSize: setSp(12), color: ColorUtils.TEXT_NAME),
                    ),
                  ),
                  SizedBox(height: setHeight(8)),
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                        color: ColorUtils.underlined,
                        border: Border.all(width: 1, color: ColorUtils.gray6),
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: TextField(
                      controller: _txtMomoMobile,
                      style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE),
                      textAlign: TextAlign.start,
                      // textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Nhập số điện thoại Momo',
                        hintStyle: TextStyles.hint,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: setWidth(20)),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Tên tài khoản Momo',
                          style: FontUtils.NORMAL.copyWith(fontSize: setSp(12), color: ColorUtils.TEXT_NAME),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: setHeight(8)),
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                        color: ColorUtils.underlined,
                        border: Border.all(width: 1, color: ColorUtils.gray6),
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: TextField(
                      controller: _txtMomoName,
                      style: FontUtils.MEDIUM.copyWith(color: ColorUtils.NUMBER_PAGE),
                      textAlign: TextAlign.start,
                      // textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: 'Nhập tên Momo',
                        border: InputBorder.none,
                        hintStyle: TextStyles.hint,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: setHeight(30),
                  ),
                  Center(
                    child: ButtonCustom(
                      title: "LƯU LẠI",
                      textStyle: FontUtils.MEDIUM.copyWith(color: ColorUtils.WHITE),
                      height: setHeight(42),
                      width: setWidth(200),
                      borderRadius: 12,
                      onTap: (){
                        updateProfile();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void updateProfile() {
    FocusScope.of(context).requestFocus(FocusNode());
    updateProfileBloc.onUpdateProfileListen(this);
    if (_txtName.text.trim().isEmpty) {
      Utilities.showToast(context, 'Bạn chưa nhập họ và tên');
      return;
    }
    if (_radioValue == null || _radioValue.isEmpty) {
      Utilities.showToast(context, 'Bạn chưa chọn giới tính');
      return;
    }
    if (_txtAddress.text.trim().isEmpty) {
      Utilities.showToast(context, 'Bạn chưa nhập địa chỉ');
      return;
    }
    if (_txtEmail.text.isEmpty) {
      Utilities.showToast(context, 'Bạn chưa nhập email');
      return;
    }
    if (!Validator.instance.IsEmail(_txtEmail.text)) {
      Utilities.showToast(context, 'Email không hợp lệ');
      return;
    }
    progressDialog.show().whenComplete(() => updateProfileBloc.onUpdateProfile(
        _txtName.text,
        _txtAddress.text,
        _radioValue,
        _txtBirthdayStr.text ?? '',
        _txtEmail.text,
        _txtMomoMobile.text,
        _txtMomoName.text));
  }

  @override
  void onRequesting() async {
    await progressDialog.show();
    return;
  }

  @override
  void onSuccess(List<dynamic> response) async {
    setState(() {

    });
    await progressDialog.hide();
    Navigator.pop(context);
    Utilities.showToast(context, 'Cập nhật thành công');

  }

  @override
  void onError(String message) async {
    await progressDialog.hide();
    Utilities.showToast(context, message);
  }


  Future<Null> _selectDate(BuildContext context, TextEditingController txtController) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1970, 8),
        lastDate: DateTime(2101));
    if (picked != null &&
        DateFormat('dd/MM/yyyy').format(picked) != txtController.text)
      setState(() {
        // selectedDate = picked;
        txtController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
  }

  @override
  void dispose() {
    updateProfileBloc.dispose();
    _txtBirthdayStr.dispose();
    _txtEmail.dispose();
    _txtAddress.dispose();
    _txtName.dispose();
    super.dispose();
  }
}
