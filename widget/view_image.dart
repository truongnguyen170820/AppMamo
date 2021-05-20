import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

Widget networkImage(String url, double width, double height,
    {double radius = 5, String assetImg = "assets/icons/ic_default_image.png"}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(radius),
    child:  CachedNetworkImage(
          imageUrl:url,
          height: (height),
          width: (width),
          placeholder: (context, url) => Container(
            width: (width),
            height: (height),
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          ),
          errorWidget: (context, url, error) => Image.asset(
              assetImg,
              fit: BoxFit.cover,
              width: (width),
              height: (height)),
          fit: BoxFit.cover,)
  );
}


