import 'dart:io';
import 'package:mamo/api/api_constants.dart';
import 'package:mamo/blocs/impl/api_result_listener.dart';
import 'package:mamo/blocs/user/update_avatar_bloc.dart';
import 'package:mamo/blocs/user/upload_image_bloc.dart';
import 'package:mamo/utils/font_utils.dart';
import 'package:mamo/utils/text_styles.dart';
import 'package:mamo/utils/app_constant.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/utils/global_cache.dart';
import 'package:mamo/utils/screen/screen_utils.dart';
import 'package:mamo/utils/utilities.dart';
import 'package:mamo/widget/global.dart';
import 'package:mamo/widget/progress_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:heic_to_jpg/heic_to_jpg.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';

class UpdateAvatar extends StatefulWidget {
  final String imagePath;

  UpdateAvatar(this.imagePath);

  @override
  State<StatefulWidget> createState() => _UpdateAvatarState(this.imagePath);
}

class _UpdateAvatarState extends State<UpdateAvatar>
    implements ApiResultListener<String> {
  String imagePath;
  ChangeAvatarBloc bloc = ChangeAvatarBloc();
  ProgressDialog _progressDialog;

  _UpdateAvatarState(this.imagePath);

  @override
  void initState() {
    super.initState();
    _progressDialog = progDialog(context, message: "Cập nhật...");
    bloc.setListener(this);
  }

  upLoadImage(Asset asset) async {
    final filePath =
        await FlutterAbsolutePath.getAbsolutePath(asset.identifier);
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
            (response) {
          if (response.data.ErrorCode == AppConstants.ERROR_CODE_SUCCESS) {
            this.setState(() {
              imagePath = response.data.Data[0];
            });
            Utilities.showToast(context, "Chọn ảnh thành công");
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
    //
    // // ignore: unrelated_type_equality_checks
    // UploadImageBloc().uploadFile(filePath, img64).then((response) {
    //       if (response.ErrorCode == AppConstants.ERROR_CODE_SUCCESS)
    //         {
    //           this.setState(() {
    //             imagePath = response.Data[0];
    //           });
    //         }
    //       else
    //         {
    //           Utilites.showToast(
    //               context, (response.ErrorMessage ?? response.ErrorCode));
    //         }
    //     });
  }

  @override
  Widget build(BuildContext context) {
    var avatarRadius = 90;
    return Scaffold(
      backgroundColor: ColorUtils.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorUtils.colorTextLogo,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            size: 30,
          ),
        ),
        title: Text(
          'Đổi ảnh đại diện',
          style: FontUtils.MEDIUM.copyWith(color: ColorUtils.WHITE, fontSize: setSp(18)),
        ),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            color: ColorUtils.transparent,
            child: Text(
              "Lưu",
              style: FontUtils.MEDIUM.copyWith(color: ColorUtils.WHITE, fontSize: setSp(18)),
            ),
            onPressed: () {
              _progressDialog.show().then((value) {
                print("đường dẫn: $imagePath");
                bloc.updateAvatar(this.imagePath);
              });
            },
          )
        ],
        // flexibleSpace: Container(
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage("assets/images/appbar_bg.png"),
        //       fit: BoxFit.fill,
        //     ),
        //   ),
        // ),
        textTheme: TextTheme(
            headline6: TextStyle(color: Colors.white, fontSize: setSp(17))),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: setHeight(120)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: ScreenUtil().setHeight(avatarRadius),
                    child: CircleAvatar(
                      radius: setHeight(avatarRadius - 3),
                      backgroundImage: CachedNetworkImageProvider(
                          ApiConstants.shared.getFullImage(imagePath)),
                    ),
                  ),
                  Positioned(
                    right: setWidth(10),
                    bottom: setWidth(10),
                    child: GestureDetector(
                      onTap: () async {
                        List<Asset> resultList =
                            await MultiImagePicker.pickImages(
                                maxImages: 1, enableCamera: true);
                        if (!mounted) return;
                        if (resultList.length > 0) {
                          var image = resultList.first;
                          upLoadImage(image);
                        }
                      },
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: ColorUtils.backgroundBoldColor,
                        child: Icon(
                          Icons.camera_alt,
                          size: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  void onError(String message) async {
    await _progressDialog.hide();
    Utilities.showToast(context, message);
  }

  @override
  void onRequesting() async {}

  @override
  void onSuccess(List<String> response) async {
    await _progressDialog.hide();
    GlobalCache().loginData.avatarUrl = imagePath;
    Navigator.pop(context, imagePath);
  }
}
