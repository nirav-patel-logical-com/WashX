import 'package:flutter/material.dart';

class CustomTime extends StatefulWidget {
  final int index;
  final VoidCallback callback;
  final bool isselected;

  const CustomTime(
      {Key key,
      this.index,
      this.callback,
      this.isselected})
      : super(key: key);

  @override
  _CustomTimeState createState() => new _CustomTimeState();
}

class _CustomTimeState extends State<CustomTime> {

  @override
  Widget build(BuildContext context) {
    var label="";
    if ( widget.index % 4 == 0) {
      label = "MORNING";
    } else if (widget.index %4 == 1) {
      label = "NOON";
    } else if (widget.index % 4 == 2) {
      label = "EVENING";
    }
  
    return new Column(
      children: <Widget>[
        new GestureDetector(
            onTap: widget.callback,
            child: new Stack(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(top: 10.0, left: 10.0),
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                      color: widget.isselected ? Colors.blue : Colors.white,
                      shape: BoxShape.circle),
                ),
                Icon(
                  Icons.access_time,
                  size: 70.0,
                  color: ! widget.isselected ? Colors.blue : Colors.white,
                ),
              ],
            )),
        new Text(
         label,
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class Element {
  bool isselected;
  Element({this.isselected});
}
