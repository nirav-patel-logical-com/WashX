import 'package:flutter/material.dart';

class SpalshAnimations {
  SpalshAnimations(this.controller, this.context)
      : translateWindowAnimation = new Tween<double>(
          begin: 0.0,
          end: MediaQuery.of(context).size.height,
        ).animate(new CurvedAnimation(
          curve: Curves.easeIn,
          parent: controller,
        )),
        squeezeWidth = new Tween<double>(
                begin: MediaQuery.of(context).size.width,
                end: MediaQuery.of(context).size.width / 5 * 4)
            .animate(new CurvedAnimation(
          curve: new Interval(
            0.6,
            1.0,
            curve: Curves.ease,
          ),
          parent: controller,
        )),
        squeezeHeight = new Tween<double>(
                begin: MediaQuery.of(context).size.height,
                end: MediaQuery.of(context).size.width * 13 / 11)
            .animate(new CurvedAnimation(
          curve: new Interval(
            0.6,
            1.0,
            curve: Curves.ease,
          ),
          parent: controller,
        )),
        squeezeColor = new ColorTween(begin: Colors.blue, end: Colors.white)
            .animate(
                new CurvedAnimation(parent: controller, curve: Curves.ease)),
        squeezeFlexHeight = new Tween<double>(
                begin: MediaQuery.of(context).size.height / 4,
                end: MediaQuery.of(context).size.height / 24)
            .animate(new CurvedAnimation(
                curve: new Interval(
                  0.6,
                  1.0,
                  curve: Curves.ease,
                ),
                parent: controller));

  final AnimationController controller;
  final BuildContext context;
  final Animation<double> translateWindowAnimation;
  final Animation<double> squeezeWidth;
  final Animation<double> squeezeHeight;
  final Animation<double> squeezeFlexHeight;
  final Animation<Color> squeezeColor;
}
