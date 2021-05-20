import 'package:mamo/api/api_constants.dart';
import 'package:mamo/blocs/user/get_account_bloc.dart';
import 'package:mamo/blocs/user/get_user_profile_bloc.dart';
import 'package:mamo/blocs/user/upload_image_bloc.dart';
import 'package:mamo/model/user/user_profile_model.dart';
import 'package:mamo/utils/font_utils.dart';
import 'package:mamo/utils/text_styles.dart';
import 'package:mamo/utils/app_constant.dart';
import 'package:mamo/utils/app_utils.dart';
import 'package:mamo/utils/global_cache.dart';
import 'package:mamo/utils/utilities.dart';
import 'package:mamo/views/user/achievements_page.dart';
import 'package:mamo/views/user/update_avatar_view.dart';
import 'package:mamo/views/user/update_profile_view.dart';
import 'package:mamo/widget/circle_avatar.dart';
import 'package:mamo/widget/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/views/user/change_password_view.dart';
import 'package:mamo/widget/common_appbar.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:heic_to_jpg/heic_to_jpg.dart';
import 'package:mamo/widget/showMessage.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class UserProfileView extends StatefulWidget {
  @override
  _UserProfileViewState createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  GetUserProfileBloc bloc;
  Permission permission;
  GetAccountBloc getAccountBloc = GetAccountBloc();
  @override
  void initState() {
    super.initState();
    bloc = GetUserProfileBloc();
    getAccountBloc.getAccount(context);
  }



  UserProfileModel loadFromCache() {
    var userInfo = UserProfileModel();
    userInfo.fullName = GlobalCache().loginData.fullName;
    userInfo.email = GlobalCache().loginData.email;
    userInfo.mobile = GlobalCache().loginData.mobile;
    userInfo.avatarUrl = GlobalCache().loginData.avatarUrl;
    userInfo.birthdayStr = GlobalCache().loginData.birthday;
    userInfo.address = GlobalCache().loginData.address;
    userInfo.momoMobile = GlobalCache().loginData.momoMobile;
    userInfo.momoName = GlobalCache().loginData.momoName;
    return userInfo;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bloc.getProfile(context);
    return Scaffold(
      body: StreamBuilder(
        stream: bloc.getProfileStream,
        initialData: loadFromCache(),
        builder: (context, snapshot) {
          UserProfileModel userInfo = snapshot.data;
          GlobalCache().loginData.fullName = userInfo.fullName;
          GlobalCache().loginData.email = userInfo.email;
          GlobalCache().loginData.gender = userInfo.gender;
          GlobalCache().loginData.avatarUrl = userInfo.avatarUrl;
          GlobalCache().loginData.birthday = userInfo.birthdayStr;
          GlobalCache().loginData.address = userInfo.address;
          GlobalCache().loginData.momoName = userInfo.momoName;
          GlobalCache().loginData.momoMobile = userInfo.momoMobile;
          return SafeArea(
            top: false,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: setHeight(200),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(getAssetsImage("bg_profile.png")),
                      fit: BoxFit.cover
                    ),
                  ),
                ),
                Positioned(
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: setHeight(160),
                          decoration: BoxDecoration(
                            // color: ColorUtils.colorTextLogo,
                            image: DecorationImage(
                              image: AssetImage(
                                  getAssetsImage("bg_profile.png")),
                              fit: BoxFit.cover,
                            ),
                          ),
                          // color: ColorUtils.BG_ICOn,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  circleAvatar(GlobalCache()
                                      ?.loginData
                                      ?.avatarUrl,GlobalCache()?.loginData?.fullName??""),
                                  // CircleAvatar(
                                  //   radius: setWidth(45),
                                  //   backgroundImage:
                                  //       CachedNetworkImageProvider(
                                  //           ApiConstants.shared.getFullImage(
                                  //               GlobalCache()
                                  //                   .loginData
                                  //                   .avatarUrl)),
                                  // ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () async {
                                        //todo test
                                        // var status = await Permission.accessMediaLocation.request();
                                        // // var status = await Permission.accessMediaLocation.status;
                                        // if (status == PermissionStatus.granted){
                                        //   Utilities.showToast(context, "bạn đã cho phép truy cập ảnh");
                                        // } else showDialog(
                                        //     context: context,
                                        //     builder: (BuildContext context) => CupertinoAlertDialog(
                                        //       title: Text('Truy cập thông tin ảnh'),
                                        //       content: Text(
                                        //           'Ứng dụng cần bạn cho phép truy cập thông tin ảnh'),
                                        //       actions: <Widget>[
                                        //         CupertinoDialogAction(
                                        //           child: Text('Từ chối'),
                                        //           onPressed: () => Navigator.of(context).pop(),
                                        //         ),
                                        //         CupertinoDialogAction(
                                        //           child: Text('Cài đặt'),
                                        //           onPressed: () => openAppSettings(),
                                        //         ),
                                        //       ],
                                        //     ));
                                        List<Asset> resultList =
                                        await MultiImagePicker.pickImages(
                                            maxImages: 1,
                                            enableCamera: true);
                                        if (!mounted) return;
                                        if (resultList.length > 0) {
                                          var image = resultList.first;
                                          upLoadImage(image);
                                        }
                                      },
                                      child: CircleAvatar(
                                          radius: setWidth(12),
                                          backgroundColor:
                                          ColorUtils.TEXT_PRICE,
                                          child: Image.asset(
                                              getAssetsIcon("cloud.png"))),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: setHeight(5)),
                              Text(userInfo.fullName ?? "",
                                style: FontUtils.BOLD.copyWith(color: ColorUtils.WHITE),
                              ),
                              Text(userInfo.userName ?? '',
                                  style: FontUtils.MEDIUM.copyWith(color: ColorUtils.WHITE, fontSize: setSp(12))
                              ),
                              SizedBox(
                                height: setHeight(8),
                              )
                            ],
                          ),
                        ),
                        StreamBuilder(
                            stream: getAccountBloc.getAccountStream,
                            builder: (context, snapshot) {
                              return GestureDetector(
                                onTap: (){
                                  pushTo(context, AchievementsBoard());
                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>AchievementsBoard()));
                                },
                                child: Container(
                                    width: MediaQuery.of(context).size.width -
                                        setWidth(16),
                                    height: setHeight(68),
                                    margin: EdgeInsets.fromLTRB(
                                        setWidth(16), 0, setWidth(16), setHeight(8)),
                                    padding: EdgeInsets.only(
                                        top: setHeight(16),
                                        bottom: setHeight(16),
                                        left: setWidth(15),
                                        right: setWidth(15)),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: ColorUtils.WHITE, width: 1),
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorUtils.gray.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(
                                              0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text("Tổng thu nhập",
                                                style: FontUtils.MEDIUM.copyWith(
                                                    color: ColorUtils.TEXT_NAME,
                                                    fontSize: setSp(12))),
                                            Text(
                                              Utilities.formatMoney(GlobalCache().loginData.account.totalBalance??"", suffix: 'đ'),
                                              style: FontUtils.BOLD.copyWith(
                                                  color: ColorUtils.TEXT_PRICE),
                                            )
                                          ],
                                        ),
                                        SizedBox(width: setWidth(60)),
                                        Column(
                                          children: [
                                            Text("Ví hiện tại",
                                                style: FontUtils.MEDIUM.copyWith(
                                                    color: ColorUtils.TEXT_NAME,
                                                    fontSize: setSp(12))),
                                            Text(
                                              Utilities.formatMoney(GlobalCache().loginData.account.balance??"",suffix: 'đ'),
                                              style: FontUtils.BOLD.copyWith(
                                                  color: ColorUtils.TEXT_PRICE),
                                            )
                                          ],
                                        ),
                                        Spacer(),
                                        Row(
                                          children: [
                                            Text(
                                              "Chi tiết",
                                              style: FontUtils.MEDIUM.copyWith(
                                                  color: ColorUtils.colorTextLogo),
                                            ),
                                            SizedBox(width: setWidth(4)),
                                            Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              size: setSp(16),
                                              color: ColorUtils.colorTextLogo,
                                            )
                                          ],
                                        )
                                      ],
                                    )),
                              );
                            }
                        ),
                        SizedBox(height: setHeight(5)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildItemMenu("Ngày sinh", "datebirth.png",
                                userInfo.birthdayStr ?? ""),
                            _buildItemMenu("Giới tính", "sex.png",
                                userInfo.gender ?? ""),
                            _buildItemMenu("Địa chỉ", "address.png",
                                userInfo.address ?? ""),
                            _buildItemMenu(
                                "Email", "email.png", userInfo.email ?? ""),
                            _buildItemMenu("SĐT momo", "phone.png",
                                userInfo.momoMobile ?? ""),
                            _buildItemMenu("Tên TK Momo", "logo_momo.png",
                                userInfo.momoName ?? ""),
                            Container(
                              margin: EdgeInsets.only(left: setWidth(16), top: setHeight(22), bottom: setHeight(22)),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChangePasswordView()));
                                },
                                child: Text(
                                  "Đổi mật khẩu",
                                  style: FontUtils.MEDIUM.copyWith(
                                      color: ColorUtils.colorTextLogo),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: setHeight(30),
                    child: _custonAppBar(size)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _custonAppBar(Size size) {
    // return AppBar(
    //   backgroundColor: ColorUtils.red1,
    // );
    return Container(
      padding: EdgeInsets.only(left: setWidth(15), right: setWidth(30)),
      width: size.width,
      child: Row(
        children: [
          IconButton(
              icon: Icon(
                Icons.arrow_back_outlined,
                color: ColorUtils.WHITE,
                size: setSp(20),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          Spacer(),
          InkWell(
              onTap: () {
                pushTo(context, UpdateProfileView());
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => UpdateProfileView()));
              },
              child: Image.asset(
                getAssetsIcon("editProfile.png"),
                width: setWidth(21),
                height: setHeight(19),
              ))
        ],
      ),
    );
  }

  _buildItemMenu(String name, String imageUrl, String lable) {
    return Container(
      margin: EdgeInsets.only(
          left: setWidth(16), right: setWidth(16)),
      padding: EdgeInsets.only(bottom: setHeight(16), top: setHeight(19)),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 1, color: ColorUtils.underlined))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Image.asset(getAssetsIcon(imageUrl),
              height: setHeight(19), width: setWidth(17)),
          SizedBox(width: setWidth(16)),
          Text(
            name,
            style: FontUtils.NORMAL.copyWith(color: ColorUtils.TEXT_NAME),
          ),
          Spacer(),
          Container(
              width: setWidth(200),
              child: Text(lable, style: FontUtils.MEDIUM, overflow: TextOverflow.ellipsis,textAlign: TextAlign.right,))
        ],
      ),
    );
  }
  upLoadImage(Asset asset) async {
    final filePath =
        await FlutterAbsolutePath.getAbsolutePath(asset.identifier);
    //todo test
    // final metaData = await asset.metadata;
    // print("metadata:" + metaData.exif.dateTimeOriginal??"ko có thông tin");
    // final createDate = FileStat.statSync(filePath).modified;
    // print("ngày tạo: " + filePath + createDate.toString());
//     print("-----------" + asset.originalCreateDate.toString());
//     Duration duration = DateTime.now().difference(asset.originalCreateDate);
// print("${duration.inMinutes}");
    if (filePath != null) {
      File file;
      if (filePath.toLowerCase().endsWith("heic")) {
        file = File(await HeicToJpg.convert(filePath));
      } else {
        file = File(filePath);
      }

      var bufferFile = await Utilities.compress(
          file.path, await Utilities.getQuantity(file.path));
      if (bufferFile == null) {
        Utilities.showToast(context, "Có lỗi khi tải ảnh");
        return;
      }
      // ignore: unrelated_type_equality_checks
      UploadImageBloc().uploadFileMultiPart(bufferFile, file).then(
        (response) async {
          if (response.data.ErrorCode == AppConstants.ERROR_CODE_SUCCESS) {
            if (response.data.Data.length > 0) {
              String imgPath = await AppUtils.shared.pushWidgetValueReturn(
                  context, UpdateAvatar(response.data.Data[0]));
              if (imgPath != null && imgPath.isNotEmpty) {
                setState(() {});
              }
            }
          } else {
            Utilities.showToast(
                context,
                (response.data.ErrorMessage ?? "").isEmpty
                    ? response.data.ErrorCode
                    : response.data.ErrorMessage);
          }
        },
      );
    }
    // final bytes = File(filePath).readAsBytesSync();
    // String img64 = base64Encode(bytes);
    // UploadImageBloc().uploadFile(filePath, img64).then((response) async {
    //   if (response.ErrorCode == AppConstants.ERROR_CODE_SUCCESS) {
    //     if (response.Data.length > 0) {
    //       String imgPath = await AppUtils.shared
    //           .pushWidgetValueReturn(context, UpdateAvatar(response.Data[0]));
    //       if (imgPath != null && imgPath.isNotEmpty) {
    //         setState(() {});
    //       }
    //     }
    //   } else {
    //     Utilites.showToast(
    //         context,
    //         (response.ErrorMessage ?? "").isEmpty
    //             ? response.ErrorCode
    //             : response.ErrorMessage);
    //   }
    // });
  }
  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }
}
