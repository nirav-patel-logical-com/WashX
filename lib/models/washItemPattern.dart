import 'package:flutter/material.dart';

class WashItemPattern {
  WashItemPattern({this.icon, this.pattern});
  IconData icon;
  String pattern;
}


List<WashItemPattern> patternList = [
  new WashItemPattern(icon: Icons.drag_handle, pattern: "Horizontal Stripes"),
  new WashItemPattern(
      icon: Icons.border_horizontal, pattern: "Vertical Stripes"),
  new WashItemPattern(icon: Icons.subject, pattern: "Horizontal shapes"),
  new WashItemPattern(icon: Icons.track_changes, pattern: "Vertical Shapes"),
];