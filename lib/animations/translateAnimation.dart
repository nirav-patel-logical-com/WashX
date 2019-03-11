import 'package:flutter/material.dart';

class TranslateAnimations {
  TranslateAnimations(this.controller, this.context)
      : translateWindowAnimation = new Tween<double>(
          begin: 0.0,
          end: MediaQuery.of(context).size.height,
        ).animate(new CurvedAnimation(
          curve: Curves.easeIn,
          parent: controller,
        ));
  final AnimationController controller;
  final BuildContext context;
  final Animation<double> translateWindowAnimation;

}
