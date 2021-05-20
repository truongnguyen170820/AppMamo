import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject = BehaviorSubject<ReceivedNotification>();
//final BehaviorSubject<String> selectNotificationSubject = BehaviorSubject<String>();
Future<void> handleShowNotification(title,body) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'defaultChannel', 'defaultChannel', 'defaultChannel',
      importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0, title, body, platformChannelSpecifics,
      payload: '');
}