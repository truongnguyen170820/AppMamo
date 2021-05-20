import 'package:flutter/material.dart';
import 'package:mamo/utils/text_styles.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'global.dart';

ProgressDialog progDialog(BuildContext context,{String message = "Đang tải..."}) {
  ProgressDialog progressDialog = ProgressDialog(context, isDismissible: false);
  progressDialog.style(
    message: message,
    messageTextStyle: TextStyles.progress_text,
    backgroundColor: ColorUtils.backgroundColor,
    progressWidget: Container(
      padding: EdgeInsets.all(setWidth(8)),
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(ColorUtils.colorTextLogo),
      ),
    ),
  );
  return progressDialog;
}