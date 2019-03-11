import 'package:flutter/material.dart';
import 'package:wash_x/custom/box-decoration-param.dart';
import 'package:flutter/cupertino.dart';

class Preferences extends StatefulWidget {
  @override
  _PreferencesState createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  @override
  Widget build(BuildContext context) {
    bool _switchValue = false;
    return new Scaffold(
      body: Stack(
        children: <Widget>[
          new Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              decoration:
                  new BoxBorderParam(20.0, 20.0, 20.0, 20.0, Colors.black, 4.0)
                      .getBoxDecoration(),
              height: 300.0,
              width: 220.0,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      new Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: new Container(
                            decoration: new BoxBorderParam(
                                    10.0, 10.0, 10.0, 10.0, Colors.black, 4.0)
                                .getBoxDecoration(),
                            height: 15.0,
                            width: 70.0,
                          )),
                      new Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0,
                                  top: 2.0,
                                  right: 2.0,
                                  bottom: 2.0),
                              child: new Container(
                                decoration: new BoxBorderParam(50.0, 50.0, 50.0,
                                        50.0, Colors.black, 4.0)
                                    .getBoxDecoration(),
                                height: 15.0,
                                width: 15.0,
                              )),
                          new Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: new Container(
                                decoration: new BoxBorderParam(50.0, 50.0, 50.0,
                                        50.0, Colors.black, 4.0)
                                    .getBoxDecoration(),
                                height: 15.0,
                                width: 15.0,
                              )),
                          new Padding(
                            padding: const EdgeInsets.only(
                                left: 2.0, top: 2.0, right: 8.0, bottom: 2.0),
                            child: new Container(
                              decoration: new BoxBorderParam(
                                      50.0, 50.0, 50.0, 50.0, Colors.black, 4.0)
                                  .getBoxDecoration(),
                              height: 15.0,
                              width: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  new Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0)),
                  new Container(
                      height: 100.0,
                      width: 100.0,
                      padding: const EdgeInsets.all(8.0),
                      decoration: new BoxBorderParam(
                              50.0, 50.0, 50.0, 50.0, Colors.black, 4.0)
                          .getBoxDecoration()),
                ],
              ),
            ),
          ),
          new Positioned(
            bottom: 0.0,
            child: new SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 370.0,
              child: new SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 2.0,
                        )
                      ]),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Center(
                        child: new Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Container(
                            width: 40.0,
                            height: 5.0,
                            decoration: BoxDecoration(
                                color: Colors.grey[400],
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Text('PICKUP & DROP OFF',
                            style: new TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent)),
                      ),
                      new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text('Address',
                                style: new TextStyle(
                                    fontSize: 13.0, color: Colors.grey[700])),
                            new Text(
                                '3085 Linton Ave, Montreal, QC, CA H35 1S4',
                                style: new TextStyle(
                                    fontSize: 13.0, color: Colors.grey[700])),
                          ],
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text('Time & Day',
                                style: new TextStyle(
                                    fontSize: 13.0, color: Colors.grey[700])),
                            new Text('Tuesday, Evening',
                                style: new TextStyle(
                                    fontSize: 13.0, color: Colors.grey[700])),
                          ],
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text('Frequency',
                                style: new TextStyle(
                                    fontSize: 13.0, color: Colors.grey[700])),
                            new Text('Frequency',
                                style: new TextStyle(
                                    fontSize: 13.0, color: Colors.grey[700])),
                          ],
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text('Auto Order',
                                style: new TextStyle(
                                    fontSize: 13.0, color: Colors.grey[700])),
                            new Text('Auto Order',
                                style: new TextStyle(
                                    fontSize: 13.0, color: Colors.grey[700])),
                          ],
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text('Speed',
                                style: new TextStyle(
                                    fontSize: 13.0, color: Colors.grey[700])),
                            new Text('Speed',
                                style: new TextStyle(
                                    fontSize: 13.0, color: Colors.grey[700])),
                          ],
                        ),
                      ),
                      new Divider(height: 1.5, color: Colors.grey[400]),
                      new Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, left: 8.0, bottom: 15.0),
                        child: new Text('NOTIFICATION',
                            style: new TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent)),
                      ),
                      new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text('Notification',
                                style: new TextStyle(
                                    fontSize: 13.0, color: Colors.grey[700])),
                            new Chip(
                              label: new Text(
                                'Weekly',
                                style: new TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.blueAccent,
                            ),
                          ],
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text('Do Not Disturb',
                                style: new TextStyle(
                                    fontSize: 13.0, color: Colors.grey[700])),
                            Semantics(
                              container: true,
                              child: Column(
                                children: <Widget>[
                                  CupertinoSwitch(
                                    value: _switchValue,
                                    onChanged: (bool value) {
                                      setState(() {
                                        _switchValue = value;
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Divider(height: 1.5, color: Colors.grey[400]),
                      new Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, left: 8.0, bottom: 15.0),
                        child: new Text('SUBSCRIPTION',
                            style: new TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent)),
                      ),
                      new Divider(height: 1.5, color: Colors.grey[400]),
                      new Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, left: 8.0, bottom: 15.0),
                        child: new Text('PAYMENT',
                            style: new TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent)),
                      ),
                      new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text('Deault',
                                style: new TextStyle(
                                    fontSize: 13.0, color: Colors.grey[700])),
                           new Container(
                             width: 90.0,
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: [
                                      new BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 1.0,
                                      )
                                    ]),
                                child: Image.asset(
                                  'assets/google_pay.png',
                                  height: 18.0,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
