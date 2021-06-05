import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:mamo/model/notification/notify_total_unread_model.dart';
import 'package:mamo/utils/global_cache.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../bloc.dart';
class NotificationCountBloc implements Bloc {
  MqttServerClient client =
  MqttServerClient.withPort('broker.timesoft.vn', 'flutter_clien', 18883);
  StreamController notifyCounterStream = StreamController<int>.broadcast();

  static final NotificationCountBloc _singleton = NotificationCountBloc._internal();
  factory NotificationCountBloc(){
    return _singleton;
  }

  NotificationCountBloc._internal();

  Future<MqttServerClient> connect() async {
    client.logging(on: false);
    client.keepAlivePeriod = 20;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    final connMessage = MqttConnectMessage()
        .withClientIdentifier(GlobalCache().loginData.idStr)
        .keepAliveFor(20)
        .withWillTopic('willtopic')
        .withWillMessage('Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;
    try {
      await client.connect('timeface', 'timeface123@');
    } catch (e) {
      // print('Exception: $e');
      client.disconnect();
    }

    try {
      if (client.connectionStatus.state == MqttConnectionState.connected) {
        client.subscribe('share4seo/appcaykhe/' + GlobalCache().loginData.idStr,
            MqttQos.atLeastOnce);
        client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
          try {
            final MqttPublishMessage message = c[0].payload;
            final payload = MqttPublishPayload.bytesToStringAsString(
                message.payload.message);
            // print("MQTT received:" + payload);
            NotifyUnreadModel result =
            NotifyUnreadModel.fromJson(jsonDecode(payload));
            notifyCounterStream.sink.add(result.totanUnRead);
          } on Exception catch (e) {
            // print('Parse message failed');
          }
        });
      } else {
        client.disconnect();
      }
    } on Exception catch (e) {
      client.disconnect();
    }
    return client;
  }
  void onConnected() {
    // print('MQTT Connected');
  }

  void onDisconnected() {
    // print('MQTT Disconnected');
  }

  void onSubscribed(String topic) {
    // print('MQTT Subscribed topic: $topic');
  }

  checkMQTTDisconnect() {
    new Timer.periodic(const Duration(seconds: 30), (Timer t) {
      try {
        if (client != null &&
            client.connectionStatus.state == MqttConnectionState.disconnected) {
          Connectivity().checkConnectivity().then((connectResult) {
            if (connectResult == ConnectivityResult.mobile ||
                connectResult == ConnectivityResult.wifi) {
              client.connect('timeface', 'timeface123@');
            }
          });
        } else if (client != null &&
            client.getSubscriptionsStatus(
                'share4seo/appcaykhe/' + GlobalCache().loginData.idStr) ==
                MqttSubscriptionStatus.doesNotExist) {
          Connectivity().checkConnectivity().then((connectResult) {
            if (connectResult == ConnectivityResult.mobile ||
                connectResult == ConnectivityResult.wifi) {
              client.subscribe(
                  'share4seo/appcaykhe/' + GlobalCache().loginData.idStr,
                  MqttQos.atLeastOnce);
              client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
                try {
                  final MqttPublishMessage message = c[0].payload;
                  final payload = MqttPublishPayload.bytesToStringAsString(
                      message.payload.message);
                  // print("MQTT received:" + payload);
                  NotifyUnreadModel result =
                  NotifyUnreadModel.fromJson(jsonDecode(payload));
                  notifyCounterStream.sink.add(result.totanUnRead);
                } on Exception catch (e) {
                  // print('Parse message failed');
                }
              });
            }
          });
        }
      } catch (err) {
        // print('Caught error: $err');
      }
    });
  }
  @override
  void dispose() {
    notifyCounterStream.close();
    client.disconnect();
    // TODO: implement dispose
  }
}
