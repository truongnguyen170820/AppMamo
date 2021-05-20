class BaseRequest {

  String sessionId;

  BaseRequest({this.sessionId});

  Map<String, String> toHeaderMap() {
    Map<String, String> map = new Map();
    map["AppKey"] = "i4fKAo8kFLQzsMIZKh2ZyzysRkeMye";
    if(sessionId != null) {
      map["SessionId"] = this.sessionId;
    }
    return map;
  }
}
