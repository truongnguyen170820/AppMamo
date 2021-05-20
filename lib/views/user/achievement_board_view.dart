// import 'package:mamo/blocs/user/get_account_bloc.dart';
// import 'package:mamo/utils/text_styles.dart';
// import 'package:mamo/utils/color_utils.dart';
// import 'package:mamo/utils/global_cache.dart';
// import 'package:mamo/views/user/item/member_benifit_view.dart';
// import 'package:mamo/views/user/request_pay_view.dart';
// import 'package:mamo/views/user/transaction_history_view.dart';
// import 'package:mamo/widget/global.dart';
// import 'package:mamo/widget/image_button.dart';
// import 'package:flutter/material.dart';
// import 'package:mamo/widget/common_appbar.dart';
// import 'package:intl/intl.dart';
//
// class AchievementView extends StatefulWidget {
//   @override
//   _AchievementViewState createState() => _AchievementViewState();
// }
//
// class _AchievementViewState extends State<AchievementView> {
//   GetAccountBloc getAccountBloc = GetAccountBloc();
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     getAccountBloc.getAccount(context);
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: transAppBar(context, 'Bảng thành tích'),
//       body: StreamBuilder(
//         stream: getAccountBloc.getAccountStream,
//         initialData: GlobalCache().loginData.account,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) GlobalCache().loginData.account = snapshot.data;
//           NumberFormat nf = NumberFormat("###,###,###", "en_US");
//           double progressValue = 0.0;
//           String pointRemainDesc = '';
//           Color progressColor;
//           String backgroundPath;
//           String iconPath;
//           switch (GlobalCache().loginData.account.level) {
//             case 1:
//               {
//                 backgroundPath = "assets/images/level1.png";
//                 iconPath = "assets/icons/achievement/ic_level1.png";
//                 progressValue = GlobalCache().loginData.account.point /
//                     GlobalCache().loginData.account.pointLevel1;
//                 progressColor = Colors.lightGreen;
//                 if (GlobalCache().loginData.account.pointLevel1 <=
//                     GlobalCache().loginData.account.point) {
//                   pointRemainDesc =
//                       "Hãy giới thiệu đủ 10 thành viên cấp 1 (mỗi thành viên phải làm ít nhất 10 nhiệm vụ) để trở thành thành viên Vàng";
//                 } else
//                   pointRemainDesc =
//                       'Giới thiệu đủ 10 thành viên cấp 1 (mỗi thành viên phải làm ít nhất 10 nhiệm vụ) và tích lũy thêm ${GlobalCache().loginData.account.pointLevel1 - GlobalCache().loginData.account.point} điểm để trở thành thành viên Vàng';
//               }
//               break;
//             case 2:
//               {
//                 backgroundPath = "assets/images/level2.png";
//                 iconPath = "assets/icons/achievement/ic_level2.png";
//                 progressValue = GlobalCache().loginData.account.point /
//                     GlobalCache().loginData.account.pointLevel2;
//                 progressColor = Colors.orangeAccent;
//                 if (GlobalCache().loginData.account.pointLevel2 <=
//                     GlobalCache().loginData.account.point) {
//                   pointRemainDesc =
//                       "Hãy giới thiệu đủ 50 thành viên cấp 1 (mỗi thành viên phải làm ít nhất 10 nhiệm vụ) để trở thành thành viên Kim cương";
//                 } else
//                   pointRemainDesc =
//                       'Giới thiệu đủ 50 thành viên cấp 1 (mỗi thành viên phải làm ít nhất 10 nhiệm vụ) và tích lũy thêm ${GlobalCache().loginData.account.pointLevel2 - GlobalCache().loginData.account.point} điểm để trở thành thành viên Kim cương';
//               }
//               break;
//             case 3:
//               {
//                 backgroundPath = "assets/images/level3.png";
//                 iconPath = "assets/icons/achievement/ic_level3.png";
//                 progressValue = (GlobalCache().loginData.account.point /
//                     GlobalCache().loginData.account.pointLevel3);
//                 progressColor = ColorUtils.blueAccent2;
//                 pointRemainDesc =
//                     'Giới thiệu thành viên và tích lũy thêm điểm để có thêm nhiều ưu đãi từ Cây Khế';
//               }
//               break;
//           }
//           return Column(
//             children: [
//               Container(
//                 width: double.infinity,
//                 height: setHeight(180), //216
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(backgroundPath),
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.only(
//                           left: setWidth(18), right: setWidth(18), bottom: 0),
//                       child: Image.asset(
//                         iconPath,
//                         width: setWidth(94),
//                         height: setHeight(87),
//                       ),
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(GlobalCache().loginData.fullName??GlobalCache().loginData.userName,
//                             style: TextStyle(
//                                 color: Colors.white, fontSize: setSp(17))),
//                         Text(
//                           (GlobalCache().loginData.account.level == 1)
//                               ? "Thành viên Chuẩn"
//                               : (GlobalCache().loginData.account.level == 2)
//                                   ? "Thành viên Vàng"
//                                   : 'Thành viên Kim cương',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         SizedBox(
//                           height: setHeight(30),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: ListView(
//                   padding: EdgeInsets.only(top: 0),
//                   children: [
//                     Container(
//                       padding: EdgeInsets.only(
//                           left: setWidth(16),
//                           top: setHeight(10),
//                           right: setWidth(16)),
//                       child: Text(
//                         'Tích thật nhiều điểm để nhận được thêm nhiều quyền lợi từ \"Cây Khế\".',
//                         style: TextStyles.common_text,
//                         textAlign: TextAlign.justify,
//                       ),
//                     ),
//                     Divider(
//                       thickness: 0.5,
//                       color: Colors.black12,
//                     ),
//                     Row(
//                       children: [
//                         Container(
//                             padding: EdgeInsets.only(
//                                 left: setWidth(16), right: setWidth(5)),
//                             child: Image.asset(
//                               'assets/icons/achievement/total_point_ic.png',
//                               width: setWidth(28),
//                               height: setHeight(29),
//                             )),
//                         Text(
//                           'Lượt quay đang có (${GlobalCache().loginData.account.reWards == null ? '0' : GlobalCache().loginData.account.reWards.length})',
//                           style: TextStyles.orange_text,
//                         ),
//                       ],
//                     ),
//                     Divider(
//                       thickness: 0.5,
//                       color: Colors.black12,
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(
//                           left: setWidth(16), right: setWidth(16)),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Ví của bạn đang có',
//                             style: TextStyles.orange_text,
//                           ),
//                           Text(
//                             nf.format(GlobalCache().loginData.account.balance) +
//                                     ' ' +
//                                     GlobalCache().loginData.account.currency ??
//                                 'VND',
//                             style: TextStyles.orange_text,
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       padding: EdgeInsets.all(setWidth(16)),
//                       child: Text(
//                         'Bạn có thể rút tiền về ví Momo hoặc nhận thẻ điện thoại. Số tiền tối thiểu mỗi lần rút là 10,000đ.',
//                         style: TextStyles.common_text,
//                         textAlign: TextAlign.justify,
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SimpleButton('Yêu cầu rút', () {
//                           // Navigator.push(
//                           //     context,
//                           //     MaterialPageRoute(
//                           //         builder: (context) => RequestPayView(
//                           //             GlobalCache()
//                           //                 .loginData
//                           //                 .account
//                           //                 .balance)));
//                         }),
//                       ],
//                     ),
//                     SizedBox(
//                       height: setHeight(5),
//                     ),
//                     Divider(
//                       thickness: 0.5,
//                       color: Colors.black12,
//                     ),
//                     GestureDetector(
//                       behavior: HitTestBehavior.translucent,
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     TransactionHistoryView()));
//                       },
//                       child: Container(
//                         padding: EdgeInsets.only(
//                             left: setWidth(16), right: setWidth(16)),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 Image.asset(
//                                   'assets/icons/achievement/history_ic.png',
//                                   width: setWidth(28),
//                                   height: setHeight(29),
//                                 ),
//                                 SizedBox(
//                                   width: setWidth(5),
//                                 ),
//                                 Text(
//                                   'Lịch sử giao dịch',
//                                   style: TextStyles.orange_text,
//                                 ),
//                               ],
//                             ),
//                             Icon(
//                               Icons.arrow_forward_ios,
//                               color: ColorUtils.BG_COLOR,
//                               size: 20,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Divider(
//                       thickness: 0.5,
//                       color: Colors.black12,
//                     ),
//                     GestureDetector(
//                       behavior: HitTestBehavior.translucent,
//                       onTap: () {
//
//                       },
//                       child: Container(
//                         padding: EdgeInsets.only(
//                             left: setWidth(16), right: setWidth(16)),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 Image.asset(
//                                   'assets/icons/achievement/thuongdiem.png',
//                                   width: setWidth(30),
//                                   height: setHeight(32),
//                                 ),
//                                 SizedBox(
//                                   width: setWidth(5),
//                                 ),
//                                 Text(
//                                   'Phê duyệt nhiệm vụ',
//                                   style: TextStyles.orange_text,
//                                 ),
//                               ],
//                             ),
//                             Icon(
//                               Icons.arrow_forward_ios,
//                               color: ColorUtils.BG_COLOR,
//                               size: 20,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Divider(
//                       thickness: 0.5,
//                       color: Colors.black12,
//                     ),
//                     Container(
//                       padding: EdgeInsets.only(
//                           left: setWidth(16),
//                           right: setWidth(16),
//                           bottom: setHeight(16)),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Điểm đang có',
//                             style: TextStyles.common_text,
//                           ),
//                           Text(
//                             GlobalCache().loginData.account.point.toString() +
//                                 " điểm",
//                             style: TextStyles.orange_text,
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(
//                           left: setWidth(16), right: setWidth(16)),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.all(Radius.circular(5)),
//                         child: LinearProgressIndicator(
//                           backgroundColor: Colors.black26,
//                           value: progressValue,
//                           minHeight: 8,
//                           valueColor:
//                               AlwaysStoppedAnimation<Color>(progressColor),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       width: double.infinity,
//                       padding: EdgeInsets.fromLTRB(setWidth(16), setHeight(10),
//                           setWidth(16), setHeight(10)),
//                       child: Text(
//                         pointRemainDesc,
//                         style: TextStyles.common_text,
//                         textAlign: TextAlign.justify,
//                       ),
//                     ),
//                     Container(
//                         width: double.infinity,
//                         height: setHeight(200),
//                         child: MemberBenifit()),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     getAccountBloc.dispose();
//     super.dispose();
//   }
// }
