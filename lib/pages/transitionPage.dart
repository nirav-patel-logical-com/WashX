
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class WashFillPage extends StatefulWidget {
  @override
  _WashFillPageState createState() => new _WashFillPageState();
}

class _WashFillPageState extends State<WashFillPage>
    with SingleTickerProviderStateMixin {
  //  var page;

  AnimationController controller;
  Animation<double> animatedHeight;
  var tt=1000.0;

  @override
  void initState() {
    super.initState();

    controller =
        new AnimationController(vsync: this, duration: Duration(seconds: 20));

    controller.addListener(() {
      setState(() {});
    });
    animatedHeight = new Tween<double>(
      begin: 0.0,
      end: tt,
    ).animate(new CurvedAnimation(parent: controller, curve: Curves.ease));
    controller.forward();
  }



  _buildMainLogo() {
    return new Column(
      children: <Widget>[
        new Expanded(
          flex: 1,
          child: new Container(),
        ),
        new Expanded(
            flex: 6,
            child: new Stack(
              children: <Widget>[
                _buildmachine(),
                _buildColourFiller(),
                _buildmachineColoured()
              ],
            )),
        new Expanded(
          flex: 1,
          child: new Container(),
        ),
     
      ],
    );
  }

  _buildColourFiller() {
    setState(() {
     tt = MediaQuery.of(context).size.height / 5;        
        });
    return new Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), color: Colors.blue),
           height: animatedHeight.value < tt ? animatedHeight.value : tt,
          width: double.infinity,
        )
      ],
    );
  }

  _buildmachineColoured() {
    return new Container(
      margin: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6.5)),
        color: Colors.transparent,
       
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

          //   new CircleAvatar(
          //     radius: 1000.0,
          //     backgroundColor: Colors.white,
          //   ),

          new Expanded(
            flex: 4,
            child: new Container(),
          ),
        ],
      ),
    );
  }

  _buildmachine() {
    return new Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 3.0),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: Colors.white,
         boxShadow: [
          new BoxShadow(
            blurRadius: 5.0,
            color: Colors.grey,
            offset: Offset(5.0, 5.0)
          )

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
                              decoration: new BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black, width: 1.5),
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
                          child: new CircleAvatar(
                            child: new Container(
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.black, width: 1.5)),
                            ),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        new Expanded(
                          flex: 2,
                          child: new Container(),
                        ),
                        new Expanded(
                          flex: 3,
                          child: new CircleAvatar(
                            backgroundColor: Colors.white,
                            child: new Container(
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.black, width: 1.5)),
                            ),
                          ),
                        ),
                        new Expanded(
                          flex: 2,
                          child: new Container(),
                        ),
                        new Expanded(
                          flex: 3,
                          child: new CircleAvatar(
                            backgroundColor: Colors.white,
                            child: new Container(
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.black, width: 1.5)),
                            ),
                          ),
                        ),
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
            child: new CircleAvatar(
              child: new Container(
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 3.0)),
              ),
              radius: 1000.0,
              backgroundColor: Colors.white,
            ),
          ),
          new Expanded(
            flex: 4,
            child: new Container(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Container(
        color: Colors.white,
        child: new Row(
          children: <Widget>[
            new Expanded(
              flex: 2,
              child: new Container(),
            ),
            new Expanded(
              flex: 3,
              child: _buildMainLogo(),
            ),
            new Expanded(
              flex: 2,
              child: new Container(),
            ),
          ],
        ),
      ),
    );
  }
}
