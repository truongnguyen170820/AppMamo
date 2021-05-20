class SocialAccountModel {
  String idStr;
  String userName;
  String userIdStr;
  int accountType;
  int verifyStatus;
  String displayName;
  String accountName;
  String accountID;
  String profileUrl;
  String requireTimeStr;
  String approvalDateStr;
  String rejectContent;

  SocialAccountModel(
      {this.idStr,
        this.userName,
        this.userIdStr,
        this.accountType,
        this.verifyStatus,
        this.displayName,
        this.accountName,
        this.accountID,
        this.profileUrl,
        this.requireTimeStr,
        this.approvalDateStr,
        this.rejectContent});

  SocialAccountModel.fromJson(Map<String, dynamic> json) {
    idStr = json['IdStr'];
    userName = json['UserName'];
    userIdStr = json['UserIdStr'];
    accountType = json['AccountType'];
    verifyStatus = json['VerifyStatus'];
    displayName = json['DisplayName'];
    accountName = json['AccountName'];
    accountID = json['AccountID'];
    profileUrl = json['ProfileUrl'];
    requireTimeStr = json['RequireTimeStr'];
    approvalDateStr = json['ApprovalDateStr'];
    rejectContent = json['RejectContent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdStr'] = this.idStr;
    data['UserName'] = this.userName;
    data['UserIdStr'] = this.userIdStr;
    data['AccountType'] = this.accountType;
    data['VerifyStatus'] = this.verifyStatus;
    data['DisplayName'] = this.displayName;
    data['AccountName'] = this.accountName;
    data['AccountID'] = this.accountID;
    data['ProfileUrl'] = this.profileUrl;
    data['RequireTimeStr'] = this.requireTimeStr;
    data['ApprovalDateStr'] = this.approvalDateStr;
    data['RejectContent'] = this.rejectContent;
    return data;
  }
}
