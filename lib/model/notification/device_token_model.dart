class DeviceTokenModel {
  String devicePushId;
  int type;

  DeviceTokenModel(this.devicePushId, this.type);

  DeviceTokenModel.fromJson(Map<String, dynamic> json) {
    devicePushId = json['DevicePushId'];
    type = json['Type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DevicePushId'] = this.devicePushId;
    data['Type'] = this.type;
    return data;
  }
}
