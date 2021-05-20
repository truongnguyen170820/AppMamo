import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mamo/api/api_constants.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/utils/font_utils.dart';
import 'package:mamo/utils/utilities.dart';

import 'global.dart';

Widget circleAvatar1(String path, {double radius = 36}) {
  if (path == null || path == "")
    return CircleAvatar(
      radius: setWidth(radius),
      backgroundImage: AssetImage("assets/images/avatar.jpg"),
    );
  return CircleAvatar(
    radius: setWidth(radius),
    backgroundImage:
        CachedNetworkImageProvider(ApiConstants.shared.getFullImage(path)),
  );
}
Widget circleAvatar(String path,String replaceName,{double radius = 36}) {
  radius = setWidth(radius);
  return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        width: radius*2,
        height: radius*2,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => Container(
          child: Center(
            child: Text(Utilities.getAcronym(replaceName).toUpperCase(),style: FontUtils.SEMIBOLD.copyWith(color: Colors.white),),
          ),
          color: ColorUtils.DEFAULT_AVATAR_COLOR[Utilities.getRandomNumber(replaceName, ColorUtils.DEFAULT_AVATAR_COLOR.length)],
          width: radius*2,
          height: radius*2,
        ),
        imageUrl:  ApiConstants.shared.getFullImage(path),
      )
  );
}