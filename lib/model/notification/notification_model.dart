class NotificationModel {
  String idStr;
  String receivingMemberIdStr;
  String senderUserIdStr;
  String content;
  String title;
  int status;
  int type;
  int actionType;
  String taskIdStr;
  String createdTimeStr;
  String readTimeStr;

  NotificationModel(
      {this.idStr,
        this.receivingMemberIdStr,
        this.senderUserIdStr,
        this.content,
        this.title,
        this.status,
        this.type,
        this.actionType,
        this.taskIdStr,
        this.createdTimeStr,
        this.readTimeStr});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    idStr = json['IdStr'];
    receivingMemberIdStr = json['ReceivingMemberIdStr'];
    senderUserIdStr = json['SenderUserIdStr'];
    content = json['Content'];
    title = json['Title'];
    status = json['Status'];
    type = json['Type'];
    actionType = json['ActionType'];
    taskIdStr = json['TaskIdStr'];
    createdTimeStr = json['CreatedTimeStr'];
    readTimeStr = json['ReadTimeStr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdStr'] = this.idStr;
    data['ReceivingMemberIdStr'] = this.receivingMemberIdStr;
    data['SenderUserIdStr'] = this.senderUserIdStr;
    data['Content'] = this.content;
    data['Title'] = this.title;
    data['Status'] = this.status;
    data['Type'] = this.type;
    data['ActionType'] = this.actionType;
    data['TaskIdStr'] = this.taskIdStr;
    data['CreatedTimeStr'] = this.createdTimeStr;
    data['ReadTimeStr'] = this.readTimeStr;
    return data;
  }
}

// class NotificationModel {
//   String idStr;
//   String receivingMemberIdStr;
//   String senderUserIdStr;
//   String content;
//   String title;
//   int status;
//   int type;
//   int actionType;
//   String taskIdStr;
//   String createdTimeStr;
//   String readTimeStr;
//
//   NotificationModel(
//       {this.idStr,
//         this.receivingMemberIdStr,
//         this.senderUserIdStr,
//         this.content,
//         this.title,
//         this.status,
//         this.type,
//         this.actionType,
//         this.taskIdStr,
//         this.createdTimeStr,
//         this.readTimeStr});
//
//   NotificationModel.fromJson(Map<String, dynamic> json) {
//     idStr = json['IdStr'];
//     receivingMemberIdStr = json['ReceivingMemberIdStr'];
//     senderUserIdStr = json['SenderUserIdStr'];
//     content = json['Content'];
//     title = json['Title'];
//     status = json['Status'];
//     type = json['Type'];
//     actionType = json['ActionType'];
//     taskIdStr = json['TaskIdStr'];
//     createdTimeStr = json['CreatedTimeStr'];
//     readTimeStr = json['ReadTimeStr'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['IdStr'] = this.idStr;
//     data['ReceivingMemberIdStr'] = this.receivingMemberIdStr;
//     data['SenderUserIdStr'] = this.senderUserIdStr;
//     data['Content'] = this.content;
//     data['Title'] = this.title;
//     data['Status'] = this.status;
//     data['Type'] = this.type;
//     data['ActionType'] = this.actionType;
//     data['TaskIdStr'] = this.taskIdStr;
//     data['CreatedTimeStr'] = this.createdTimeStr;
//     data['ReadTimeStr'] = this.readTimeStr;
//     return data;
//   }
// }
