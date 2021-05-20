class ReadingPageModel {
  String idStr;
  String pageUrl;
  double totalSecond;
  double requiredDuration;
  bool isCompleted;

  ReadingPageModel(
      {this.idStr,
        this.pageUrl,
        this.totalSecond,
        this.requiredDuration,
        this.isCompleted});

  ReadingPageModel.fromJson(Map<String, dynamic> json) {
    idStr = json['IdStr'];
    pageUrl = json['PageUrl'];
    totalSecond = json['TotalSecond'];
    requiredDuration = json['RequiredDuration'];
    isCompleted = json['IsCompleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdStr'] = this.idStr;
    data['PageUrl'] = this.pageUrl;
    data['TotalSecond'] = this.totalSecond;
    data['RequiredDuration'] = this.requiredDuration;
    data['IsCompleted'] = this.isCompleted;
    return data;
  }
}
