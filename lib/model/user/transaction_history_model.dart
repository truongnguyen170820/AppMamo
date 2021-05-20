class TransactionHistoryModel {
  String idStr;
  double amount;
  String createdDateStr;
  int reqStatus;
  int payStatus;
  double rewardBalance;
  int rewardType;
  int payType;
  String cardCode;
  String rejectContent;
  String acceptDateStr;
  String rejectDateStr;
  String serial;
  TransactionHistoryModel(
      {this.idStr,
        this.amount,
        this.createdDateStr,
        this.reqStatus,
        this.payStatus,
        this.rewardBalance,
        this.rewardType,
        this.payType,
        this.cardCode,
        this.serial,
        this.rejectContent,
        this.acceptDateStr,
        this.rejectDateStr
      });

  TransactionHistoryModel.fromJson(Map<String, dynamic> json) {
    idStr = json['IdStr'];
    amount = json['Amount'];
    createdDateStr = json['CreatedDateStr'];
    reqStatus = json['ReqStatus'];
    payStatus = json['PayStatus'];
    rewardBalance = json['RewardBalance'];
    rewardType = json['RewardType'];
    payType = json['PayType'];
    cardCode = json['CardCode'];
    serial = json['Serial'];
    rejectContent = json['RejectContent'];
    acceptDateStr = json['AcceptDateStr'];
    rejectDateStr = json['RejectDateStr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdStr'] = this.idStr;
    data['Amount'] = this.amount;
    data['CreatedDateStr'] = this.createdDateStr;
    data['ReqStatus'] = this.reqStatus;
    data['PayStatus'] = this.payStatus;
    data['RewardBalance'] = this.rewardBalance;
    data['RewardType'] = this.rewardType;
    data['PayType'] = this.payType;
    data['CardCode'] = this.cardCode;
    data['Serial'] = this.serial;
    data['RejectContent'] = this.rejectContent;
    data['AcceptDateStr'] = this.acceptDateStr;
    data['RejectDateStr'] = this.rejectDateStr;
    return data;
  }
}
