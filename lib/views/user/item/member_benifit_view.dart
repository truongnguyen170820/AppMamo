import 'package:mamo/utils/text_styles.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/widget/global.dart';
import 'package:flutter/material.dart';

class MemberBenifit extends StatefulWidget {
  @override
  _MemberBenifitState createState() => _MemberBenifitState();
}

class _MemberBenifitState extends State<MemberBenifit>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: ColorUtils.gray4,
          height: setHeight(60),
          child: TabBar(
            indicator: BoxDecoration(
              color: Colors.white,
            ),
            tabs: [
              Column(
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 8, bottom: 0),
                      width: setWidth(40),
                      height: setHeight(37),
                      child: Image.asset(
                          'assets/icons/achievement/normal_tab_ic.png')),
                  Text('Chuẩn',
                      style:
                          TextStyle(color: Colors.black54, fontSize: setSp(11)),
                      textAlign: TextAlign.center),
                ],
              ),
              Column(
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 8, bottom: 0),
                      width: setWidth(40),
                      height: setHeight(37),
                      child: Image.asset(
                          'assets/icons/achievement/gold_tab_ic.png')),
                  Text('Vàng',
                      style:
                          TextStyle(color: Colors.black54, fontSize: setSp(11)),
                      textAlign: TextAlign.center),
                ],
              ),
              Column(
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 8, bottom: 0),
                      width: setWidth(40),
                      height: setHeight(37),
                      child: Image.asset(
                          'assets/icons/achievement/diamond_tab_ic.png')),
                  Text('Kim cương',
                      style:
                          TextStyle(color: Colors.black54, fontSize: setSp(11)),
                      textAlign: TextAlign.center),
                ],
              ),
            ],
            controller: _tabController,
          ),
        ),
        Expanded(
          child: TabBarView(
            children: [
              NormalMember(),
              GoldMember(),
              DiamondMember(),
            ],
            controller: _tabController,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}

class NormalMember extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: setWidth(16), left: setWidth(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: setHeight(5),
          ),
          Text(
            'Đặc quyền dành cho thành viên Chuẩn',
            style: TextStyles.orange_text,
          ),
          SizedBox(
            height: setHeight(5),
          ),
          Row(
            children: [
              Container(
                  padding:
                      EdgeInsets.only(left: setWidth(15), right: setWidth(7)),
                  child: Image.asset(
                    'assets/icons/achievement/dot_ic.png',
                    width: setWidth(8),
                    height: setHeight(9),
                  )),
              Text(
                'Miễn phí rút tiền qua Momo, thẻ cào',
                style: TextStyles.common_text,
              ),
            ],
          ),
          SizedBox(
            height: setHeight(5),
          ),
          Row(
            children: [
              Container(
                  padding:
                      EdgeInsets.only(left: setWidth(15), right: setWidth(7)),
                  child: Image.asset(
                    'assets/icons/achievement/dot_ic.png',
                    width: setWidth(8),
                    height: setHeight(9),
                  )),
              Text(
                'Nhận các nhiệm vụ có 1 điểm thưởng',
                style: TextStyles.common_text,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GoldMember extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: setWidth(16), left: setWidth(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: setHeight(5),
          ),
          Text(
            'Đặc quyền dành cho thành viên Vàng',
            style: TextStyles.orange_text,
          ),
          SizedBox(
            height: setHeight(5),
          ),
          Row(
            children: [
              Container(
                  padding:
                      EdgeInsets.only(left: setWidth(15), right: setWidth(7)),
                  child: Image.asset(
                    'assets/icons/achievement/dot_ic.png',
                    width: setWidth(8),
                    height: setHeight(9),
                  )),
              Text(
                'Miễn phí rút tiền qua Momo, thẻ cào',
                style: TextStyles.common_text,
              ),
            ],
          ),
          SizedBox(
            height: setHeight(5),
          ),
          Row(
            children: [
              Container(
                  padding:
                      EdgeInsets.only(left: setWidth(15), right: setWidth(7)),
                  child: Image.asset(
                    'assets/icons/achievement/dot_ic.png',
                    width: setWidth(8),
                    height: setHeight(9),
                  )),
              Text(
                'Nhận các nhiệm vụ có nhiều điểm thưởng',
                style: TextStyles.common_text,
              ),
            ],
          ),
          SizedBox(
            height: setHeight(5),
          ),
          Row(
            children: [
              Container(
                  padding:
                      EdgeInsets.only(left: setWidth(15), right: setWidth(7)),
                  child: Image.asset(
                    'assets/icons/achievement/dot_ic.png',
                    width: setWidth(8),
                    height: setHeight(9),
                  )),
              Text(
                'Được nhận nhiều nhiệm vụ trong ngày hơn',
                style: TextStyles.common_text,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DiamondMember extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: setWidth(16), left: setWidth(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: setHeight(5),
          ),
          Text(
            'Đặc quyền dành cho thành viên Kim cương',
            style: TextStyles.orange_text,
          ),
          SizedBox(
            height: setHeight(5),
          ),
          Row(
            children: [
              Container(
                  padding:
                      EdgeInsets.only(left: setWidth(15), right: setWidth(7)),
                  child: Image.asset(
                    'assets/icons/achievement/dot_ic.png',
                    width: setWidth(8),
                    height: setHeight(9),
                  )),
              Text(
                'Miễn phí rút tiền qua Momo, thẻ cào',
                style: TextStyles.common_text,
              ),
            ],
          ),
          SizedBox(
            height: setHeight(5),
          ),
          Row(
            children: [
              Container(
                  padding:
                      EdgeInsets.only(left: setWidth(15), right: setWidth(7)),
                  child: Image.asset(
                    'assets/icons/achievement/dot_ic.png',
                    width: setWidth(8),
                    height: setHeight(9),
                  )),
              Text(
                'Được nhận tất cả các loại nhiệm vụ',
                style: TextStyles.common_text,
              ),
            ],
          ),
          SizedBox(
            height: setHeight(5),
          ),
          Row(
            children: [
              Container(
                  padding:
                      EdgeInsets.only(left: setWidth(15), right: setWidth(7)),
                  child: Image.asset(
                    'assets/icons/achievement/dot_ic.png',
                    width: setWidth(8),
                    height: setHeight(9),
                  )),
              Text(
                'Được nhận nhiều nhiệm vụ trong ngày hơn',
                style: TextStyles.common_text,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
          SizedBox(
            height: setHeight(5),
          ),
          Row(
            children: [
              Container(
                  padding:
                      EdgeInsets.only(left: setWidth(15), right: setWidth(7)),
                  child: Image.asset(
                    'assets/icons/achievement/dot_ic.png',
                    width: setWidth(8),
                    height: setHeight(9),
                  )),
              Flexible(
                child: Text(
                  'Cơ hội nhận các nhiệm vụ trị giá từ 100k đến 500k cộng trực tiếp vào tài khoản',
                  style: TextStyles.common_text,
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
