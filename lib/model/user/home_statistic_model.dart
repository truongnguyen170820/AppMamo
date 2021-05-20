// class HomeStatisticModel {
//   int value;
//   int today;
//   int limit;
//   int remainToday;
//
//   HomeStatisticModel({this.value, this.today, this.limit, this.remainToday});
//
//   HomeStatisticModel.fromJson(Map<String, dynamic> json) {
//     value = json['Value'];
//     today = json['Today'];
//     limit = json['Limit'];
//     remainToday = json['RemainToday'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Value'] = this.value;
//     data['Today'] = this.today;
//     data['Limit'] = this.limit;
//     data['RemainToday'] = this.remainToday;
//     return data;
//   }
// }

class HomeStatisticModel {
  int numPageReadStory;
  int numPageReadNews;
  int numDurationViewVideo;
  double totalMoney;
  double totalMoneyReadStory;
  double totalMoneyReadNews;
  double totalMoneyViewVideo;

  HomeStatisticModel(
      {this.numPageReadStory,
        this.numPageReadNews,
        this.numDurationViewVideo,
        this.totalMoney,
        this.totalMoneyReadStory,
        this.totalMoneyReadNews,
        this.totalMoneyViewVideo});

  HomeStatisticModel.fromJson(Map<String, dynamic> json) {
    numPageReadStory = json['NumPageReadStory'];
    numPageReadNews = json['NumPageReadNews'];
    numDurationViewVideo = json['NumDurationViewVideo'];
    totalMoney = json['TotalMoney'];
    totalMoneyReadStory = json['TotalMoneyReadStory'];
    totalMoneyReadNews = json['TotalMoneyReadNews'];
    totalMoneyViewVideo = json['TotalMoneyViewVideo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NumPageReadStory'] = this.numPageReadStory;
    data['NumPageReadNews'] = this.numPageReadNews;
    data['NumDurationViewVideo'] = this.numDurationViewVideo;
    data['TotalMoney'] = this.totalMoney;
    data['TotalMoneyReadStory'] = this.totalMoneyReadStory;
    data['TotalMoneyReadNews'] = this.totalMoneyReadNews;
    data['TotalMoneyViewVideo'] = this.totalMoneyViewVideo;
    return data;
  }
}
