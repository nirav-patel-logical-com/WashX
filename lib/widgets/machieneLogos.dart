import 'dart:math';

import 'package:flutter/material.dart';

class MachieneLogo {
  static Widget buildWashBasket() {
    return new Stack(
      children: <Widget>[buildBottomLayer(), buildTopLayer()],
    );
  }

  static buildTopLayer() {
    return new Container(
        child: Transform.rotate(
      angle: pi / 2,
      child: new Row(
        children: <Widget>[
          new Expanded(flex: 1, child: new Container()),
          new Expanded(
            flex: 16,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Expanded(
                  flex: 3,
                  child: new Container(),
                ),
                new Expanded(
                  flex: 1,
                  child: new Transform.rotate(
                    angle: 0.20,
                    child: new Container(
                      decoration: new BoxDecoration(color: Colors.black),
                    ),
                  ),
                ),
                new Expanded(
                  flex: 3,
                  child: new Container(),
                ),
                new Expanded(
                  flex: 1,
                  child: new Transform.rotate(
                    angle: 0.10,
                    child: new Container(
                      decoration: new BoxDecoration(color: Colors.black),
                    ),
                  ),
                ),
                new Expanded(
                  flex: 3,
                  child: new Container(),
                ),
                new Expanded(
                  flex: 1,
                  child: new Container(
                    decoration: new BoxDecoration(color: Colors.black),
                  ),
                ),
                new Expanded(
                  flex: 3,
                  child: new Container(),
                ),
                new Expanded(
                  flex: 1,
                  child: new Transform.rotate(
                    angle: -0.10,
                    child: new Container(
                      decoration: new BoxDecoration(color: Colors.black),
                    ),
                  ),
                ),
                new Expanded(
                  flex: 3,
                  child: new Container(),
                ),
                new Expanded(
                  flex: 1,
                  child: new Transform.rotate(
                    angle: -0.20,
                    child: new Container(
                      decoration: new BoxDecoration(color: Colors.black),
                    ),
                  ),
                ),
                new Expanded(
                  flex: 3,
                  child: new Container(),
                ),
              ],
            ),
          ),
          new Expanded(flex: 1, child: new Container()),
        ],
      ),
    ));
  }

  static buildBottomLayer() {
    return new Column(
      children: <Widget>[
        new Expanded(
          flex: 1,
          child: new Row(
            children: <Widget>[
              new Expanded(
                flex: 1,
                child: new Container(),
              ),
              new Expanded(
                flex: 20,
                child: new Container(
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      color: Colors.black),
                ),
              ),
              new Expanded(
                flex: 1,
                child: new Container(),
              ),
            ],
          ),
        ),
        new Expanded(
          flex: 3,
          child: new Container(),
        ),
        new Expanded(
          flex: 1,
          child: new Row(
            children: <Widget>[
              new Expanded(
                flex: 1,
                child: new Container(),
              ),
              new Expanded(
                flex: 5,
                child: new Container(
                  decoration: new BoxDecoration(color: Colors.black),
                ),
              ),
              new Expanded(
                flex: 1,
                child: new Container(),
              ),
            ],
          ),
        ),
        new Expanded(
          flex: 3,
          child: new Container(),
        ),
        new Expanded(
          flex: 1,
          child: new Row(
            children: <Widget>[
              new Expanded(
                flex: 1,
                child: new Container(),
              ),
              new Expanded(
                flex: 4,
                child: new Container(
                  decoration: new BoxDecoration(color: Colors.black),
                ),
              ),
              new Expanded(
                flex: 1,
                child: new Container(),
              ),
            ],
          ),
        ),
        new Expanded(
          flex: 3,
          child: new Container(),
        ),
        new Expanded(
          flex: 1,
          child: new Row(
            children: <Widget>[
              new Expanded(
                flex: 2,
                child: new Container(),
              ),
              new Expanded(
                flex: 5,
                child: new Container(
                  decoration: new BoxDecoration(color: Colors.black),
                ),
              ),
              new Expanded(
                flex: 2,
                child: new Container(),
              ),
            ],
          ),
        ),
        new Expanded(
          flex: 3,
          child: new Container(),
        ),
        new Expanded(
          flex: 1,
          child: new Row(
            children: <Widget>[
              new Expanded(
                flex: 2,
                child: new Container(),
              ),
              new Expanded(
                flex: 4,
                child: new Container(
                  decoration: new BoxDecoration(color: Colors.black),
                ),
              ),
              new Expanded(
                flex: 2,
                child: new Container(),
              ),
            ],
          ),
        ),
        new Expanded(
          flex: 3,
          child: new Container(),
        ),
        new Expanded(
          flex: 1,
          child: new Row(
            children: <Widget>[
              new Expanded(
                flex: 6,
                child: new Container(),
              ),
              new Expanded(
                flex: 11,
                child: new Container(
                  decoration: new BoxDecoration(color: Colors.black),
                ),
              ),
              new Expanded(
                flex: 6,
                child: new Container(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget logoColoured() {
    return new Container(
      margin: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6.5)),
        color: Colors.blue,
        boxShadow: [
          new BoxShadow(
              blurRadius: 5.0, color: Colors.grey, offset: Offset(5.0, 5.0))
        ],
      ),
      child: new Column(
        children: <Widget>[
          new Expanded(
            flex: 2,
            child: new Container(
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    flex: 3,
                    child: new Container(),
                  ),
                  new Expanded(
                      flex: 4,
                      child: new Column(
                        children: <Widget>[
                          new Expanded(
                            flex: 5,
                            child: new Container(),
                          ),
                          new Expanded(
                            flex: 5,
                            child: new Container(
                              margin: EdgeInsets.all(1.5),
                              decoration: new BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0)),
                                  color: Colors.white),
                            ),
                          ),
                          new Expanded(
                            flex: 5,
                            child: new Container(),
                          ),
                        ],
                      )),
                  new Expanded(
                    flex: 3,
                    child: new Container(),
                  ),
                  new Expanded(
                    flex: 5,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        new Expanded(
                            flex: 3,
                            child: new Container(
                              margin: EdgeInsets.all(1.5),
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            )),
                        new Expanded(
                          flex: 2,
                          child: new Container(),
                        ),
                        new Expanded(
                            flex: 3,
                            child: new Container(
                              margin: EdgeInsets.all(1.5),
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            )),
                        new Expanded(
                          flex: 2,
                          child: new Container(),
                        ),
                        new Expanded(
                            flex: 3,
                            child: new Container(
                              margin: EdgeInsets.all(1.5),
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            )),
                        new Expanded(
                          flex: 4,
                          child: new Container(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          new Expanded(
            flex: 3,
            child: new Container(),
          ),
          new Expanded(
              flex: 6,
              child: new Container(
                margin: EdgeInsets.all(3.0),
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              )),
          new Expanded(
            flex: 4,
            child: new Container(),
          ),
        ],
      ),
    );
  }
}
