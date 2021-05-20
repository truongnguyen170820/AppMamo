// class MyMemberModel {
//   String userIdStr;
//   String userName;
//   String fullName;
//   String userAvatar;
//   int childrenLevel1;
//   int childrenLevel2;
//   String connectParentLevel1DateStr;
//   String connectParentLevel2DateStr;
//
//   MyMemberModel(
//       {this.userIdStr,
//         this.userName,
//         this.fullName,
//         this.userAvatar,
//         this.childrenLevel1,
//         this.childrenLevel2,
//         this.connectParentLevel1DateStr,
//         this.connectParentLevel2DateStr});
//
//   MyMemberModel.fromJson(Map<String, dynamic> json) {
//     userIdStr = json['UserIdStr'];
//     userName = json['UserName'];
//     fullName = json['FullName'];
//     userAvatar = json['UserAvatar'];
//     childrenLevel1 = json['ChildrenLevel1'];
//     childrenLevel2 = json['ChildrenLevel2'];
//     connectParentLevel1DateStr = json['ConnectParentLevel1DateStr'];
//     connectParentLevel2DateStr = json['ConnectParentLevel2DateStr'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['UserIdStr'] = this.userIdStr;
//     data['UserName'] = this.userName;
//     data['FullName'] = this.fullName;
//     data['UserAvatar'] = this.userAvatar;
//     data['ChildrenLevel1'] = this.childrenLevel1;
//     data['ChildrenLevel2'] = this.childrenLevel2;
//     data['ConnectParentLevel1DateStr'] = this.connectParentLevel1DateStr;
//     data['ConnectParentLevel2DateStr'] = this.connectParentLevel2DateStr;
//     return data;
//   }
// }
class MyMemberModel {
  String userIdStr;
  String userName;
  String fullName;
  String userAvatar;
  double totalPageReadStory;
  double totalPageReadNews;
  double totalMinuteViewVideo;
  String dateAffiliate;
  String dateAffiliateStr;

  MyMemberModel(
      {this.userIdStr,
        this.userName,
        this.fullName,
        this.userAvatar,
        this.totalPageReadStory,
        this.totalPageReadNews,
        this.totalMinuteViewVideo,
        this.dateAffiliate,
        this.dateAffiliateStr});

  MyMemberModel.fromJson(Map<String, dynamic> json) {
    userIdStr = json['UserIdStr'];
    userName = json['UserName'];
    fullName = json['FullName'];
    userAvatar = json['UserAvatar'];
    totalPageReadStory = json['TotalPageReadStory'];
    totalPageReadNews = json['TotalPageReadNews'];
    totalMinuteViewVideo = json['TotalMinuteViewVideo'];
    dateAffiliate = json['DateAffiliate'];
    dateAffiliateStr = json['DateAffiliateStr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserIdStr'] = this.userIdStr;
    data['UserName'] = this.userName;
    data['FullName'] = this.fullName;
    data['UserAvatar'] = this.userAvatar;
    data['TotalPageReadStory'] = this.totalPageReadStory;
    data['TotalPageReadNews'] = this.totalPageReadNews;
    data['TotalMinuteViewVideo'] = this.totalMinuteViewVideo;
    data['DateAffiliate'] = this.dateAffiliate;
    data['DateAffiliateStr'] = this.dateAffiliateStr;
    return data;
  }
}