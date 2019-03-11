import 'package:flutter/material.dart';

class WashItemColor {
  WashItemColor({this.color, this.colorName});
  String colorName;
  Color color;
}

List<WashItemColor> colorsList = [
  new WashItemColor(color: Colors.red, colorName: "Red"),
  new WashItemColor(color: Colors.yellow, colorName: "Yellow"),
  new WashItemColor(color: Colors.green, colorName: "Green"),
  new WashItemColor(color: Colors.black, colorName: "Black"),
  new WashItemColor(color: Colors.blue, colorName: "Blue"),
  new WashItemColor(color: Colors.yellow, colorName: "Yellow"),
];
