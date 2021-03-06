
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mamo/blocs/impl/event_type.dart';
import 'package:mamo/blocs/impl/stream_event.dart';
import 'package:mamo/blocs/task/reading/taskReadBloc.dart';
import 'package:mamo/model/request/base_response.dart';
import 'package:mamo/model/user/task_model.dart';
import 'package:mamo/utils/app_constant.dart';
import 'package:mamo/utils/color_utils.dart';
import 'package:mamo/utils/font_utils.dart';
import 'package:mamo/utils/global_cache.dart';
import 'package:mamo/utils/utilities.dart';
import 'package:mamo/views/loading_view.dart';
import 'package:mamo/views/main/main_view.dart';
import 'package:mamo/widget/common_appbar.dart';
import 'package:mamo/widget/custombutton.dart';
import 'package:mamo/widget/global.dart';
import 'package:mamo/widget/loading_widget.dart';
import 'package:mamo/widget/time_ago.dart';

class TaskViewPage extends StatefulWidget {
  final int type;
  const TaskViewPage({Key key, this.type}) : super(key: key);

  @override
  _TaskViewPageState createState() => _TaskViewPageState();
}

class _TaskViewPageState extends State<TaskViewPage> {
  TaskReadBloc taskReadBloc = TaskReadBloc();
  bool isGotTask = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taskReadBloc.getTaskModel(widget.type);
    taskReadBloc.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarDefault(context, widget.type == 1 ? "Đọc truyện" : "Đọc báo", bgColor: ColorUtils.WHITE),
      backgroundColor: ColorUtils.WHITE,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only( left: setWidth(16), right: setWidth(16), bottom: setHeight(14)),
            decoration: BoxDecoration(
              border: Border.all(color: ColorUtils.gray4, width: 1)
            ),
          ),
          Image.asset(getAssetsImage("info_kiemtien.png"), height: setHeight(200),),
          // itemTask(widget.taskModel),
          StreamBuilder(
              stream: taskReadBloc.getEventStream,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  var taskModel = snapshot.data;
                  if(taskModel != null){
                    isGotTask = false;
                    return itemTask(taskModel: taskModel.first);
                  }
                  else{
                    return LoadingWidget();
                  }
                }
                return _buildError();
              }
          ),
        ],
      ),
    );
  }
  
  Widget itemTask({TaskModel taskModel}){
    return Container(
      margin: EdgeInsets.only(right: setWidth(16), left: setWidth(16), top: setHeight(19)),
      child: Column(
        children: [
          Text(
            // taskModel?.description?? GlobalCache().errorMessage ,
            taskModel?.description?? "" ,
              style: FontUtils.NORMAL.copyWith(color: ColorUtils.NUMBER_PAGE),overflow: TextOverflow.clip,textAlign: TextAlign.justify,textScaleFactor: 1,
          ),
        SizedBox(height: setHeight(28)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ButtonCustom(
              height: setHeight(42),
              width: setWidth(163),
              borderRadius: 12,
              bgColor: ColorUtils.colorStatus,
              title: "Hoàn thành",
              onTap: (){
                setState(() {
                });
                Navigator.of(context).push( new MaterialPageRoute(builder: (context)=>MainView()));
              },
            ),
            ButtonCustom(
              height: setHeight(42),
              width: setWidth(163),
              borderRadius: 12,
              bgColor: ColorUtils.colorTextLogo,
              title: "Copy Link",
              textStyle: FontUtils.MEDIUM.copyWith(color: ColorUtils.WHITE),
              onTap: (){
                FlutterClipboard.copy(taskModel.url??"");
                Utilities.showToast(
                    context, "Đã copy đường dẫn trang web");
              },
            )
          ],
    ),

          SizedBox(height: setHeight(50)),
          Text("Để thực hiện nhiệm vụ, vui lòng bấm vào nút [Copy Link]. Sau đó, bạn sang trình duyệt và Paste vào thanh địa chỉ để đọc. Chú ý không Paste vào tìm kiếm Google.",
            style: FontUtils.NORMAL.copyWith(fontSize: setSp(13),color: ColorUtils.TEXT_NAME),overflow: TextOverflow.clip,textAlign: TextAlign.justify,textScaleFactor: 1,),
        SizedBox(height: setHeight(5)),
          Text("Sau khi đọc đủ số lượng trang vào thời gian yêu cầu. Bạn vui lòng qua lại App Mamo để bấm nút hoàn thành nhiệm vụ",
            style: FontUtils.NORMAL.copyWith(fontSize: setSp(13),color: ColorUtils.TEXT_NAME),overflow: TextOverflow.clip,textAlign: TextAlign.justify,textScaleFactor: 1,
          ),
        ],
      )
    );
  }

  Widget _buildError(){
    return Container(
      margin: EdgeInsets.only(top: setHeight(16)),
      child: Column(
        children: [
          Text(GlobalCache().errorMessage??"Nhận Nhiệm vụ thất bại", style: FontUtils.NORMAL.copyWith(color: ColorUtils.TEXT_NAME)),
          SizedBox(height: setHeight(20)),
          ButtonCustom(
            textStyle: FontUtils.MEDIUM.copyWith(color: ColorUtils.WHITE),
            height: setHeight(42),
            width: setWidth(200),
            title: "Đóng",
            borderRadius: 12,
            onTap: (){
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

}
