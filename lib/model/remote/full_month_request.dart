import 'package:mamo/api/base_request.dart';


class FullMonthRequest extends BaseRequest {
  final int month;
  final int year;

  FullMonthRequest(this.month, this.year);

  Map<String, String> toMap() {
    Map<String, String> map = Map();
    switch (this.month) {
      case 1:
        {
          map["FromDateStr"] = "01/01/" + this.year.toString();
          map["ToDateStr"] = "31/01/" + this.year.toString();
        }
        break;
      case 2:
        {
          map["FromDateStr"] = "01/02/" + this.year.toString();
          if (this.year % 4 == 0) {
            map["ToDateStr"] = "29/02/" + this.year.toString();
          } else
            map["ToDateStr"] = "28/02/" + this.year.toString();
        }
        break;
      case 3:
        {
          map["FromDateStr"] = "01/03/" + this.year.toString();
          map["ToDateStr"] = "31/03/" + this.year.toString();
        }
        break;
      case 4:
        {
          map["FromDateStr"] = "01/04/" + this.year.toString();
          map["ToDateStr"] = "30/04/" + this.year.toString();
        }
        break;
      case 5:
        {
          map["FromDateStr"] = "01/05/" + this.year.toString();
          map["ToDateStr"] = "31/05/" + this.year.toString();
        }
        break;
      case 6:
        {
          map["FromDateStr"] = "01/06/" + this.year.toString();
          map["ToDateStr"] = "30/06/" + this.year.toString();
        }
        break;
      case 7:
        {
          map["FromDateStr"] = "01/07/" + this.year.toString();
          map["ToDateStr"] = "31/07/" + this.year.toString();
        }
        break;
      case 8:
        {
          map["FromDateStr"] = "01/08/" + this.year.toString();
          map["ToDateStr"] = "31/08/" + this.year.toString();
        }
        break;
      case 9:
        {
          map["FromDateStr"] = "01/09/" + this.year.toString();
          map["ToDateStr"] = "30/09/" + this.year.toString();
        }
        break;
      case 10:
        {
          map["FromDateStr"] = "01/10/" + this.year.toString();
          map["ToDateStr"] = "31/10/" + this.year.toString();
        }
        break;
      case 11:
        {
          map["FromDateStr"] = "01/11/" + this.year.toString();
          map["ToDateStr"] = "30/11/" + this.year.toString();
        }
        break;
      case 12:
        {
          map["FromDateStr"] = "01/12/" + this.year.toString();
          map["ToDateStr"] = "31/12/" + this.year.toString();
        }
        break;
    }
    return map;
  }
}
