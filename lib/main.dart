import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hive/hive.dart';
import 'package:mamo/utils/app_constant.dart';
import 'package:mamo/utils/screen/screen_utils.dart';
import 'package:mamo/views/splash_view.dart';
import 'package:mamo/views/user/signin_account_view.dart';
import 'package:mamo/widget/notification_global.dart';
import 'package:path_provider/path_provider.dart';
import 'blocs/notifications/get_notification_count_blog.dart';
//
Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
    if (message.containsKey('notification')) {
      // Handle notification message
      final notification = message['notification'] as Map<dynamic, dynamic>;
      if (notification.containsKey('title') &&
          notification.containsKey('body')) {
        handleShowNotification(
            notification['title'] as String, notification['body'] as String);
      }
    }
  }
  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }
  // Or do other work.
}
//
NotificationAppLaunchDetails notificationAppLaunchDetails;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  var appDocDirectory = await getApplicationDocumentsDirectory();
  Hive..init(appDocDirectory.path);
  await Hive.openBox(AppConstants.HIVE_TASK_BOX);
  //  init notification
  notificationAppLaunchDetails =
  await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  var initializationSettingsAndroid =
      AndroidInitializationSettings('mipmap/ic_launcher');
  // Note: permissions aren't requested here just to demonstrate that can be done later using the `requestPermissions()` method
  // of the `IOSFlutterLocalNotificationsPlugin` class
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: null);
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: null);

  //add firebase crashlytics
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  Isolate.current.addErrorListener(RawReceivePort((pair) async {
    final List<dynamic> errorAndStacktrace = pair;
    await FirebaseCrashlytics.instance.recordError(
      errorAndStacktrace.first,
      errorAndStacktrace.last,
    );
  }).sendPort);
  runZonedGuarded<Future<void>>(() async {
    // ...
  }, FirebaseCrashlytics.instance.recordError);
  // if (kDebugMode)
  //   FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final authenBloc = AuthenBloc();
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        if (message.containsKey('notification')) {
          // Handle notification message
          final notification = message['notification'] as Map<dynamic, dynamic>;
          if (notification.containsKey('title') &&
              notification.containsKey('body')) {
            handleShowNotification(notification['title'] as String,
                notification['body'] as String);
          }
        }
      },
      onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        if (message.containsKey('notification')) {
          // Handle notification message
          final notification = message['notification'] as Map<dynamic, dynamic>;
          if (notification.containsKey('title') &&
              notification.containsKey('body')) {
            handleShowNotification(notification['title'] as String,
                notification['body'] as String);
          }
        }
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        if (message.containsKey('notification')) {
          // Handle notification message
          final notification = message['notification'] as Map<dynamic, dynamic>;
          if (notification.containsKey('title') &&
              notification.containsKey('body')) {
            handleShowNotification(notification['title'] as String,
                notification['body'] as String);
          }
        }
      },
    );

    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    // authenBloc.loadData();

    return MaterialApp(
      title: 'Mamo',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(fontFamily: 'Coiny'),
      builder: (BuildContext context, Widget child) {
        final data = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);
        ScreenUtil.init(context, width:375, height: 667, allowFontScaling: true);
        return MediaQuery(data: data, child: child);
      },
      home: SplashView(),
    );
  }
  @override
  void dispose() {
    // NotificationCountBloc().dispose();
    // TODO: implement dispose
    super.dispose();
  }
}

// final userBox = Hive.box(AppConstants.HIVE_USER_BOX);
