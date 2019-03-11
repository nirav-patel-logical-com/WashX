import 'package:flutter/material.dart';

class BoxDecorationParam {
  final double topLeft;
  final double bottomLeft;
  final double topRight;
  final double bottomRight;
  final Color borderColor;


  BoxDecorationParam(this.topLeft, this.bottomLeft, this.topRight,
      this.bottomRight, this.borderColor);

  BoxDecoration getBoxDecoration() {
    return new BoxDecoration(
      color: borderColor,
      borderRadius: new BorderRadius.only(
        topLeft: new Radius.circular(topLeft),
        bottomLeft: new Radius.circular(bottomLeft),
        topRight: new Radius.circular(topRight),
        bottomRight: new Radius.circular(bottomRight),
      ),
    );
  }
}

class BoxBorderParam {
  final double topLeft;
  final double bottomLeft;
  final double topRight;
  final double bottomRight;
  final Color borderColor;
  final double borderWidth;


  BoxBorderParam(this.topLeft, this.bottomLeft, this.topRight,
      this.bottomRight, this.borderColor,this.borderWidth);

  BoxDecoration getBoxDecoration() {
    return new BoxDecoration(
      border: Border.all(
          color: borderColor,
          width: borderWidth
      ),
      borderRadius: new BorderRadius.only(
        topLeft: new Radius.circular(topLeft),
        bottomLeft: new Radius.circular(bottomLeft),
        topRight: new Radius.circular(topRight),
        bottomRight: new Radius.circular(bottomRight),
      ),
    );
  }
}
