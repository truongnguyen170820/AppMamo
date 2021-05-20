import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mamo/api/api_constants.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';


Widget viewImage(String url, num witdh, num height, BuildContext context,
    {bool isCircle = true,BoxFit boxFit= BoxFit.cover}) {
  return OptimizedCacheImage(
      height: (height),
      useScaleCacheManager: false,
      width: (witdh),
      placeholder: (context, url) => Container(
            width: (witdh),
            height: (height),
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          ),
      errorWidget: (context, url, error) => Image.asset(
            "assets/icons/ic_default_image.png",
            fit: boxFit,
            width: (witdh),
            height: (height),
          ),
      fit: BoxFit.cover,
      imageUrl: ApiConstants.shared.getFullImage(url == '' ? "" : url));
}
