class RecentReward {
  String fullName;
  String userName;
  double amount;
  String transationTimeStr;
  int readType;

  RecentReward({this.fullName, this.amount, this.transationTimeStr, this.userName, this.readType});

  RecentReward.fromJson(Map<String, dynamic> json) {
    fullName = json['FullName'];
    userName = json['UserName'];
    amount = json['Amount'];
    transationTimeStr = json['TransationTimeStr'];
    readType = json['ReadType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FullName'] = this.fullName;
    data['UserName'] = this.userName;
    data['Amount'] = this.amount;
    data['TransationTimeStr'] = this.transationTimeStr;
    data['ReadType'] = this.readType;
    return data;
  }
}
