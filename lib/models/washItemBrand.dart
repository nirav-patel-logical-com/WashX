import 'package:flutter/material.dart';
import 'package:wash_x/helpers/my_flutter_app_icons.dart';

class WashItemBrand {
  WashItemBrand({this.icon, this.name});
  String name;
  Icon icon;
}

List<WashItemBrand> brandList = [
  new WashItemBrand(
      icon: Icon(
        MyFlutterApp.alarm,
        size: 50.0,
      ),
      name: "Adidas"),
  new WashItemBrand(
      icon: Icon(
        MyFlutterApp.gradient,
        size: 50.0,
      ),
      name: "Puma"),
  new WashItemBrand(
      icon: Icon(
        MyFlutterApp.mail_outline,
        size: 50.0,
      ),
      name: "Nike"),
  new WashItemBrand(
      icon: Icon(
        MyFlutterApp.language,
        size: 50.0,
      ),
      name: "Rambo"),
  new WashItemBrand(
      icon: Icon(
        MyFlutterApp.wrench,
        size: 50.0,
      ),
      name: "Raja"),
  new WashItemBrand(
      icon: Icon(
        MyFlutterApp.local_drink,
        size: 50.0,
      ),
      name: "Khadoos"),
];