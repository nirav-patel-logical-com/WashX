import 'package:flutter/material.dart';
import 'package:wash_x/enum.dart';

class NavigationModel {
  NavigationModel({this.pageType, this.page});

  final Widget page;
  final PageType pageType;
}
