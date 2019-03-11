import 'package:flutter/material.dart';

class CustomImage extends StatefulWidget {
  final int index;
  final VoidCallback callback;
  final bool isselected;
  final Widget photo;

  const CustomImage(
      {Key key, this.index, this.callback, this.isselected, this.photo})
      : super(key: key);

  @override
  _CustomImageState createState() => new _CustomImageState();
}

class _CustomImageState extends State<CustomImage> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new GestureDetector(
          onTap: widget.callback,
          child: new Stack(
            children: <Widget>[
              new GestureDetector(
                // onLongPress: () {
                //   _isSelected = !_isSelected;
                //   setState(() {});
                // },
                onLongPress: widget.callback,
                child: new Container(
                  padding: EdgeInsets.all(5.0),
                  margin: EdgeInsets.only(top: 10.0, left: 10.0),
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    boxShadow: [
                      new BoxShadow(
                          blurRadius: 1.5,
                          spreadRadius: 2.0,
                          color: Colors.grey[300])
                    ],
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                  ),
                  child: widget.photo,
                ),
              ),
              !widget.isselected
                  ?
                  //  !_isSelected
                  new Container()
                  : new Positioned(
                      left: 20.0,
                      top: 20.0,
                      child: new Container(
                        padding: EdgeInsets.all(5.0),
                        child: new Icon(
                          Icons.done,
                          color: Colors.black,
                          size: 10.0,
                        ),
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                            boxShadow: [
                              new BoxShadow(
                                  color: Colors.grey[350],
                                  blurRadius: 1.5,
                                  spreadRadius: 2.0)
                            ]),
                      ),
                    )
            ],
          )),
    );
  }
}
