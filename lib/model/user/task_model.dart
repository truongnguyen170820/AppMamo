
class TaskModel {
  String url;
  String description;

  TaskModel({this.url, this.description});

  TaskModel.fromJson(Map<String, dynamic> json) {
    url = json['Url'];
    description = json['Description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Url'] = this.url;
    data['Description'] = this.description;
    return data;
  }
}
// class TaskModel {
//   String idStr;
//   List<Tasks> tasks;
//   int submitType;
//   int totalGetRewards;
//   Review review;
//   String trackerIdStr;
//   int numPageRead;
//   int pageTime;
//   String url;
//   String description;
//   String receiveTime;
//   TaskModel({this.idStr, this.tasks, this.submitType, this.totalGetRewards, this.trackerIdStr, this.numPageRead, this.pageTime, this.review, this.url, this.description, this.receiveTime});
//
//   TaskModel.fromJson(Map<String, dynamic> json) {
//     idStr = json['IdStr'];
//     url = json['Url'];
//     description = json['Description'];
//     trackerIdStr = json['TrackerIdStr'];
//     if (json['Tasks'] != null) {
//       tasks = new List<Tasks>();
//       json['Tasks'].forEach((v) {
//         tasks.add(new Tasks.fromJson(v));
//       });
//     }
//     submitType = json['SubmitType'];
//     numPageRead = json['NumPageRead'];
//     pageTime = json['PageTime'];
//     totalGetRewards = json['TotalGetRewards'];
//     receiveTime = json['ReceiveTime'];
//     review =
//     json['Review'] != null ? new Review.fromJson(json['Review']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['IdStr'] = this.idStr;
//     data['Url'] = this.url;
//     data['Description'] = this.description;
//     data['TrackerIdStr'] = this.trackerIdStr;
//     if (this.tasks != null) {
//       data['Tasks'] = this.tasks.map((v) => v.toJson()).toList();
//     }
//     data['SubmitType'] = this.submitType;
//     data['NumPageRead'] = this.numPageRead;
//     data['PageTime'] = this.pageTime;
//     data['ReceiveTime'] = this.receiveTime;
//     data['TotalGetRewards'] = this.totalGetRewards;
//     data['Review'] = this.review;
//     return data;
//   }
// }
//
// class Tasks {
//   String sId;
//   String idStr;
//   int step;
//   String content;
//   String randomWait;
//   String helpImgUrl;
//
//   Tasks(
//       {this.sId,
//         this.idStr,
//         this.step,
//         this.content,
//         this.randomWait,
//         this.helpImgUrl});
//
//   Tasks.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     idStr = json['IdStr'];
//     step = json['Step'];
//     content = json['Content'];
//     randomWait = json['RandomWait'];
//     helpImgUrl = json['HelpImgUrl'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['IdStr'] = this.idStr;
//     data['Step'] = this.step;
//     data['Content'] = this.content;
//     data['RandomWait'] = this.randomWait;
//     data['HelpImgUrl'] = this.helpImgUrl;
//     return data;
//   }
// }
// class Review {
//   String content;
//   String imgPath;
//
//   Review(
//       {this.content,
//         this.imgPath});
//
//   Review.fromJson(Map<String, dynamic> json) {
//     content = json['Content'];
//     imgPath = json['ImgPath'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Content'] = this.content;
//     data['ImgPath'] = this.imgPath;
//     return data;
//   }
// }