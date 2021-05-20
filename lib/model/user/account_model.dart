// class AccountModel {
//   String idStr;
//   String createdDateStr;
//   Null description;
//   int preBalance;
//   String lastChangedDateStr;
//   Null accountNumber;
//   Null currency;
//   String userIdStr;
//   String username;
//   int prePoint;
//   int point;
//   int level;
//   int status;
//   Null introduceCode;
//   bool isGetBonusIntruduceCode;
//   bool isModeTest;
//   int balance;
//   int totalBalance;
//   int totalBalanceReadStory;
//   int totalBalanceReadNews;
//   int totalBalanceViewVideo;
//   int totalBalanceAffiliate;
//   int totalPageReadStory;
//   int totalPageReadNews;
//   int totalMinuteViewVideo;
//
//   AccountModel(
//       {this.idStr,
//         this.createdDateStr,
//         this.description,
//         this.preBalance,
//         this.lastChangedDateStr,
//         this.accountNumber,
//         this.currency,
//         this.userIdStr,
//         this.username,
//         this.prePoint,
//         this.point,
//         this.level,
//         this.status,
//         this.introduceCode,
//         this.isGetBonusIntruduceCode,
//         this.isModeTest,
//         this.balance,
//         this.totalBalance,
//         this.totalBalanceReadStory,
//         this.totalBalanceReadNews,
//         this.totalBalanceViewVideo,
//         this.totalBalanceAffiliate,
//         this.totalPageReadStory,
//         this.totalPageReadNews,
//         this.totalMinuteViewVideo});
//
//   AccountModel.fromJson(Map<String, dynamic> json) {
//     idStr = json['IdStr'];
//     createdDateStr = json['CreatedDateStr'];
//     description = json['Description'];
//     preBalance = json['PreBalance'];
//     lastChangedDateStr = json['LastChangedDateStr'];
//     accountNumber = json['AccountNumber'];
//     currency = json['Currency'];
//     userIdStr = json['UserIdStr'];
//     username = json['Username'];
//     prePoint = json['PrePoint'];
//     point = json['Point'];
//     level = json['Level'];
//     status = json['Status'];
//     introduceCode = json['IntroduceCode'];
//     isGetBonusIntruduceCode = json['IsGetBonusIntruduceCode'];
//     isModeTest = json['IsModeTest'];
//     balance = json['Balance'];
//     totalBalance = json['TotalBalance'];
//     totalBalanceReadStory = json['TotalBalanceReadStory'];
//     totalBalanceReadNews = json['TotalBalanceReadNews'];
//     totalBalanceViewVideo = json['TotalBalanceViewVideo'];
//     totalBalanceAffiliate = json['TotalBalanceAffiliate'];
//     totalPageReadStory = json['TotalPageReadStory'];
//     totalPageReadNews = json['TotalPageReadNews'];
//     totalMinuteViewVideo = json['TotalMinuteViewVideo'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['IdStr'] = this.idStr;
//     data['CreatedDateStr'] = this.createdDateStr;
//     data['Description'] = this.description;
//     data['PreBalance'] = this.preBalance;
//     data['LastChangedDateStr'] = this.lastChangedDateStr;
//     data['AccountNumber'] = this.accountNumber;
//     data['Currency'] = this.currency;
//     data['UserIdStr'] = this.userIdStr;
//     data['Username'] = this.username;
//     data['PrePoint'] = this.prePoint;
//     data['Point'] = this.point;
//     data['Level'] = this.level;
//     data['Status'] = this.status;
//     data['IntroduceCode'] = this.introduceCode;
//     data['IsGetBonusIntruduceCode'] = this.isGetBonusIntruduceCode;
//     data['IsModeTest'] = this.isModeTest;
//     data['Balance'] = this.balance;
//     data['TotalBalance'] = this.totalBalance;
//     data['TotalBalanceReadStory'] = this.totalBalanceReadStory;
//     data['TotalBalanceReadNews'] = this.totalBalanceReadNews;
//     data['TotalBalanceViewVideo'] = this.totalBalanceViewVideo;
//     data['TotalBalanceAffiliate'] = this.totalBalanceAffiliate;
//     data['TotalPageReadStory'] = this.totalPageReadStory;
//     data['TotalPageReadNews'] = this.totalPageReadNews;
//     data['TotalMinuteViewVideo'] = this.totalMinuteViewVideo;
//     return data;
//   }
// }