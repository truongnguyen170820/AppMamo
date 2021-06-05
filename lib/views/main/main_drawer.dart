import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    as passwordStore;
import 'package:mamo/api/api_constants.dart';
import 'package:mamo/api/api_service.dart';
import 'package:mamo/blocs/user/get_account_bloc.dart';
import 'package:mamo/utils/font_utils.dart';
import 'package:mamo/utils/text_styles.dart';
import 'package:mamo/utils/app_constant.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/utils/global_cache.dart';
import 'package:mamo/views/user/achievements_page.dart';
import 'package:mamo/views/user/invitation_code_view.dart';
import 'package:mamo/views/user/item/list_member_page.dart';
import 'package:mamo/views/user/item/reward_history_tab_view.dart';
import 'package:mamo/views/user/monetization_history_page.dart';
import 'package:mamo/views/user/signin_account_view.dart';
import 'package:mamo/views/user/task/help_view/help_view.dart';
import 'package:mamo/views/user/top_hunter_view.dart';
import 'package:mamo/views/user/user_profile_view.dart';
import 'package:mamo/widget/circle_avatar.dart';
import 'package:mamo/widget/custombutton.dart';
import 'package:mamo/widget/global.dart';

import 'main_view.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  GetAccountBloc getAccountBloc = GetAccountBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NumberFormat nf = NumberFormat("###,###,###", "en_US");
    getAccountBloc.getAccount(context);
    return StreamBuilder(
      stream: getAccountBloc.getAccountStream,
      initialData: GlobalCache().loginData.account,
      builder: (context, snapshot) {
        if (snapshot.hasData) GlobalCache().loginData.account = snapshot.data;
        return Drawer(
          child: Column(
            // padding: EdgeInsets.all(0),
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  pushTo(context, UserProfileView());
                  // Navigator.push(
                  //                   //     context,
                  //                   //     MaterialPageRoute(
                  //                   //         builder: (context) => UserProfileView()))
                  //                   //     .then((value) {
                  //                   //   setState(() {});
                  //                   // });
                },
                child: Container(
                  color: ColorUtils.colorTextLogo,
                  padding: EdgeInsets.only(
                      left: setWidth(20),
                      top: setHeight(56),
                      right: setWidth(25),
                      bottom: setHeight(30)),
                  child: Row(
                    children: [
                      circleAvatar(GlobalCache().loginData.avatarUrl??"",  GlobalCache().loginData.fullName??"", radius: 30),
                      SizedBox(width: setWidth(8)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            GlobalCache().loginData.fullName ??"",
                                // GlobalCache().loginData.userName,
                            style:FontUtils.BOLD.copyWith(color: ColorUtils.WHITE),
                          ),
                      Text(GlobalCache().loginData.userName??"", style: FontUtils.BOLD.copyWith(color: ColorUtils.WHITE.withOpacity(0.6)))
                        ],
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios_outlined, color: ColorUtils.WHITE.withOpacity(0.6),size: 15,)
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: setWidth(24), right: setWidth(24)),
                child: Column(
                  children: [
                    _buildItemMenu("Bảng thành tích", "achievements.png", ontap: (){
                      pushTo(context, AchievementsBoard());
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => AchievementsBoard()));
                    }),

                    _buildItemMenu("Lịch sử kiếm tiền","history.png", ontap: (){
                      pushTo(context, MonetizationHistory());
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => MonetizationHistory()));
                    }),
                    _buildItemMenu("Thành viên cấp dưới", "member.png", ontap: (){
                      pushTo(context, ListMemberPage());
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> ListMemberTabView()));
                    }),
                    _buildItemMenu("Hướng dẫn kiếm tiền", "tutorial.png", ontap: (){
                      pushTo(context, HelpView());
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>HelpView()));
                    }),
                    _buildItemMenu("Top độc giả", "top.png", ontap: (){
                      pushTo(context, TopHunterView());
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> TopHunterView()));
                    }),
                    _buildItemMenu("Giới thiệu bạn bè", "share.png", ontap: (){
                      pushTo(context, InvitationView());
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>InvitationView()));
                    }),
                  ],
                ),
              ),
              //
              // ListTile(
              //   leading: drawerIcon('dw_tro_giup.png'),
              //   title: Text(
              //     'Hướng dẫn làm nhiệm vụ',
              //     style: TextStyles.drawer_text,
              //   ),
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => HelpView()));
              //   },
              // ),
              // ListTile(
              //   leading: drawerIcon('dw_top_tho_san.png'),
              //   title: Text(
              //     'Top thợ săn',
              //     style: TextStyles.drawer_text,
              //   ),
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => TopHunterView()));
              //   },
              // ),
              // ListTile(
              //   leading: drawerIcon('dw_bang_thanh_tich.png'),
              //   title: Text(
              //     'Bảng thành tích',
              //     style: TextStyles.drawer_text,
              //   ),
              //   onTap: () {
              //     // Navigator.push(
              //     //     context,
              //     //     MaterialPageRoute(
              //     //         builder: (context) => AchievementView()));
              //   },
              // ),
              // ListTile(
              //   leading: drawerIcon('dw_lich_su_giao_dich.png'),
              //   title: Text(
              //     'Lịch sử giao dịch',
              //     style: TextStyles.drawer_text,
              //   ),
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => TransactionHistoryView()));
              //   },
              // ),
              // ListTile(
              //   leading: drawerIcon('dw_phe_duyet_nhiem_vu.png'),
              //   title: Text(
              //     'Phê duyệt nhiệm vụ',
              //     style: TextStyles.drawer_text,
              //   ),
              //   onTap: () {
              //   //todo
              //   },
              // ),
              // ListTile(
              //   leading: drawerIcon('dw_thanh_vien.png'),
              //   title: Text(
              //     'Danh sách thành viên',
              //     style: TextStyles.drawer_text,
              //   ),
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => ListMemberView()));
              //   },
              // ),
              // ListTile(
              //   leading: drawerIcon('dw_gioi_thieu_thanh_vien.png'),
              //   title: Text(
              //     'Giới thiệu thành viên',
              //     style: TextStyles.drawer_text,
              //   ),
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => InvitationView()));
              //   },
              // ),
              // GlobalCache().loginData.isGetBonusIntruduceCode
              //     ? Container()
              //     : ListTile(
              //         leading: drawerIcon('dw_nhap_ma.png'),
              //         title: Text(
              //           'Nhập mã giới thiệu',
              //           style: TextStyles.drawer_text,
              //         ),
              //         onTap: () {
              //           Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) =>
              //                       SubmitInvitationCodeView()));
              //         },
              //       ),
              Container(
                padding: EdgeInsets.only(top: setHeight(24)),
                margin: EdgeInsets.only(top: setHeight(67), left: setWidth(16), right: setWidth(16)),
                child: ButtonCustom(
                  title: "Đăng xuất",
                  textStyle: FontUtils.MEDIUM.copyWith(color: ColorUtils.WHITE)
                  ,margin: EdgeInsets.symmetric(horizontal: setWidth(35)),
                  height: setHeight(42),
                  bgColor: ColorUtils.bt,
                  borderRadius: 12,
                  onTap: (){
                    showGeneralDialog(
                    barrierLabel: "Barrier",
                    barrierDismissible: false,
                    barrierColor: Colors.black.withOpacity(0.5),
                    context: context,
                    transitionDuration: Duration(microseconds: 700),
                    transitionBuilder: (_, anim, __, child) {
                      return SlideTransition(
                        position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
                            .animate(anim),
                        child: child,
                      );
                    },
                    pageBuilder: (_, __, ___) {
                      return Center(
                        child: Stack(
                          children: [
                            Container(
                              width: setWidth(198 * 1.3),
                              height: setWidth(140 * 1.3),
                              decoration: BoxDecoration(
                                color: ColorUtils.WHITE,
                                borderRadius: BorderRadius.circular(10)
                                // image: DecorationImage(
                                //   image: AssetImage(
                                //     getAssetsIcon("history.png"),),
                                //   fit: BoxFit.contain,
                                // ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: GestureDetector(
                                child: Image.asset(
                                  getAssetsIcon("tuchoi.png"),
                                  width: setWidth(40),
                                  height: setWidth(40),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            Positioned(
                              left: setWidth(5),
                              top: setHeight(28),
                              child: GestureDetector(
                                child: Image.asset(
                                  getAssetsImage("yesOrNo.png"),
                                  width: setWidth(250),
                                  height: setWidth(100),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            Positioned(
                              left: setWidth(20 * 1.2),
                              top: setWidth(80 * 1.4),
                              child: GestureDetector(
                                child: Image.asset(
                                  getAssetsImage("yes.png"),
                                  width: setWidth(100),
                                  height: setWidth(100),
                                ),
                                onTap: () async {
                                  final storage =
                                  passwordStore.FlutterSecureStorage();
                                  await storage.delete(
                                      key: AppConstants.KEY_USER_NAME);
                                  await storage.delete(
                                      key: AppConstants.KEY_PASSWORD);
                                  ApiService(ApiConstants.SIGNOUT_ACCOUNT, {},
                                      null)
                                      .getResponse();
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SigninAccountView()),
                                          (route) => false);
                                },
                              ),
                            ),
                            Positioned(
                              right: setWidth(20 * 1.2),
                              top: setWidth(80 * 1.4),
                              child: GestureDetector(
                                child: Image.asset(
                                  getAssetsImage("no.png"),
                                  width: setWidth(100),
                                  height: setWidth(100),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                    },
                ),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: ColorUtils.underlined,
                      width: 1
                    )
                  )
                ),
              ),
              SizedBox(height: setHeight(18)),
              Text("Phiên bản 1.0.0", style: FontUtils.NORMAL.copyWith(color: ColorUtils.TEXT_NAME, fontSize: setSp(12)),textAlign: TextAlign.center),
              SizedBox(height: setHeight(24)),
            ],
          ),
        );
      },
    );
  }

  _buildItemMenu(String name, String imageUrl,{Function ontap}) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.only(bottom: setHeight(16), top: setHeight(19)),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1, color: ColorUtils.underlined))),
        child: Row(
          children: [
            Image.asset(getAssetsIcon(imageUrl),
                height: setHeight(19), width: setWidth(17)),
            SizedBox(width: setWidth(16)),
            Text(
              name,
              style: FontUtils.NORMAL.copyWith(color: ColorUtils.TEXT_NAME),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget drawerIcon(String iconPath) {
    return Container(
      width: setWidth(30),
      height: setWidth(30),
      child: Image.asset('assets/icons/drawer/' + iconPath),
    );
  }

  @override
  void dispose() {
    getAccountBloc.dispose();
    super.dispose();
  }
}
