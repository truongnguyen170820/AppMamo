class CheckOtpModel {
  bool canSendSms;

  CheckOtpModel({this.canSendSms});

  CheckOtpModel.fromJson(Map<String, dynamic> json) {
    canSendSms = json['canSendSms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['canSendSms'] = this.canSendSms;
    return data;
  }
}
