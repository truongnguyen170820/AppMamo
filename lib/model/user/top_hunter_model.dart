class TopHunterModel {
  String idStr;
  String userIdStr;
  String username;
  String fullName;
  int point;
  String userAvatar;
  String lastUpdateStr;
  int numPageReadStory;
  int numPageReadNews;
  int numDurationViewVideo;
  double totalMoney;

  TopHunterModel(
      {this.idStr,
        this.userIdStr,
        this.username,
        this.fullName,
        this.point,
        this.userAvatar,
        this.lastUpdateStr,
        this.numPageReadStory,
        this.numPageReadNews,
        this.numDurationViewVideo,
        this.totalMoney});

  TopHunterModel.fromJson(Map<String, dynamic> json) {
    idStr = json['IdStr'];
    userIdStr = json['UserIdStr'];
    username = json['Username'];
    fullName = json['FullName'];
    point = json['Point'];
    userAvatar = json['UserAvatar'];
    lastUpdateStr = json['LastUpdateStr'];
    numPageReadStory = json['NumPageReadStory'];
    numPageReadNews = json['NumPageReadNews'];
    numDurationViewVideo = json['NumDurationViewVideo'];
    totalMoney = json['TotalMoney'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdStr'] = this.idStr;
    data['UserIdStr'] = this.userIdStr;
    data['Username'] = this.username;
    data['FullName'] = this.fullName;
    data['Point'] = this.point;
    data['UserAvatar'] = this.userAvatar;
    data['LastUpdateStr'] = this.lastUpdateStr;
    data['NumPageReadStory'] = this.numPageReadStory;
    data['NumPageReadNews'] = this.numPageReadNews;
    data['NumDurationViewVideo'] = this.numDurationViewVideo;
    data['TotalMoney'] = this.totalMoney;
    return data;
  }
}

// class TopHunterModel {
//   String idStr;
//   String userIdStr;
//   String username;
//   String fullName;
//   int point;
//   String userAvatar;
//
//   TopHunterModel(
//       {this.idStr, this.userIdStr, this.username, this.fullName, this.point, this.userAvatar});
//
//   TopHunterModel.fromJson(Map<String, dynamic> json) {
//     idStr = json['IdStr'];
//     userIdStr = json['UserIdStr'];
//     username = json['Username'];
//     fullName = json['FullName'];
//     point = json['Point'];
//     userAvatar = json['UserAvatar'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['IdStr'] = this.idStr;
//     data['UserIdStr'] = this.userIdStr;
//     data['Username'] = this.username;
//     data['FullName'] = this.fullName;
//     data['Point'] = this.point;
//     data['UserAvatar'] = this.userAvatar;
//     return data;
//   }
// }
