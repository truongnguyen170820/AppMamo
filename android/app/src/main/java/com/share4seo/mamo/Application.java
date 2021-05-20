package com.share4seo.mamo;

import io.flutter.app.FlutterApplication;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback;
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService;

//import com.google.firebase.FirebaseApp;

public class Application extends FlutterApplication implements PluginRegistrantCallback {
    @Override
    public void onCreate() {
        super.onCreate();
//        FirebaseApp.initializeApp(this);
        FlutterFirebaseMessagingService.setPluginRegistrant(this);
    }

    @Override
    public void registerWith(PluginRegistry registry) {
        com.share4seo.mamo.FirebaseCloudMessagingPluginRegistrant.registerWith(registry);
    }
}