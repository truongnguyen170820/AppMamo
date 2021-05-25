// import 'package:mamo/utils/text_styles.dart';
// import 'package:mamo/utils/color_utils.dart';
// import 'package:mamo/widget/global.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:photo_view/photo_view.dart';
//
// class ImageView extends StatefulWidget {
//   final String imagePath;
//
//   ImageView(this.imagePath);
//
//   @override
//   State<StatefulWidget> createState() => _ImageViewState();
// }
//
// class _ImageViewState extends State<ImageView> {
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorUtils.backgroundColor,
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: Icon(
//             Icons.arrow_back_ios,
//             size: 30,
//           ),
//         ),
//         title: Text(
//           'Xem chi tiết ảnh',
//           style: TextStyles.appbar_text,
//         ),
//         centerTitle: true,
//         // actions: <Widget>[
//         //   FlatButton(
//         //     color: ColorUtils.transparent,
//         //     child: Text(
//         //       "Đóng",
//         //       style: TextStyles.appbar_text,
//         //     ),
//         //     onPressed: () {
//         //       Navigator.pop(context);
//         //     },
//         //   )
//         // ],
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage("assets/images/appbar_bg.png"),
//               fit: BoxFit.fill,
//             ),
//           ),
//         ),
//         textTheme: TextTheme(
//             headline6: TextStyle(color: Colors.white, fontSize: setSp(17))),
//         iconTheme: IconThemeData(color: Colors.white),
//         elevation: 0.0,
//       ),
//       body: SafeArea(
//         child: Container(
//           child: PhotoView(
//             imageProvider: NetworkImage(
//               widget.imagePath,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
// }
