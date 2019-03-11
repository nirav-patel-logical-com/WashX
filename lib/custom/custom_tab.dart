import 'package:flutter/material.dart';

class CustomTab extends StatelessWidget{
  CustomTab({this.icon});
  Icon icon;

  @override
  Widget build(BuildContext context) {
    //print('context.size=${context.size}');
    return new Container(
      child: new Stack(children: <Widget>[
        new Container(
          margin: new EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
          height: 48.0,
          width: 48.0,
          decoration:  new BoxDecoration(
            color: new Color.fromARGB(100, 196, 100, 155),
            shape: BoxShape.rectangle,
            borderRadius: new BorderRadius.circular(5.0))),
        icon
      ]));
  }
}