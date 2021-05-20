import 'package:flutter/material.dart';
import 'package:mamo/utils/screen/screen_utils.dart';
import 'package:mamo/widget/animation_pushto.dart';


class Global {
}
setHeight(num value) {
  return ScreenUtil().setHeight(value);
}

setWidth(num value) {
  return ScreenUtil().setWidth(value);
}

setSp(num value) {
  return ScreenUtil().setSp(value);
}

void dismissKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}

String getAssetsIcon(String icon){
  return "assets/icons/" + icon;
}

String getAssetsImage(String image){
  return "assets/images/" + image;
}
void pop(BuildContext context, {dynamic result}) {
  Navigator.pop(
    context,
    result,
  );}

pushTo(BuildContext context,Widget widget,{bool isReturn=false} )async{
  dynamic result;
  if(isReturn)result=await Navigator.push(context, SlideRightRoute(page: widget,),);
  else result = Navigator.push(context, SlideRightRoute(page: widget,),);
  return  result;
}



// void pushTo(BuildContext context,Widget widget, ){
//   Navigator.push(context, SlideRightRoute(page: widget,),);
// }
