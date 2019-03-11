import 'package:flutter/material.dart';
import 'dart:math' as math;

class WashButton extends StatefulWidget {
  WashButton({
    this.image,
    this.onPress
    });

  final Widget image;
  final VoidCallback onPress;
  @override
  _WashButton createState() => new _WashButton();
}

class _WashButton extends State<WashButton> with SingleTickerProviderStateMixin {


  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  void _doWash(){
    widget.onPress;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
      animation: _controller,
      child: new InkWell(
        child: new FittedBox(
          child: widget.image,
          fit: BoxFit.fill,
        ),
        onTap: widget.onPress
      ),
      builder: (BuildContext context, Widget child) {
        return new Transform.rotate(
          alignment: Alignment.center,
          angle: (math.sin((math.pi*2)*_controller.value)),
          child: child,
        );
      },
    );
  }
}