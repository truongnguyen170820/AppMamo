import 'package:mamo/blocs/task/get_top_hunter_tab_view_bloc.dart';
import 'package:mamo/model/user/top_hunter_model.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/utils/font_utils.dart';
import 'package:mamo/utils/text_styles.dart';
import 'package:mamo/utils/utilities.dart';
import 'package:mamo/widget/circle_avatar.dart';
import 'package:mamo/widget/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopHunterTabView extends StatefulWidget {
  final int type;

  TopHunterTabView(this.type);

  @override
  _TopHunterTabViewState createState() => _TopHunterTabViewState();
}

class _TopHunterTabViewState extends State<TopHunterTabView> {
  GetTopHunterBloc bloc = GetTopHunterBloc();

  DateTime currentDay = DateTime.now();
  bool showReward = true;
  bool changeColor = false;

  @override
  void initState() {
    super.initState();
    bloc.initListener(context);
  }

  @override
  Widget build(BuildContext context) {

    bloc.getTopHunter(widget.type, convertDate(currentDay));
    return Column(
      children: [
        StreamBuilder(
            stream: bloc.getTopHunterStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<TopHunterModel> hunterList = snapshot.data;
                if (hunterList.length == 0) {
                  return Expanded(
                    child: Center(
                        child: Text(
                      'Không có dữ liệu',
                      style: TextStyle(color: Colors.black54),
                    )),
                  );
                } else
                  return Expanded(
                    child: ListView.builder(
                        itemCount: hunterList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                                right: setWidth(16), left: setWidth(16)),
                            padding: EdgeInsets.only(
                                top: setHeight(16), bottom: setHeight(13)),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: ColorUtils.gray,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                getNumberIcon(index + 1),
                                SizedBox(width: setWidth(21)),
                                buildHunterTitle(hunterList[index])
                              ],
                            ),
                          );
                        }),
                  );
              } else
                return Expanded(
                  child: Center(
                      child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(ColorUtils.colorTextLogo),
                  )),
                );
            }),
      ],
    );
  }

  String convertDate(DateTime date) {
    return date.toString().substring(0, 10).split("-").reversed.join("/");
  }

  Widget getNumberIcon(int number) {
    switch (number) {
      case 1:
        {
          return Image.asset(
            getAssetsIcon("top1.png"),
            width: setWidth(28),
            height: setWidth(46),
          );
        }
      case 2:
        {
          return Image.asset(
            getAssetsIcon("top2.png"),
            width: setWidth(28),
            height: setWidth(46),
          );
        }
      case 3:
        {
          return Image.asset(
            getAssetsIcon("top3.png"),
            width: setWidth(28),
            height: setWidth(46),
          );
        }
      default:
        {
          return Container(
            alignment: Alignment.center,
            width: setWidth(35),
            height: setWidth(46),
            child: Text(
              '$number',
              style: FontUtils.Italic.copyWith(
                  fontSize: setSp(22), color: ColorUtils.TEXT_NAME),
              textAlign: TextAlign.center,
            ),
          );
        }
    }
  }

  Widget buildHunterTitle(TopHunterModel hunter) {
    return Row(
      children: [
        circleAvatar(hunter.userAvatar, hunter.fullName??"", radius: 25),
        SizedBox(
          width: setWidth(8),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (hunter.fullName == null || hunter.fullName.isEmpty)
                ? Text(hunter.username.substring(0, 7) + "***",
                    style: FontUtils.MEDIUM
                        .copyWith(color: ColorUtils.NUMBER_PAGE))
                : (hunter.fullName.length > 23)
                    ? Text(hunter.fullName.substring(0, 23),
                        style: FontUtils.MEDIUM
                            .copyWith(color: ColorUtils.NUMBER_PAGE))
                    : Text(hunter.fullName,
                        style: FontUtils.MEDIUM
                            .copyWith(color: ColorUtils.NUMBER_PAGE)),
            Text(Utilities.formatMoney(hunter.totalMoney ?? "", suffix: 'đ'),
                style: FontUtils.BOLD.copyWith(
                    color: ColorUtils.TEXT_PRICE, fontSize: setSp(12))),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
