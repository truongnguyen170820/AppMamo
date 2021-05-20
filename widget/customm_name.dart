import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mamo/widget/global.dart';

class CustomName extends StatelessWidget {
  final  String name;
  final double size;
      final Color color;

  const CustomName({Key key, this.name, this.size, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    int count= 0;
    int index =0;
    for(int i =0; i < name.length; i++) {
      if(name[i] == ' '){
        count = i;
        index ++;
      }
      if(index ==2) {
        break;
      }
    }
    String newString  = index == 2 ? name.substring(0, count) +'\n' +name.substring(count+1, name.length) : name;
    return Text(newString, textAlign: TextAlign.center,maxLines: 2,style: GoogleFonts.roboto(fontSize: setSp(size), color: color),) ;
  }
}
