class BaseRequest {

  String token;

  BaseRequest({this.token});

  Map<String, String> toHeaderMap() {
    Map<String, String> map = new Map();
    map["AppKey"] = "i4fKAo8kFLQzsMIZKh2ZyzysRkeMye";
    return map;
  }

}
