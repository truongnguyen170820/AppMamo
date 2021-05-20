import 'event_type.dart';

class StreamEvent<T> {
  StreamEventType eventType;
  List<T> data;
  String message;

  StreamEvent({this.eventType, this.data, this.message});
}