import 'package:flutter/material.dart';
import 'package:wash_x/helpers/my_flutter_app_icons.dart';

class CustomWardrobeTile extends StatefulWidget {
  final int index;
  final VoidCallback callback;
  final bool isselected;
  final List<bool> list;

  const CustomWardrobeTile(
      {Key key, this.list, this.index, this.callback, this.isselected})
      : super(key: key);

  @override
  _CustomWardrobeTileState createState() => new _CustomWardrobeTileState();
}

class _CustomWardrobeTileState extends State<CustomWardrobeTile> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
          boxShadow: [
            new BoxShadow(offset: Offset(1.5, 2.5), color: Colors.grey[300])
          ]),
      child: new ExpansionTile(
        onExpansionChanged: (x) {
          if (x == true) {
            widget.list[widget.index] = true;
          } else {
            widget.list[widget.index] = false;
          }
          setState(() {});
        },
        trailing: 
        // GestureDetector(
        //   onTap: widget.callback,
        //   child:
           new Container(

            padding: EdgeInsets.all(3.5),
            decoration: BoxDecoration(
              boxShadow: [new BoxShadow(
                color: Colors.grey[300],
                blurRadius: 1.5,
                spreadRadius: 2.0
              )],
                shape: BoxShape.circle,
                color: widget.list[widget.index]
                    ? Colors.blue[700]
                    : Colors.white),
            child: new Icon(
              Icons.edit,
              color: Colors.black,
            ),
          //),
        ),
        title: new Row(
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.only(right: 10.0),
              child:  widget.list[widget.index]
                ?new Container(margin: EdgeInsets.only(left: 5.0),): Icon(MyFlutterApp.tshirt),
            ),
            widget.list[widget.index]
                ? new Text(
                    "T-Shirts",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  )
                : new Text("T-Shirts"),
            new Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width - 240),
              child: new Text("Included"),
            ),
          ],
        ),
        children: <Widget>[
          new Container(
            height: 80.0,
            alignment: Alignment.topCenter,
            margin: EdgeInsets.all(10.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Stack(
                  children: <Widget>[
                    new Container(
                      margin: EdgeInsets.only(right: 10.0),
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey[400])),
                      child: new Icon(
                        MyFlutterApp.tshirt,
                        color: Colors.grey[800],
                        size: 40.0,
                      ),
                    ),
                    new Container(
                      alignment: Alignment.center,
                      width: 25.0,
                      height: 25.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey[300])),
                      child: new Text(
                        "6",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blue[700]),
                      ),
                    )
                  ],
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Container(
                          padding: EdgeInsets.all(3.0),
                          child: new Icon(MyFlutterApp.archive),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey)),
                        ),
                        new Text(
                          "  Adidas",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    new Row(
                      children: <Widget>[
                        new Container(
                          width: 70.0,
                          height: 30.0,
                          child: new Container(
                            alignment: Alignment.center,
                            decoration: new BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                border: Border.all(
                                    color: Colors.grey[350], width: 2.0)),
                            child: new Text(
                              "T-SHIRTS",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 10.0),
                            ),
                          ),
                        ),
                        new Container(
                          width: 70.0,
                          height: 30.0,
                          margin: EdgeInsets.only(left: 10.0),
                          child: new Container(
                            alignment: Alignment.center,
                            decoration: new BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                border: Border.all(
                                    color: Colors.grey[350], width: 2.0)),
                            child: new Text(
                              "ADIDAS",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 10.0),
                            ),
                          ),
                        ),
                        new GestureDetector(
                          onTap: () {},
                          child: new Container(
                            margin: EdgeInsets.only(left: 10.0, right: 10.0),
                            height: 25.0,
                            width: 25.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green[300]),
                          ),
                        ),
                        new GestureDetector(
                          onTap: () {},
                          child: new Container(
                            margin: EdgeInsets.only(right: 10.0),
                            height: 25.0,
                            width: 25.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.pink[200]),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                // new Column(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: <Widget>[
                //     new Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: <Widget>[
                //         new Container(
                //           width: 70.0,
                //           height: 30.0,
                //           child: new RaisedButton(
                //             child: new Text(
                //               "ADIDAS",
                //               style: TextStyle(
                //                   color: Colors.black54, fontSize: 10.0),
                //             ),
                //             color: Colors.white,
                //             onPressed: () {},
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(25.0),
                //             ),
                //           ),
                //         ),
                //         new GestureDetector(
                //           onTap: () {},
                //           child: new Container(
                //             margin: EdgeInsets.only(left: 10.0, right: 10.0),
                //             height: 30.0,
                //             width: 30.0,
                //             decoration: BoxDecoration(
                //                 shape: BoxShape.circle,
                //                 color: Colors.green[300]),
                //           ),
                //         ),
                //         new GestureDetector(
                //           onTap: () {},
                //           child: new Container(
                //             margin: EdgeInsets.only(right: 10.0),
                //             height: 30.0,
                //             width: 30.0,
                //             decoration: BoxDecoration(
                //                 shape: BoxShape.circle,
                //                 color: Colors.pink[200]),
                //           ),
                //         )
                //       ],
                //     ),
                //   ],
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}
