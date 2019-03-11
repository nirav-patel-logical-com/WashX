import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static const String IsSetupCompleteKey = "SetupCompleteKey";
  static const String PickUpTimeSelectedCountKey = "PickUpTimeSelectedCountKey";

  static Future<int> getPickUpTimeSelectedCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getInt(PickUpTimeSelectedCountKey);
    if (value == null) value = 0;
    return value;
  }

  static Future setPickUpTimeSelectedCount(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(PickUpTimeSelectedCountKey, value);
  }

  static Future<bool> getSetupCompleteValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getBool(IsSetupCompleteKey);
    if (value == null) value = false;
    return value;
  }

  static Future setSetupCompleteValue(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(IsSetupCompleteKey, value);
  }
}
