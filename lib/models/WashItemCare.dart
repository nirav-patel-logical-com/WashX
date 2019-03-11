import 'package:flutter/material.dart';
import 'package:wash_x/helpers/my_flutter_app_icons.dart';

class WashItemCare {
  WashItemCare({this.care, this.icon});
  Icon icon;
  WashItemCareType care;
}

enum WashItemCareType {
  Warm,
  Cold,
  Hang,
  NoIron,
}

List<WashItemCare> careList=[
  new WashItemCare(
    care: WashItemCareType.Warm,
    icon: Icon(Icons.ac_unit)
  ),
  new WashItemCare(
    care: WashItemCareType.Hang,
    icon: Icon(MyFlutterApp.hourglass),
  ),
  new WashItemCare(
    care: WashItemCareType.NoIron,
    icon: Icon(Icons.sd_card)
  ),
  new WashItemCare(
    care: WashItemCareType.Warm ,
    icon: Icon(Icons.favorite_border),
  ),

];

// int tt= careList.first.care.index;
// var ttt= WashItemCareType.values[tt];