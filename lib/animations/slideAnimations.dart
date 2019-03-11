import 'package:flutter/material.dart';

class SlideAnimation {
  SlideAnimation(this.controller, this.context)
      : slide = new Tween<double>(
          begin: 0.0,
          end: MediaQuery.of(context).size.width,
        ).animate(new CurvedAnimation(
          curve: Curves.easeOut,
          reverseCurve: Curves.easeIn,
          parent: controller,
        ));

  final BuildContext context;
  final AnimationController controller;
  final Animation<double> slide;
}