class TaskStatusModel {
  String idStr;
  String taskIdStr;
  String processingTaskIdStr;
  String userName;
  String userIdStr;
  String endProcessingStr;
  int verifyStatus;
  String verifyDateStr;
  String rejectContent;
  int totalGetRewards;
  String reviewSocialLink;
  String reviewContent;
  String reviewImage;

  TaskStatusModel(
      {this.idStr,
        this.taskIdStr,
        this.processingTaskIdStr,
        this.userName,
        this.userIdStr,
        this.endProcessingStr,
        this.verifyStatus,
        this.verifyDateStr,
        this.rejectContent,
        this.totalGetRewards,
        this.reviewSocialLink,
        this.reviewContent,
        this.reviewImage});

  TaskStatusModel.fromJson(Map<String, dynamic> json) {
    idStr = json['IdStr'];
    taskIdStr = json['TaskIdStr'];
    processingTaskIdStr = json['ProcessingTaskIdStr'];
    userName = json['UserName'];
    userIdStr = json['UserIdStr'];
    endProcessingStr = json['EndProcessingStr'];
    verifyStatus = json['VerifyStatus'];
    verifyDateStr = json['VerifyDateStr'];
    rejectContent = json['RejectContent'];
    totalGetRewards = json['TotalGetRewards'];
    reviewSocialLink = json['ReviewSocialLink'];
    reviewContent = json['ReviewContent'];
    reviewImage = json['ReviewImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdStr'] = this.idStr;
    data['TaskIdStr'] = this.taskIdStr;
    data['ProcessingTaskIdStr'] = this.processingTaskIdStr;
    data['UserName'] = this.userName;
    data['UserIdStr'] = this.userIdStr;
    data['EndProcessingStr'] = this.endProcessingStr;
    data['VerifyStatus'] = this.verifyStatus;
    data['VerifyDateStr'] = this.verifyDateStr;
    data['RejectContent'] = this.rejectContent;
    data['TotalGetRewards'] = this.totalGetRewards;
    data['ReviewSocialLink'] = this.reviewSocialLink;
    data['ReviewContent'] = this.reviewContent;
    data['ReviewImage'] = this.reviewImage;
    return data;
  }
}
