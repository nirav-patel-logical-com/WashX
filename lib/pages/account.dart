import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _twoStepAuth = false;
  bool _isUserName = false;
  bool _isEmail = false;
  bool _isPassword = false;

  final TextEditingController _userName = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  VoidCallback _showPersBottomSheetCallBack;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _showPersBottomSheetCallBack = _showBottomSheet;
  }

  void _showBottomSheet() {
    setState(() {
      _showPersBottomSheetCallBack = null;
    });

    _scaffoldKey.currentState
        .showBottomSheet((context) {
          return new StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return new Container(
              color: Colors.white,
              child:
                  new Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                new Container(
//          padding: new EdgeInsets.only(top: 20.0, left: 60.0, right: 60.0),
                  decoration: new BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16.0),
                          topLeft: Radius.circular(16.0))),
                  padding: new EdgeInsets.only(top: 0.5),
                  child: new Container(
                    padding:
                        new EdgeInsets.only(top: 20.0, left: 50.0, right: 20.0),
//              padding: new EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 0.0),
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(16.0),
                            topLeft: Radius.circular(16.0))),
                    child: new SingleChildScrollView(
                      child: new Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new CircleAvatar(
                                backgroundImage: new NetworkImage(
                                    'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?cs=srgb&dl=black-and-white-fun-happy-91227.jpg&fm=jpg'),
                                radius: 25.0,
                              ),
                              new Expanded(
                                  child: new Container(
                                      padding: new EdgeInsets.only(left: 20.0),
                                      child: new Text(
                                        "Mendy Marcus",
//                                    textAlign: TextAlign.center,
                                        style: new TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 20.0),
                                      )))
                            ],
                          ),
                          new Container(
                              margin:
                                  new EdgeInsets.only(top: 14.0, left: 13.0),
                              child: new Form(
                                child: new Column(
                                  children: <Widget>[
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15.0),
                                      child: Row(
                                        children: <Widget>[
                                          new Container(
                                            child: new Icon(Icons.person_pin),
                                          ),
                                          new Expanded(
                                            child: new Container(
                                              padding:
                                                  EdgeInsets.only(left: 20.0),
                                              child: InkWell(
                                                onTap: ()=> debugPrint("test"),
                                                child: Text(
                                                  "mendymarcus",
                                                  style: TextStyle(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15.0),
                                      child: Row(
                                        children: <Widget>[
                                          new Container(
                                            child: new Icon(Icons.mail),
                                          ),
                                          new Expanded(
                                            child: new Container(
                                              padding:
                                                  EdgeInsets.only(left: 20.0),
                                              child: Text(
                                                "mendymarcus@gmail.com",
                                                style: TextStyle(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15.0),
                                      child: Row(
                                        children: <Widget>[
                                          new Container(
                                            child: new Icon(Icons.lock),
                                          ),
                                          new Expanded(
                                            child: new Container(
                                              padding:
                                                  EdgeInsets.only(left: 20.0),
                                              child: Text(
                                                "*******",
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding:
                                      EdgeInsets.symmetric(vertical: 0.0),
                                      child: Row(
                                        children: <Widget>[
                                          new Container(
                                            child: new Icon(Icons.verified_user),
                                          ),
                                          new Expanded(
                                            child: new SwitchListTile(
                                              value: _twoStepAuth,
                                              onChanged: (bool newValue) {
                                                setState(() {
                                                  _twoStepAuth = newValue;
                                                });
                                              },
                                              title: new Text("Two-Step Verification", style: TextStyle(fontSize: 14.0),),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        //  new SwitchListTile(
                        //    value: _twoStepAuth,
                        //    onChanged: (bool newValue) {
                        //      setState(() {
                        //        _twoStepAuth = newValue;
                        //      });
                        //    },
                        //    title: new Text("Two-Step Verification", style: TextStyle(fontSize: 14.0),),
                        //    secondary: Padding(
                        //      padding: const EdgeInsets.symmetric(vertical: 0.0),
                        //      child: Icon(Icons.verified_user),
                        //    ),
                        //  ),
                        ],
                      ),
                    ),
                  ),
                ),
                new Divider(
                  height: 16.0,
                  color: Colors.red.shade900,
                  indent: 0.0,
                ),
                new Container(
                  padding: new EdgeInsets.all(5.0),
                  child: new MaterialButton(
                    onPressed: () => {},

                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        new Padding(padding: EdgeInsets.only(left: 20.0,)),
                        new Icon(
                          Icons.delete,
                          color: Colors.red.shade900,
                        ),
                        new Padding(padding: EdgeInsets.only(left: 20.0)),
                        new Text(
                          "Delete Account",
                          style: TextStyle(color: Colors.red.shade900),
                        )
                      ],
                    ),
                  ),
                ),
              ]),
            );
          });
        })
        .closed
        .whenComplete(() {
          if (mounted) {
            setState(() {
              _showPersBottomSheetCallBack = _showBottomSheet;
            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
        child: new Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Center(
            child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new RaisedButton(
              onPressed: _showPersBottomSheetCallBack,
              child: new Text("Account"),
            ),
          ],
        )),
      ),
    ));
  }
}
