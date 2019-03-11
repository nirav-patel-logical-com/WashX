import 'dart:async';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart';
import 'package:wash_x/constants.dart';
import 'package:wash_x/helpers/sharedPrefrences.dart';
import 'package:flutter/material.dart';
import 'package:crashlytics/crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:wash_x/pages/mainPage.dart';
import 'package:wash_x/pages/splashScreenPage.dart';


 

void main() async {
 
  FirebasePerformance.instance.setPerformanceCollectionEnabled(true);
  FirebaseAnalytics analytics = new FirebaseAnalytics();
  // Crashlytics.setup();
   bool _isLoggedIn = false;
   FirebaseUser firebaseUser;
  firebaseUser = await FirebaseAuth.instance.currentUser();
   if (firebaseUser != null) {
     _isLoggedIn = true;
   } else {
     _isLoggedIn = false;
   }
    // List<CameraDescription> cameras;
    //  cameras = await availableCameras();
  RemoteConfig remoteConfig = await setupRemoteConfig();
  await remoteConfig.fetch(expiration: const Duration(hours: 4));
  await remoteConfig.activateFetched();
  var remoteValue = remoteConfig.getValue('constants_initializer');
  Constants.initialize(remoteValue);
  bool _isAcoountSetupCompleate =
    await MySharedPreferences.getSetupCompleteValue();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.white,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarDividerColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(
    new MaterialApp(
      navigatorObservers: [new FirebaseAnalyticsObserver(analytics: analytics)],
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        accentColor: Colors.blue,
        canvasColor: Colors.white,
      ),
       home: SplashScreenPage(_isLoggedIn,_isAcoountSetupCompleate),
       // home: MainPage(remoteConfig: remoteConfig,),
      //home: WardrobePage(),
      // home:NewItemPage(cameras),
      // Building Page Routes
      routes: <String, WidgetBuilder>{
        //  '/HomePage': (BuildContext context) => new HomePage(false),
      },
    ),
  );
}

Future<RemoteConfig> setupRemoteConfig() async {
  final RemoteConfig remoteConfig = await RemoteConfig.instance;
  // Enable developer mode to relax fetch throttling
  remoteConfig.setConfigSettings(new RemoteConfigSettings(debugMode: true));
  remoteConfig.setDefaults(<String, dynamic>{
    'welcome': 'default welcome',
    'hello': 'default hello',
    'constants_initialize': '[{}]',
  });

  return remoteConfig;
}
